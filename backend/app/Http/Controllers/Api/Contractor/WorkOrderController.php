<?php

namespace App\Http\Controllers\Api\Contractor;

use App\Models\ContractorUser;
use App\Models\SiteLocation;
use App\Models\TaskImage;
use App\Models\WorkCategory;
use App\Models\WorkOrder;
use App\Models\WorkPart;
use App\Models\WorkTask;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class WorkOrderController extends Controller
{
    protected $order, $category, $location;

    /**
     * WorkOrderController constructor.
     */
    public function __construct()
    {
        $this->order = new WorkOrder();
        $this->category = new WorkCategory();
        $this->location = new SiteLocation();
    }

    /**
     * Fetch all work orders by role
     *
     * @param Request $request
     * @return array
     */
    public function index(Request $request)
    {
        $orders = $this->order->getWorkOrders($request);
        return $this->makeResponse('', ['work_orders' => $orders], 200);
    }

    /**
     * Get work order details by id
     *
     * @param Request $request
     * @return array
     */
    public function show($id)
    {
        $order = $this->order->getWorkOrderById($id);
        if ($order) {
            return $this->makeResponse('', ['work_order' => $order], 200);
        } else {
            return $this->makeError('Work order not found !', [], 401);
        }
    }

    /**
     * Add work order
     *
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(Request $request)
    {
        $role = $request->user()->getRoleNames()[0];
        if ($role === 'Contractor admin') {
            $companyId = $request->user()->hasCompany->company_user_id;
        } else {
            $contractorAdminId = $request->user()->hasContractor->contractor_user_id;
            $contractorAdmin = ContractorUser::with('hasCompany')->find($contractorAdminId);
            $companyId = $contractorAdmin->hasCompany->company_user_id;
        }
        if (!$this->checkSubscriptionsLimits($companyId, 'work_orders')) {
            return $this->makeError('Limit exceeded !', [], 401);
        }

        $this->validate($request, [
            'title' => 'required',
            'description' => 'required',
            'site_location_id' => 'required',
            'quote_required' => 'required'
        ]);

        $workOrder = $request->user()->orders()->create([
            'service_request_id' => $this->generateUniqueNumber(),
            'quote_required' => $request->quote_required ?? 0,
            'site_location_id' => $request->site_location_id,
            'purchase_order_number' => $request->purchase_order_number != '' ? '#'.$request->purchase_order_number : '',
            'assign_to' => $request->user()->id,
            'title' => $request->title,
            'description' => $request->description
        ]);

        $data = [
            'subject' => 'Work order created',
            'message' => 'New work order created by '.$request->user()->profile->name,
            'name' => $request->user()->hasCompany->company->name
        ];
        $this->sendSubscriptionMail($request->user()->hasCompany->company->email, $data);

        return $this->makeResponse('Work order created successful.', ['work_order' => $this->order->getWorkOrderById($workOrder->id)], 201);
    }

    /**
     * Update work order
     *
     * @param $id
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function update($id, Request $request)
    {
        $order = WorkOrder::find($id);
        if (!$order) {
            return $this->makeError('Work order not found !', [], 401);
        }
        if ($request->parts) {
            WorkPart::where('work_order_id', $id)->delete();
            foreach ($request->parts as $part) {
                if ($part['name'] != '' && $part['price'] != '') {
                    $request->user()->parts()->create([
                        'name' => $part['name'],
                        'price' => $part['price'],
                        'work_order_id' => $id
                    ]);
                }
            }
            $message = 'Required parts and cost added to work order.';
        } else {
            $order->update($request->all());
            $message = 'Work order updated successful.';
        }
        return $this->makeResponse($message, ['work_order' => $this->order->getWorkOrderById($id)], 201);
    }

    /**
     * Delete work order
     *
     * @param $id
     * @return array
     */
    public function destroy($id)
    {
        $order = WorkOrder::find($id);
        if (!$order) {
            return $this->makeError('Work order not found !', [], 401);
        }
        $order->delete();
        return $this->makeResponse('Work order deleted successful.', ['id' => $id], 201);
    }

    /**
     * Add tasks to work order
     *
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function storeTask(Request $request)
    {
        $this->validate($request, [
            'title' => 'required',
            'description' => 'required',
            'work_order_id' => 'required',
            'work_category_id' => 'required',
            'work_priority_id' => 'required'
        ]);

        $task = $request->user()->tasks()->create([
            'title' => $request->title,
            'description' => $request->description,
            'work_order_id' => $request->work_order_id,
            'work_category_id' => $request->work_category_id,
            'work_priority_id' => $request->work_priority_id,
            'company_notes' => '',
            'contractor_notes' => '',
        ]);

        if ($request->images) {
            foreach ($request->images as $image) {
                $taskImage = new TaskImage();
                $taskImage->work_task_id = $task->id;
                $taskImage->path = $this->saveBase64File('tasks/', $image['path']);
                $taskImage->save();
            }
        }

        return $this->makeResponse('Task added to work order.', ['work_order' => $this->order->getWorkOrderById($request->work_order_id)], 201);
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateTask($id, Request $request)
    {
        $this->validate($request, [
            'work_order_id' => 'required'
        ]);

        $task = WorkTask::find($id);
        if (!$task) {
            return $this->makeError('Task not found !', [], 401);
        }
        $task->update($request->except(['work_order_id', 'id']));
        return $this->makeResponse('Note added to task.', ['work_order' => $this->order->getWorkOrderById($request->work_order_id)], 201);
    }

    /**
     * add comments to work order task
     *
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function storeComment(Request $request)
    {
        $this->validate($request, [
            'work_task_id' => 'required',
            'work_order_id' => 'required'
        ]);

        if ($request->images) {
            foreach ($request->images as $image) {
                $taskImage = new TaskImage();
                $taskImage->work_task_id = $request->work_task_id;
                $taskImage->path = $this->saveBase64File('tasks/', $image['path']);
                $taskImage->save();
            }
            $message = 'Photos added to task.';
        } else {
            $request->user()->comments()->create([
                'work_task_id' => $request->work_task_id,
                'message' => $request->message ?? ''
            ]);
            $message = 'Comment added to task.';
        }

        return $this->makeResponse($message, ['work_order' => $this->order->getWorkOrderById($request->work_order_id)], 201);
    }

    /**
     * @param Request $request
     * @return array
     */
    public function getCategories(Request $request)
    {
        return $this->makeResponse('',['categories' => $this->category->getCategories($request)], 200);
    }

    /**
     * @param Request $request
     * @return array
     */
    public function getLocations(Request $request)
    {
        return $this->makeResponse('',['locations' => $this->location->getLocations($request)], 200);
    }
}

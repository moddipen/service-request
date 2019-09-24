<?php

namespace App\Http\Controllers\Api\Admin;

use App\Models\ContractorUser;
use App\Models\WorkOrder;
use App\Models\ServicerequestImage;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class WorkOrderController extends Controller
{
    protected $order;

    /**
     * WorkOrderController constructor.
     */
    public function __construct()
    {
        $this->order = new WorkOrder();
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
        if ($request->assign_to) {
            $contractor = ContractorUser::find($request->assign_to);
            $data = [
                'subject' => 'Service Request',
                'url' => config('app.url').'/app/work-orders/'.$id,
                'message' => $request->user()->profile->name.' has created a Service Request at',
                'name' => $contractor->profile->name
            ];


            $this->sendSubscriptionMail($contractor->email, $data, 'assign');
        }
        $order->update($request->all());      

        //if images are available
        if ($request->images) {
            $ServicerequestImage = new ServicerequestImage();
            ServicerequestImage::where('service_request_id', $id)->delete();

            foreach ($request->images as $image) {
                $ServicerequestImage = new ServicerequestImage();
                $ServicerequestImage->service_request_id = $id;
                $ServicerequestImage->path = $this->saveBase64File('workorders/', $image['path']);
                $ServicerequestImage->save();
            }
        }

        return $this->makeResponse('Work order updated successful.', ['work_order' => $this->order->getWorkOrderById($id)], 201);
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
}

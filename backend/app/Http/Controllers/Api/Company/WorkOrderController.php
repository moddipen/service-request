<?php
namespace App\Http\Controllers\Api\Company;
use App\Models\CompanyUser;
use App\Models\ContractorUser;
use App\Models\TaskImage;
use App\Models\ServicerequestImage;
use App\Models\WorkOrder;
use App\Models\WorkTask;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\WorkTaskComment;
use DB;

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

    


    public  function deleteTaskPhoto($id)
    {   
        $id = 'tasks/'.$id;
        $order = TaskImage::where('path',$id)->first();
       
        if (!$order) {
            return $this->makeError('Work order task image not found !', [], 401);
        }
        DB::table('task_images')->delete($order->id);
        $SR = WorkTask::select('work_order_id')->where('id',$order->work_task_id)->first();
        return $this->makeResponse('Work order task image deleted successful.', ['work_order' =>$this->order->getWorkOrderById($SR->work_order_id)], 201);
    }

    public  function deletePhoto($id)
    {
        $order = ServicerequestImage::find($id);
       
        if (!$order) {
            return $this->makeError('Work order image not found !', [], 401);
        }
        $order->delete();
       
        return $this->makeResponse('Work order image deleted successful.', ['work_order' =>$this->order->getWorkOrderById($order->service_request_id)], 201);
    }

     public function updateComment(Request $request){
      
        $this->validate($request, [
            'work_order_id' => 'required',
            'id' => 'required',
            'message' => 'required'
        ]);

        $order = WorkTaskComment::find($request->id);
        if (!$order) {
            return $this->makeError('Comment not found !', [], 401);
        }

        WorkTaskComment::where('id', $request->id)
        ->update([
           'message' => $request->message
        ]);

        return $this->makeResponse('Comment updated successful.', ['work_order' => $this->order->getWorkOrderById($request->work_order_id)], 201);
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
       // echo "<pre>"; print_r($orders); exit;
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

        $authId = $request->user()->id;
        $role = $request->user()->getRoleNames()[0];
        if ($role === 'Company admin') {
            $companyId = $authId;
        } else if ($role === 'Site admin' || $role === 'Company editor') {
            $companyId = $request->user()->hasCompany->company_user_id;
        } else {
            $siteAdminId = $request->user()->hasCompany->company_user_id;
            $siteAdmin = CompanyUser::with('hasCompany')->find($siteAdminId);
            $companyId = $siteAdmin->hasCompany->company_user_id;
        }
        if (!$this->checkSubscriptionsLimits($companyId, 'work_orders')) {
            return $this->makeError('Limit exceeded !', [], 401);
        }
        $this->validate($request, [
            'title' => 'required',
            'description' => 'required',
            'site_location_id' => 'required',
            'quote_required' => 'required',
            'order_priority_id' => 'required'
        ]);
        
        //service request logic
        $searchTerm = 'RYCI-';
        $like = WorkOrder::where('service_request_id','LIKE','%' . $searchTerm. '%' )->orderBy('id', 'desc')->first(); 
            
        if($like){
            $Srid = explode('-',$like->service_request_id);
            $Srid1 = (int)$Srid[1] + 1;
            $sr = strlen($Srid1);
            if($sr == '4'){
                $zero = '00';
            }elseif($sr == '5'){
                $zero = '0';
            }else{
                $zero = '';
            }
            $service_request_id = $searchTerm.''.$zero.''.$Srid1;
        }else{
            $service_request_id = 'RYCI-001000';
        }

        $workOrder = $request->user()->orders()->create([
            'service_request_id' => $service_request_id,
            'quote_required' => $request->quote_required ?? 0,
            'site_location_id' => $request->site_location_id,
            'purchase_order_number' => $request->purchase_order_number != '' ? '#'.$request->purchase_order_number : '',
            'title' => $request->title,
            'description' => $request->description,
            'order_priority_id' => $request->order_priority_id,
        ]);

        if ($request->images) {
            foreach ($request->images as $image) {
                $ServicerequestImage = new ServicerequestImage();
                $ServicerequestImage->service_request_id = $workOrder->id;
                $ServicerequestImage->path = $this->saveBase64File('workorders/', $image['path']);
                $ServicerequestImage->save();
            }
        }


        $role = $request->user()->getRoleNames()[0];
        if ($role == 'Company admin') {
            $data = [
                'subject' => 'Work order created',
                'message' => 'New work order created by you.',
                'name' => $request->user()->profile->name
            ];
            $this->sendSubscriptionMail($request->user()->email, $data);
        } else {
            $data = [
                'subject' => 'Work order created',
                'message' => 'New work order created by '.$request->user()->profile->name,
                'name' => $request->user()->hasCompany->company->profile->name
            ];
            $this->sendSubscriptionMail($request->user()->hasCompany->company->email, $data);
        }

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
        if ($request->assign_to) {
            $contractor = ContractorUser::find($request->assign_to);
            $order = $this->order->getWorkOrderById($id);
          // echo "<pre>"; print_r($order); exit("sdfds");
            $data = [
                'subject' => 'Service Request',
                'url' => config('app.url').'/app/work-orders/'.$id,
                'message' => $request->user()->profile->name.' has created a Service Request at',
                'name' => $contractor->profile->name,
                'workOrder' => $order 
            ];
            
            $this->sendSubscriptionMail($contractor->email, $data, 'assign');
           
        }
        $order->update($request->all());
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
    public function updateTask ($id, Request $request){
        $this->validate($request, [
            'id' => 'required'
        ]);

        $task = WorkTask::find($id);
       
        if (!$task) {
            return $this->makeError('Task not found !', [], 401);
        }
        $task->update($request->except(['id']));

      
         if($request->images){
            $taskimage = new TaskImage();
            TaskImage::where('work_task_id', $id)->delete();
                   
            if ($request->images) {
                foreach ($request->images as $image) {
                    $task = new TaskImage();
                    $task->work_task_id = $id;
                    $task->path = $this->saveBase64File('tasks/', $image['path']);
                    $task->save();
                }
            }
        }
        return $this->makeResponse('Task updated successful.', ['work_order' => $this->order->getWorkOrderById($task->work_order_id)], 201);
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
     * Add required parts and cost to work order
     *
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function storeParts(Request $request)
    {
        $this->validate($request, [
            'parts' => 'required',
            'work_order_id' => 'required'
        ]);

        foreach ($request->parts as $part) {
            $request->user()->parts()->create([
                'name' => $part['name'],
                'price' => $part['price'],
                'work_order_id' => $request->work_order_id
            ]);
        }

        return $this->makeResponse('Required parts and cost added to work order.', ['work_order' => $this->order->getWorkOrderById($request->work_order_id)], 201);
    }
}

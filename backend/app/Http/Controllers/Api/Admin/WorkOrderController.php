<?php

namespace App\Http\Controllers\Api\Admin;

//use App\Models\User;
use App\Models\ContractorUser;
use App\Models\WorkOrder;
use App\Models\ServicerequestImage;
use App\Models\TaskImage;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\WorkCategory;
use App\Models\WorkTask;
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
         $this->category = new WorkCategory();
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

     public function getCategories(Request $request)
    {
        return $this->makeResponse('',['categories' => $this->category->getCategories($request)], 200);
    }

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
        
        //images logic
        if($request->images !== 'undefined'){
            $ServicerequestImage = new ServicerequestImage();
            ServicerequestImage::where('service_request_id', $id)->delete();
                   
            if ($request->images) {
                foreach ($request->images as $image) {
                    $ServicerequestImage = new ServicerequestImage();
                    $ServicerequestImage->service_request_id = $id;
                    $ServicerequestImage->path = $this->saveBase64File('workorders/', $image['path']);
                    $ServicerequestImage->save();
                }
            }
        }       

        return $this->makeResponse('Work order updated successful.', ['work_order' => $this->order->getWorkOrderById($id)], 201);
    }


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

    public function storeComment(Request $request)
    {
        $this->validate($request, [
            'work_task_id' => 'required',
            'work_order_id' => 'required'
        ]);
       
        $request->user()->comments()->create([
            'work_task_id' => $request->work_task_id,
            'message' => $request->message ?? ''
        ]);
        $message = 'Comment added to task.';
       

        return $this->makeResponse($message, ['work_order' => $this->order->getWorkOrderById($request->work_order_id)], 201);
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
     * Delete work order images
     *
     * @param $id
     * @return array
     */
    public  function deletePhoto($id)
    {
        $order = ServicerequestImage::find($id);
       
        if (!$order) {
            return $this->makeError('Work order image not found !', [], 401);
        }
        $order->delete();
       
        return $this->makeResponse('Work order image deleted successful.', ['work_order' =>$this->order->getWorkOrderById($order->service_request_id)], 201);
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

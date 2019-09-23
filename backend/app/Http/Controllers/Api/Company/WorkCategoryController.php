<?php

namespace App\Http\Controllers\Api\Company;

use App\Models\WorkCategory;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class WorkCategoryController extends Controller
{
    protected $category;

    /**
     * WorkOrderController constructor.
     */
    public function __construct()
    {
        $this->category = new WorkCategory();
    }

    /**
     * @param Request $request
     * @return array
     */
    public function index(Request $request)
    {
        return $this->makeResponse('',['categories' => $this->category->getCategories($request)], 200);
    }

    /**
     * @param $request
     * @return mixed
     */
    private function getCategories($request)
    {
        return WorkCategory::where('company_user_id', $request->user()->id)->get();
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required'
        ]);

        $category = new WorkCategory();
        $category->company_user_id = $request->user()->id;
        $category->name = $request->name;
        if ($category->save()) {
            return $this->makeResponse('Category added.',['categories' => $this->getCategories($request)], 201);
        } else {
            return $this->makeError('Oops, something went wrong !',[], 401);
        }
    }

    /**
     * @param Request $request
     * @param $id
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'name' => 'required'
        ]);

        $category = WorkCategory::find($id);
        if (!$category) {
            return $this->makeError('Oops, category not found !',[], 401);
        }
        $category->name = $request->name;
        if ($category->save()) {
            return $this->makeResponse('Category updated.',['categories' => $this->getCategories($request)], 201);
        } else {
            return $this->makeError('Oops, something went wrong !',[], 401);
        }
    }

    /**
     * @param Request $request
     * @param $id
     * @return array
     */
    public function destroy(Request $request, $id)
    {
        $category = WorkCategory::find($id);
        if (!$category) {
            return $this->makeError('Oops, category not found !',[], 401);
        }
        $category->delete();
        return $this->makeResponse('Category deleted.',['categories' => $this->getCategories($request)], 201);
    }
}

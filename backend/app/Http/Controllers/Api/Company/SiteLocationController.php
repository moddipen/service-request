<?php

namespace App\Http\Controllers\Api\Company;

use App\Models\SiteLocation;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class SiteLocationController extends Controller
{
    protected $location;

    /**
     * SiteLocationController constructor.
     */
    public function __construct()
    {
        $this->location = new SiteLocation();
    }

    /**
     * @return array
     */
    public function index(Request $request)
    {
        return $this->makeResponse('',['locations' => $this->location->getLocations($request)], 200);
    }

    /**
     * @param $request
     * @return mixed
     */
    private function getLocations($request)
    {
        return SiteLocation::where('company_user_id', $request->user()->id)->get();
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'city' => 'required',
            'postal_code' => 'required',
            'email' => 'required|email',
            'street' => 'required',
            'phone_number' => 'required'
        ]);

        $location = new SiteLocation();
        $location->company_user_id = $request->user()->id;
        $location->street = $request->street;
        $location->city = $request->city;
        $location->postal_code = $request->postal_code;
        $location->email = $request->email;
        $location->phone_number = $request->phone_number;

        if ($location->save()) {
            return $this->makeResponse('Location added.',['locations' => $this->getLocations($request)], 201);
        } else {
            return $this->makeError('Oops, something went wrong !',[], 401);
        }
    }

    /**
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $location = SiteLocation::find($id);

        if ($location) {
            return $this->makeResponse('',['location' => $location], 200);
        } else {
            return $this->makeError('Oops, location not found !',[], 401);
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
            'city' => 'required',
            'postal_code' => 'required',
            'email' => 'required|email',
            'street' => 'required',
            'phone_number' => 'required'
        ]);

        $location = SiteLocation::find($id);

        if (!$location) {
            return $this->makeError('Oops, location not found !',[], 401);
        }
        $location->street = $request->street;
        $location->city = $request->city;
        $location->postal_code = $request->postal_code;
        $location->email = $request->email;
        $location->phone_number = $request->phone_number;

        if ($location->save()) {
            return $this->makeResponse('Location updated.',['locations' => $this->getLocations($request)], 201);
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
        $location = SiteLocation::find($id);

        if (!$location) {
            return $this->makeError('Oops, location not found !',[], 401);
        }

        $location->delete();
        return $this->makeResponse('Location deleted.',['locations' => $this->getLocations($request)], 201);
    }
}

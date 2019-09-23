<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SiteLocation extends Model
{
    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function company()
    {
        return $this->belongsTo(CompanyUser::class, 'company_user_id');
    }

    /**
     * @param $request
     * @return array
     */
    public function getLocations($request)
    {
        $authId = $request->user()->id;
        $role = $request->user()->getRoleNames()[0];

        if ($role === 'Company admin') {
            $locations = SiteLocation::whereHas('company.hasCompany', function ($query) use ($authId) {
                return $query->where('company_user_id', '=', $authId);
            })->get();
        } else if ($role === 'Site admin') {
            $locations = SiteLocation::where('company_user_id', $authId)->get();
        } else if ($role === 'Contractor admin') {
            $companyAdminId = $request->user()->hasCompany->company_user_id;
            $locations = SiteLocation::whereHas('company.hasCompany', function ($query) use ($companyAdminId) {
                return $query->where('company_user_id', '=', $companyAdminId);
            })->get();
        } else if ($role === 'Site staff') {
            $siteAdminId = $request->user()->hasCompany->company_user_id;
            $locations = SiteLocation::where('company_user_id', $siteAdminId)->get();
        } else {
            $locations = [];
        }
        return $locations;
    }
}

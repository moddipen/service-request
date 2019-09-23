<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WorkCategory extends Model
{
    /**
     * @param $request
     * @return mixed
     */
    public function getCategories($request)
    {
        $authId = $request->user()->id;
        $role = $request->user()->getRoleNames()[0];

        if ($role === 'Company admin') {
            $categories = WorkCategory::where('company_user_id', $authId)->get();
        } else if ($role === 'Company editor' || $role === 'Site admin' || $role === 'Contractor admin'){
            $companyAdminId = $request->user()->hasCompany->company_user_id;
            $categories = WorkCategory::where('company_user_id', $companyAdminId)->get();
        } else if ($role === 'Site staff') {
            $siteAdminId = $request->user()->hasCompany->company_user_id;
            $siteAdmin = CompanyUser::with('hasCompany')->find($siteAdminId);
            $categories = WorkCategory::where('company_user_id', $siteAdmin->hasCompany->company_user_id)->get();
        } else if ($role === 'Contractor staff') {
            $contractorAdminId = $request->user()->hasContractor->contractor_user_id;
            $contractorAdmin = ContractorUser::with('hasCompany')->find($contractorAdminId);
            $categories = WorkCategory::where('company_user_id', $contractorAdmin->hasCompany->company_user_id)->get();
        } else {
            $categories = [];
        }

        return $categories;
    }
}

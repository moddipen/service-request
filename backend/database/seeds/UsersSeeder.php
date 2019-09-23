<?php

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\ContractorUser;
use App\Models\CompanyUser;
use App\Models\SiteUser;
use App\Models\CompanyHasUser;
use App\Models\CompanyHasContractorUser;
use App\Models\CompanyHasSiteUser;
use App\Models\ContractorHasUser;
use App\Models\SiteHasUser;

class UsersSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $admin = new User();
        $admin->name = 'Super Admin';
        $admin->email = 'sadmin@yopmail.com';
        $admin->password = bcrypt('sadmin');
        $admin->save();
        $admin->assignRole('Super admin');

        $cadmin = new CompanyUser();
        $cadmin->name = 'Company Admin';
        $cadmin->slug = 'company-admin';
        $cadmin->email = 'cadmin@yopmail.com';
        $cadmin->password = bcrypt('cadmin');
        $cadmin->save();
        $cadmin->assignRole('Company admin');

        $ceditor = new CompanyUser();
        $ceditor->name = 'Company Editor';
        $ceditor->slug = '';
        $ceditor->email = 'ceditor@yopmail.com';
        $ceditor->password = bcrypt('ceditor');
        $ceditor->save();
        $ceditor->assignRole('Company editor');
        $cuser = new CompanyHasUser();
        $cuser->company_user_id = $cadmin->id;
        $cuser->user_id = $ceditor->id;
        $cuser->save();

        $coadmin = new ContractorUser();
        $coadmin->name = 'Contractor Admin';
        $coadmin->email = 'coadmin@yopmail.com';
        $coadmin->password = bcrypt('coadmin');
        $coadmin->save();
        $coadmin->assignRole('Contractor admin');
        $cuser = new CompanyHasContractorUser();
        $cuser->company_user_id = $cadmin->id;
        $cuser->contractor_user_id = $coadmin->id;
        $cuser->save();

        $cstaff = new ContractorUser();
        $cstaff->name = 'Contractor Staff';
        $cstaff->email = 'cstaff@yopmail.com';
        $cstaff->password = bcrypt('cstaff');
        $cstaff->save();
        $cstaff->assignRole('Contractor staff');
        $cuser = new ContractorHasUser();
        $cuser->contractor_user_id = $coadmin->id;
        $cuser->user_id = $cstaff->id;
        $cuser->save();

        $sadmin = new SiteUser();
        $sadmin->name = 'Site Admin';
        $sadmin->email = 'sadmin@yopmail.com';
        $sadmin->password = bcrypt('sadmin');
        $sadmin->save();
        $sadmin->assignRole('Site admin');
        $cuser = new CompanyHasSiteUser();
        $cuser->company_user_id = $cadmin->id;
        $cuser->site_user_id = $sadmin->id;
        $cuser->save();

        $sstaff = new SiteUser();
        $sstaff->name = 'Site Staff';
        $sstaff->email = 'sstaff@yopmail.com';
        $sstaff->password = bcrypt('sstaff');
        $sstaff->save();
        $sstaff->assignRole('Site staff');
        $cuser = new SiteHasUser();
        $cuser->site_user_id = $sadmin->id;
        $cuser->user_id = $sstaff->id;
        $cuser->save();
    }
}

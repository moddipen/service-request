<?php

namespace App\Http\Controllers;

use App\Mail\Subscriptions;
use App\Mail\Invite;
use App\Models\CompanyUser;
use App\Models\SubscriptionPlan;
use App\Models\WorkOrder;
use Carbon\Carbon;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Mail;
use test\Mockery\AllowsExpectsSyntaxTest;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    /**
     * @param $string
     * @return string
     */
    public function encryptToBase64($string)
    {
        return base64_encode($string);
    }

    /**
     * @param $string
     * @return bool|string
     */
    public function decryptFromBase64($string)
    {
        return base64_decode($string);
    }

    /**
     * Generate success response for api
     *
     * @param string $message
     * @param mixed $data
     *
     * @return array
     */
    public function makeResponse($message = '', $data = [], $code = 200)
    {
        $res = [
            'success' => true,
            'data' => $data,
            'message' => $message,
            'code' => $code
        ];
        return response()->json($res);
    }

    /**
     * Generate error response for api
     *
     * @param string $message
     * @param array $data
     *
     * @return array
     */
    public function makeError($message = '', $data = [], $code = 410)
    {
        $res = [
            'success' => false,
            'message' => $message,
            'code' => $code
        ];
        if (!empty($data)) {
            $res['data'] = $data;
        }
        return response()->json($res);
    }

    /**
     * Convert file and save from base64 format
     *
     * @param $path
     * @param $content
     * @return string
     */
    public function saveBase64File($path, $content)
    {
        $filename = time() . mt_rand(1000, 9999);
        $fileContents = file_get_contents($content);
        File::put(storage_path('app/') . $path . $filename . ".jpg", $fileContents);
        return $path . $filename . ".jpg";
    }

    /**
     * Send all subscription related mails to users
     *
     * @param $email
     * @param $data
     * @return mixed
     */
    public function sendSubscriptionMail($email, $data, $type = 'general')
    {
        return Mail::to($email)->send(new Subscriptions($data, $type));
    }

    /**
     * Invite mail send to new users
     *
     * @param $email
     * @param $data
     * @return mixed
     */
    public function sendInviteMail($email, $data)
    {
        return Mail::to($email)->send(new Invite($data));
    }

    /**
     * Generate random unique id for orders
     *
     * @return int
     */
    public function generateUniqueNumber()
    {
        $number = '#' . mt_rand(1000000000, 9999999999);
        if ($this->uniqueNumberExists($number)) {
            return $this->generateUniqueNumber();
        }
        return $number;
    }

    /**
     * Check unique number already exist
     *
     * @param $number
     * @return mixed
     */
    private function uniqueNumberExists($number)
    {
        return WorkOrder::whereServiceRequestId($number)->exists();
    }

    /**
     * @param $id
     * @param string $type
     * @return bool
     */
    public function checkSubscriptionsLimits($id, $type = 'users')
    {
        $company = CompanyUser::find($id);
        $subscription = $company->subscription('main');
        $plan = SubscriptionPlan::where('stripe_id', $subscription->stripe_plan)->first();

        if ($type == 'users') {
            $count = 0;
            foreach ($company->hasUsers as $user) {
                if (!$user->user->deleted_at) {
                    $count++;
                    foreach ($user->user->hasUsers as $child) {
                        if (!$child->user->deleted_at) {
                            $count++;
                        }
                    }
                }
            }
            foreach ($company->hasContractors as $user) {
                if (!$user->user->deleted_at) {
                    $count++;
                    foreach ($user->user->hasUsers as $child) {
                        if (!$child->user->deleted_at) {
                            $count++;
                        }
                    }
                }
            }
            $this->notifyAboutPlanLimit($company, $plan->users, $count, $type);
            if ($count < $plan->users) {
                return true;
            } else {
                return false;
            }
        } else {
            $workOrders = WorkOrder::whereYear('created_at', Carbon::now()->year)->whereMonth('created_at', Carbon::now()->month)->whereHas('company', function ($query) use ($id) {
                return $query->where('id', '=', $id);
            })->orWhereHas('company.hasCompany', function ($query) use ($id) {
                return $query->where('company_user_id', '=', $id);
            })->orWhereHas('contractor.hasCompany', function ($query) use ($id) {
                return $query->where('company_user_id', '=', $id);
            })->count();
            $this->notifyAboutPlanLimit($company, $plan->work_orders, $workOrders, $type);
            if ($workOrders < $plan->work_orders) {
                return true;
            } else {
                return false;
            }
        }
    }

    /**
     * @param $user
     * @param $limit
     * @param $current
     * @param $type
     */
    private function notifyAboutPlanLimit($user, $limit, $current, $type)
    {
        $diff = (int)$limit - (int)$current;
        if ($diff <= 2) {
            if ($type == 'users') {
                $message = "Your plan limit exceeded, ".$diff." users available. Please upgrade your plan";
            } else {
                $message = "Your plan limit exceeded, ".$diff." work orders available for this month. Please upgrade your plan or wait till next month renewal.";
            }
            $data = [
                'subject' => 'Subscription limit',
                'message' => $message,
                'name' => $user->profile->name
            ];
            $this->sendSubscriptionMail($user->email, $data);
        }
    }
}

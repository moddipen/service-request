<?php

namespace App\Http\Controllers\Api\Company;

use App\Models\SubscriptionPlan;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Stripe\PaymentIntent;
use Stripe\Stripe;

class PaymentController extends Controller
{
    /**
     * @param Request $request
     * @return array
     */
    public function cancelSubscription(Request $request)
    {
        if ($request->user()->subscribed('main')) {
            if ($request->user()->subscription('main')->cancelled()) {
                return $this->makeError("Your subscription already cancelled!", [], 401);
            }
            $request->user()->subscription('main')->cancel();
            $data = [
                'subject' => 'Cancel Subscription',
                'message' => 'Your subscription cancelled successfully.',
                'name' => $request->user()->profile->name
            ];
            $this->sendSubscriptionMail($request->user()->email, $data);
            return $this->makeResponse('Your subscription cancelled successfully.', ['subscriptions' => $this->getDetails($request)], 201);
        } else {
            return $this->makeError("You dont have any subscription !", [], 401);
        }
    }

    public function checkPayment()
    {
        Stripe::setApiKey('sk_test_xu0WhGwPE9AXGKrGLFhQtuJa00CkK7zkrL');

        $intent = PaymentIntent::create([
            'amount' => 1099,
            'currency' => 'usd',
            'customer' => 'cus_FWVxOwxTuPJraz',
            'payment_method' => 'card_1F1SvFJpzPXIKh1GGUvUafhx',
            'payment_method_types' => ['card'],
            'off_session' => true,
            'confirm' => true,
        ]);

        echo '<pre>'; print_r($intent); exit;
    }

    /**
     * @param Request $request
     * @return array
     */
    public function resumeSubscription(Request $request)
    {
        if ($request->user()->subscription('main')->cancelled()) {
            $request->user()->subscription('main')->resume();
            $data = [
                'subject' => 'Resume Subscription',
                'message' => 'Your subscription resumed successfully.',
                'name' => $request->user()->profile->name
            ];
            $this->sendSubscriptionMail($request->user()->email, $data);
            return $this->makeResponse('Your subscription has been resumed.', ['subscriptions' => $this->getDetails($request)], 201);
        } else if ($request->user()->subscribed('main')){
            return $this->makeError("Your subscription already active !", [], 401);
        } else {
            return $this->makeError("Oops, something went wrong !", [], 401);
        }
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateSubscription(Request $request)
    {
        $this->validate($request, [
            'plan_id' => 'required'
        ]);
        $plan = SubscriptionPlan::find($request->plan_id);
        if ($request->user()->subscribedToPlan($plan->stripe_id, 'main')) {
            return $this->makeError('You have already subscribed same plan !', [], 401);
        }
        if ($request->user()->subscribed('main')) {
            $request->user()->subscription('main')->swap($plan->stripe_id);
            $data = [
                'subject' => 'Upgrade Subscription',
                'message' => 'Your subscription upgraded to '.$plan->name.'.',
                'name' => $request->user()->profile->name
            ];
            $this->sendSubscriptionMail($request->user()->email, $data);
            return $this->makeResponse('Your subscription plan has been updated.', ['subscriptions' => $this->getDetails($request)], 201);
        } else {
            return $this->makeError("You dont have any subscription !", [], 401);
        }
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateCardDetails(Request $request)
    {
        $this->validate($request, [
            'token' => 'required'
        ]);
        if (count($request->user()->cards())) {
            $request->user()->updateCard($request->token);
            $data = [
                'subject' => 'Card details updated',
                'message' => 'Your card details updated successfully.',
                'name' => $request->user()->profile->name
            ];
            $this->sendSubscriptionMail($request->user()->email, $data);
            return $this->makeResponse('Your card details has been updated.',['subscriptions' => $this->getDetails($request)], 201);
        } else {
            return $this->makeError("You dont have any card details added !", [], 401);
        }
    }

    /**
     * @param Request $request
     * @return array
     */
    public function invoices(Request $request)
    {
        $invoices = [];
        foreach ($request->user()->invoices() as $invoice) {
            $invoices[] = [
                'date' => $invoice->date()->toFormattedDateString(),
                'amount' => $invoice->total()
            ];
        }
        return $this->makeResponse('', ['invoices' => $invoices], 200);
    }

    /**
     * @param Request $request
     * @return array
     */
    public function getSubscriptionDetails(Request $request)
    {
        return $this->makeResponse('', ['subscriptions' => $this->getDetails($request)], 200);
    }

    /**
     * @param Request $request
     * @return mixed
     */
    public function getDetails(Request $request)
    {
        $subscription = $request->user()->subscription('main');
        $subscription->card_brand = $request->user()->card_brand;
        $subscription->card_last_four = $request->user()->card_last_four;
        return $subscription;
    }
}

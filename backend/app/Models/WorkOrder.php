<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WorkOrder extends Model
{
    protected $fillable = [
        'title',
        'description',
        'site_location_id',
        'quote_required',
        'contractor_quote_required',
        'service_request_id',
        'status',
        'assign_to',
        'company_cost',
        'contractor_cost',
        'purchase_order_number'
    ];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function tasks()
    {
        return $this->hasMany(WorkTask::class, 'work_order_id');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function location()
    {
        return $this->belongsTo(SiteLocation::class, 'site_location_id');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\MorphTo
     */
    public function creator()
    {
        return $this->morphTo('order_by')->withTrashed();
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function company()
    {
        return $this->belongsTo(CompanyUser::class, 'order_by_id')->where('order_by_type', CompanyUser::class);
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function contractor()
    {
        return $this->belongsTo(ContractorUser::class, 'order_by_id')->where('order_by_type', ContractorUser::class);
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function parts()
    {
        return $this->hasMany(WorkPart::class, 'work_order_id');
    }

    /**
     * @param $id
     * @return WorkOrder|WorkOrder[]|\Illuminate\Database\Eloquent\Builder|\Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection|Model|null
     */
    public function getWorkOrderById($id)
    {
        return WorkOrder::with([
            'tasks' => function ($query) {
                $query->select(['id', 'title', 'description', 'company_notes', 'company_notes', 'work_order_id', 'work_category_id', 'work_priority_id', 'added_by_type', 'added_by_id', 'contractor_notes', 'created_at']);
            },
            'tasks.category' => function ($query) {
                $query->select(['id', 'name']);
            },
            'tasks.priority' => function ($query) {
                $query->select(['id', 'name', 'description']);
            },
            'tasks.comments' => function ($query) {
                $query->select(['id', 'message', 'work_task_id', 'created_at', 'added_by_type', 'added_by_id']);
            },
            'tasks.comments.creator' => function ($query) {
                $query->select(['id', 'email']);
            },
            'tasks.comments.creator.profile' => function ($query) {
                $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
            },
            'tasks.creator' => function ($query) {
                $query->select(['id', 'email']);
            },
            'tasks.creator.profile' => function ($query) {
                $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
            },
            'location' => function ($query) {
                $query->select(['id', 'street', 'city', 'postal_code', 'email', 'phone_number']);
            },
            'creator' => function ($query) {
                $query->select(['id', 'email']);
            },
            'creator.profile' => function ($query) {
                $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
            },
            'parts' => function ($query) {
                $query->select(['id', 'name', 'price', 'work_order_id', 'created_at', 'added_by_type', 'added_by_id']);
            },
            'parts.creator' => function ($query) {
                $query->select(['id', 'email']);
            },
            'parts.creator.profile' => function ($query) {
                $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
            }
        ])->find($id);
    }

    /**
     * @param $request
     * @return WorkOrder[]|array|\Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection
     */
    public function getWorkOrders($request)
    {
        $authId = $request->user()->id;
        $role = $request->user()->getRoleNames()[0];

        if ($role === 'Company admin') {
            $workOrders = WorkOrder::with([
                'creator' => function ($query) {
                    $query->select(['id', 'email']);
                },
                'creator.profile' => function ($query) {
                    $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
                },
                'location' => function ($query) {
                    $query->select(['id', 'street', 'city', 'postal_code', 'email', 'phone_number']);
                }
            ])->whereHas('company', function ($query) use ($authId) {
                return $query->where('id', '=', $authId);
            })->orWhereHas('company.hasCompany', function ($query) use ($authId) {
                return $query->where('company_user_id', '=', $authId);
            })->orWhereHas('contractor.hasCompany', function ($query) use ($authId) {
                return $query->where('company_user_id', '=', $authId);
            })->orWhereHas('location.company.hasCompany', function ($query) use ($authId) {
                return $query->where('company_user_id', '=', $authId);
            })->get();
        } else if ($role === 'Company editor') {
            $companyAdminId = $request->user()->hasCompany->company_user_id;
            $workOrders = WorkOrder::with([
                'creator' => function ($query) {
                    $query->select(['id', 'email']);
                },
                'creator.profile' => function ($query) {
                    $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
                },
                'location' => function ($query) {
                    $query->select(['id', 'street', 'city', 'postal_code', 'email', 'phone_number']);
                }
            ])->whereHas('company', function ($query) use ($companyAdminId, $authId) {
                return $query->where('id', '=', $companyAdminId)->orWhere('id', '=', $authId);
            })->orWhereHas('company.hasCompany', function ($query) use ($companyAdminId) {
                return $query->where('company_user_id', '=', $companyAdminId);
            })->orWhereHas('contractor.hasCompany', function ($query) use ($companyAdminId) {
                return $query->where('company_user_id', '=', $companyAdminId);
            })->get();
        } else if ($role === 'Site admin') {
            $workOrders = WorkOrder::with([
                'creator' => function ($query) {
                    $query->select(['id', 'email']);
                },
                'creator.profile' => function ($query) {
                    $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
                },
                'location' => function ($query) {
                    $query->select(['id', 'street', 'city', 'postal_code', 'email', 'phone_number', 'company_user_id']);
                }
            ])->whereHas('company', function ($query) use ($authId) {
                return $query->where('id', '=', $authId);
            })->orWhereHas('location', function ($query) use ($authId) {
                return $query->where('company_user_id', '=', $authId);
            })->get();
        } else if ($role === 'Site staff') {
            $siteAdminId = $request->user()->hasCompany->company_user_id;
            $workOrders = WorkOrder::with([
                'creator' => function ($query) {
                    $query->select(['id', 'email']);
                },
                'creator.profile' => function ($query) {
                    $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
                },
                'location' => function ($query) {
                    $query->select(['id', 'street', 'city', 'postal_code', 'email', 'phone_number', 'company_user_id']);
                }
            ])->whereHas('company', function ($query) use ($siteAdminId, $authId) {
                return $query->where('id', '=', $siteAdminId)->orWhere('id', '=', $authId);
            })->orWhereHas('location', function ($query) use ($siteAdminId) {
                return $query->where('company_user_id', '=', $siteAdminId);
            })->get();
        } else if ($role === 'Contractor admin') {
            $workOrders = WorkOrder::with([
                'creator' => function ($query) {
                    $query->select(['id', 'email']);
                },
                'creator.profile' => function ($query) {
                    $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
                },
                'location' => function ($query) {
                    $query->select(['id', 'street', 'city', 'postal_code', 'email', 'phone_number', 'company_user_id']);
                }
            ])->where('assign_to', '=', $authId)->get();
        } else if ($role === 'Contractor staff') {
            $contractorAdminId = $request->user()->hasContractor->contractor_user_id;
            $workOrders = WorkOrder::with([
                'creator' => function ($query) {
                    $query->select(['id', 'email']);
                },
                'creator.profile' => function ($query) {
                    $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
                },
                'location' => function ($query) {
                    $query->select(['id', 'street', 'city', 'postal_code', 'email', 'phone_number', 'company_user_id']);
                }
            ])->where('assign_to', '=', $contractorAdminId)->get();
        } else if ($role === 'Super admin') {
            $workOrders = WorkOrder::with([
                'creator' => function ($query) {
                    $query->select(['id', 'email']);
                },
                'creator.profile' => function ($query) {
                    $query->select(['name', 'phone', 'photo', 'user_id', 'user_type']);
                },
                'location' => function ($query) {
                    $query->select(['id', 'street', 'city', 'postal_code', 'email', 'phone_number', 'company_user_id']);
                }
            ])->get();
        } else {
            $workOrders = [];
        }

        return $workOrders;
    }
}

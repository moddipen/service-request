import Vue from "vue"
import Router from "vue-router"
import {
  Profile,
  Setting,
  Location,
  Category,
  GeneralUsers,
  Company,
  ChildUsers,
  Role,
  Editors,
  Contractors,
  SiteAdmins,
  SiteStaff,
  ContractorStaff,
  Subscription,
  IsCompanyAdmin,
  IsNotSuperAdmin,
  IsSuperAdmin,
  Permission,
  RedirectIfAuthenticated,
  Authenticate,
  IsSiteAdmin,
  IsNotStaff,
  IsNotStaffExceptSiteStaff,
  IsContractorAdmin,
  WorkOrders,
  WorkOrderDetails
} from "@/utils/middlewares"
import multiguard from "vue-router-multiguard"
import { store } from "./store"

Vue.use(Router)

const routes = [
  {
    path: "/",
    component: () => import("./views/app"),
    redirect: "/app/work-orders",
    beforeEnter: multiguard([Authenticate]),
    children: [
      {
        path: "app/dashboard",
        component: () => import("./views/app/dashboards"),
        redirect: "/app/dashboard",
        children: [
          {
            path: "",
            component: () => import("./views/app/dashboards/Analytics")
          }
        ]
      }
    ]
  },
  {
    path: "/user",
    component: () => import("./views/auth"),
    redirect: "/user/login",
    beforeEnter: RedirectIfAuthenticated,
    children: [
      { path: "login", component: () => import("./views/auth/Login") },
      {
        path: "forgot-password",
        component: () => import("./views/auth/ForgotPassword")
      },
      {
        path: "reset-password/:token",
        component: () => import("./views/auth/ResetPassword")
      },
      {
        path: "set-account/:token",
        component: () => import("./views/auth/SetAccount")
      }
    ]
  },
  {
    path: "/user/register",
    beforeEnter: multiguard([RedirectIfAuthenticated, Setting]),
    component: () => import("./views/auth/Subscriptions")
  },
  {
    path: "/app/users",
    component: () => import("./views/users"),
    redirect: "/app/users/invite",
    beforeEnter: Authenticate,
    children: [
      { path: "invite", component: () => import("./views/users/Invite") },
      {
        path: "editors",
        beforeEnter: multiguard([IsCompanyAdmin, Editors]),
        component: () => import("./views/users/Editor")
      },
      {
        path: "contractors",
        beforeEnter: multiguard([IsCompanyAdmin, Contractors]),
        component: () => import("./views/users/Contractor")
      },
      {
        path: "site-admins",
        beforeEnter: multiguard([IsCompanyAdmin, SiteAdmins]),
        component: () => import("./views/users/SiteAdmin")
      },
      {
        path: "site-staff",
        beforeEnter: multiguard([IsSiteAdmin, SiteStaff]),
        component: () => import("./views/users/SiteStaff")
      },
      {
        path: "contractor-staff",
        beforeEnter: multiguard([IsContractorAdmin, ContractorStaff]),
        component: () => import("./views/users/ContractorStaff")
      },
      {
        path: "edit-permissions/:id/:type",
        beforeEnter: multiguard([GeneralUsers, Role]),
        component: () => import("./views/users/UpdateUserPermissions")
      },
      {
        path: "edit/:id/:type",
        beforeEnter: multiguard([GeneralUsers]),
        component: () => import("./views/users/UpdateUser")
      }
    ]
  },
  {
    path: "/app/locations",
    component: () => import("./views/locations"),
    redirect: "/app/locations",
    beforeEnter: multiguard([Authenticate, Location, IsSiteAdmin]),
    children: [
      {
        path: "",
        component: () => import("./views/locations/List")
      },
      {
        path: "create",
        component: () => import("./views/locations/Create")
      },
      {
        path: ":id/edit",
        component: () => import("./views/locations/Edit")
      }
    ]
  },
  {
    path: "/app/categories",
    component: () => import("./views/categories"),
    redirect: "/app/categories",
    beforeEnter: multiguard([Authenticate, Category, IsCompanyAdmin]),
    children: [
      {
        path: "",
        component: () => import("./views/categories/List")
      },
      {
        path: "create",
        component: () => import("./views/categories/Create")
      },
      {
        path: ":id/edit",
        component: () => import("./views/categories/Edit")
      }
    ]
  },
  {
    path: "/app/work-orders",
    component: () => import("./views/work_orders"),
    redirect: "/app/work-orders",
    beforeEnter: multiguard([Authenticate, WorkOrders]),
    children: [
      {
        path: "",
        component: () => import("./views/work_orders/List")
      },
      {
        path: "create",
        beforeEnter: multiguard([Location, IsNotStaffExceptSiteStaff]),
        component: () => import("./views/work_orders/Create")
      },
      {
        path: ":id/edit",
        beforeEnter: multiguard([WorkOrderDetails, Location]),
        component: () => import("./views/work_orders/Edit")
      },
      {
        path: ":id",
        beforeEnter: multiguard([WorkOrderDetails, Category]),
        component: () => import("./views/work_orders/Details")
      }
    ]
  },
  {
    path: "/app/account",
    component: () => import("./views/account"),
    redirect: "/app/account/profile",
    beforeEnter: Authenticate,
    children: [
      {
        path: "profile",
        beforeEnter: multiguard([IsNotSuperAdmin, Profile]),
        component: () => import("./views/account/Profile")
      },
      {
        path: "change-password",
        component: () => import("./views/account/ChangePassword")
      },
      {
        path: "subscriptions",
        beforeEnter: multiguard([Subscription, Setting]),
        component: () => import("./views/account/Subscription")
      }
    ]
  },
  {
    path: "/admin",
    component: () => import("./views/admin"),
    redirect: "/admin/login",
    beforeEnter: RedirectIfAuthenticated,
    children: [
      { path: "login", component: () => import("./views/admin/Login") }
    ]
  },
  {
    path: "/admin/roles",
    component: () => import("./views/admin/role"),
    redirect: "/admin/roles",
    beforeEnter: multiguard([Authenticate, IsSuperAdmin, Role]),
    children: [
      { path: "", component: () => import("./views/admin/role/List") },
      { path: "edit/:id", component: () => import("./views/admin/role/Edit") }
    ]
  },
  {
    path: "/app/users/companies",
    component: () => import("./views/admin/companies"),
    redirect: "/app/users/companies",
    beforeEnter: multiguard([Authenticate, IsSuperAdmin, Company, Role]),
    children: [
      {
        path: "",
        component: () => import("./views/admin/companies/List")
      },
      {
        path: "edit/:id",
        component: () => import("./views/admin/companies/Edit")
      },
      {
        path: "edit-permissions/:id",
        component: () => import("./views/admin/companies/UpdatePermissions")
      },
      {
        path: ":id/:type",
        beforeEnter: ChildUsers,
        component: () => import("./views/admin/companies/users/List")
      },
      {
        path: "edit/:type/:id",
        beforeEnter: ChildUsers,
        component: () => import("./views/admin/companies/users/Edit")
      },
      {
        path: "edit-permissions/:type/:id",
        beforeEnter: ChildUsers,
        component: () =>
          import("./views/admin/companies/users/UpdatePermissions")
      }
    ]
  },
  { path: "/404", component: () => import("./views/errors/404") },
  { path: "/403", component: () => import("./views/errors/403") },
  { path: "/500", component: () => import("./views/errors/500") },
  { path: "*", component: () => import("./views/errors/404") }
]

const router = new Router({
  linkActiveClass: "active",
  base: "/",
  routes,
  mode: "history"
})

router.beforeEach((to, from, next) => {
  let time = setInterval(() => {
    if (store.getters.isSettingLoaded) {
      clearInterval(time)
      next()
      return
    }
  }, 100)
})

export default router

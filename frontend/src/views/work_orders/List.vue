<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Service requests" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4" title>
          <div class="mb-2 mt-2">
            <b-collapse id="displayOptions" class="d-md-block ds-block">
              <div class="d-md-inline-block mb-2">
                <div class="search-sm d-inline-block float-md-left mr-1 align-top">
                  <b-input :placeholder="$t('menu.search')" v-model="filter" />
                </div>
                <b-dropdown
                  id="ddown2"
                  right
                  v-model="statusFilter"
                  :text="`${statusFilter}`"
                  variant="outline-dark"
                  class="d-inline-block"
                  size="xs"
                >
                  <b-dropdown-item
                    v-for="(size,index) in filterStatus"
                    :key="index"
                    @click="onStatusFiltered(size)"
                  >{{ size.label }}</b-dropdown-item>
                </b-dropdown>
                <b-dropdown
                  id="ddown23"
                  right
                  v-model="priorityFilter"
                  :text="`${priorityFilter}`"
                  variant="outline-dark"
                  class="d-inline-block"
                  size="xs"
                >
                  <b-dropdown-item
                    v-for="(size,index) in filterPriority"
                    :key="index"
                    @click="onPriorityFiltered(size)"
                  >{{ size.label }}</b-dropdown-item>
                </b-dropdown>
              </div>
              <div class="float-md-right">
                <router-link to="/app/work-orders/create">
                  <b-button
                    v-if="this.$isSuperAdmin() || this.$can('work order create')"
                    variant="primary"
                    class="white-color"
                    size="md"
                  >Add new</b-button>
                </router-link>
                <b-dropdown
                  id="ddown2"
                  right
                  v-model="perPage"
                  :text="`${perPage}`"
                  variant="outline-dark"
                  class="d-inline-block"
                  size="xs"
                >
                  <b-dropdown-item
                    v-for="(size,index) in pageOptions"
                    :key="index"
                    @click="changePageSize(size)"
                  >{{ size }}</b-dropdown-item>
                </b-dropdown>
              </div>
            </b-collapse>
          </div>
          <div class="table-responsive">
            <b-table
              selectable
              selectMode="single"
              @row-selected="rowSelected"
              show-empty
              stacked="md"
              :items="items"
              :fields="fields"
              :current-page="currentPage"
              :per-page="perPage"
              :filter="filter"
              :sort-by.sync="sortBy"
              :sort-desc.sync="sortDesc"
              :sort-direction="sortDirection"
              @filtered="onFiltered"
            >
              <template slot="status" slot-scope="row">
                <b-badge
                  v-if="row.item.status === '0' || row.item.status === 0"
                  class="mb-1"
                  pill
                  variant="warning"
                >Processing</b-badge>
                <b-badge
                  v-else-if="row.item.status === '1' || row.item.status === 1"
                  class="mb-1"
                  pill
                  variant="primary"
                >Closed</b-badge>
                <b-badge v-else class="mb-1" pill variant="secondary">Completed</b-badge>
              </template>
              <template
                slot="locations"
                slot-scope="row"
              >{{ row.item.location.street }}, {{ row.item.location.city }}-{{ row.item.location.postal_code }}</template>

              <template slot="actions" slot-scope="row">
                <b-button
                  v-if="canEdit()"
                  size="sm"
                  variant="primary"
                  :id="'tool-edit-'+row.item.id"
                  @click="edit(row.item)"
                >
                  <i class="simple-icon-note"></i>
                </b-button>
                <b-tooltip
                  :target="'tool-edit-'+row.item.id"
                  placement="right"
                  title="Edit service request"
                ></b-tooltip>

                <b-button
                  v-if="canDelete()"
                  size="sm"
                  variant="danger"
                  :id="'tool-delete-'+row.item.id"
                  @click="deleteUser(row.item)"
                >
                  <i class="simple-icon-trash"></i>
                </b-button>
                <b-tooltip
                  :target="'tool-delete-'+row.item.id"
                  placement="right"
                  title="Delete service request"
                ></b-tooltip>
              </template>
            </b-table>
          </div>
          <b-col class="my-1">
            <b-pagination
              v-model="currentPage"
              :total-rows="totalRows"
              :per-page="perPage"
              align="center"
            ></b-pagination>
          </b-col>
        </b-card>
      </b-colxx>
    </b-row>
  </div>
</template>
<script>
export default {
  data() {
    return {
      items: [],
      fields: [
        { key: "title", label: "Title", sortable: true },
        { key: "service_request_id", label: "SR No", sortable: true },
        { key: "locations", label: "Location", sortable: true },
        { key: "priority.name", label: "Priority" },
        { key: "status", label: "Status" },
        { key: "created_at", label: "Created", sortable: true }
      ],
      filterStatus: [
        { key: "all", label: "All" },
        { key: "0", label: "Processing" },
        { key: "1", label: "Closed" },
        { key: "2", label: "Completed" }
      ],
      filterPriority: [],
      totalRows: 1,
      currentPage: 1,
      perPage: "All",
      pageOptions: [5, 10, 50, "All"],
      sortBy: null,
      sortDesc: false,
      sortDirection: "asc",
      filter: null,
      statusFilter: "All",
      priorityFilter: "All"
    };
  },
  created() {
    this.filterPriority = [{ key: "all", label: "All" }];
    this.$store.getters.getPriority.map(priority => {
      this.filterPriority.push({
        key: priority.id,
        label: priority.name
      });
    });

    let workOrders = this.$store.getters.getWorkOrders;
    workOrders.sort((a, b) => {
      let x = a.created_at;
      let y = b.created_at;
      if (x < y) return 1;
      if (x > y) return -1;
      return 0;
    });
    this.items = workOrders;

    if (
      this.$store.getters.getAuthRole == "Super admin" ||
      this.$store.getters.getAuthRole == "Company admin" ||
      this.$store.getters.getAuthRole == "Contractor admin" ||
      this.$store.getters.getAuthRole == "Company editor" ||
      this.$store.getters.getAuthRole == "Site admin" ||
      this.$store.getters.getAuthRole == "Contractor staff" ||
      this.$store.getters.getAuthRole == "Site staff"
    ) {
      if (
        this.canEdit() ||
        this.canDelete() ||
        this.$store.getters.getAuthRole == "Super admin"
      ) {
        this.fields.push({ key: "actions", label: "Actions" });
      }
    }
  },
  mounted() {
    this.totalRows = this.items.length;
  },
  methods: {
    edit(item) {
      this.$router.push(`/app/work-orders/${item.id}/edit`);
    },
    show(item) {
      this.$router.push(`/app/work-orders/${item.id}`);
    },
    rowSelected(items) {
      this.$router.push(`/app/work-orders/${items[0].id}`);
    },
    canEdit() {
      if (
        this.$store.getters.getAuthPermissions.indexOf("work order edit") !== -1
      ) {
        return true;
      } else {
        return false;
      }
    },
    canDelete() {
      if (
        this.$store.getters.getAuthPermissions.indexOf("work order delete") !==
        -1
      ) {
        return true;
      } else {
        return false;
      }
    },
    checkPermissions(permission) {
      let role = this.$store.getters.getAuthRole;
      let profile = this.$store.getters.getProfile;
      if (permission === "add") {
        if (
          role === "Site admin" ||
          role === "Contractor admin" ||
          role === "Company admin" ||
          role === "Super admin"
        ) {
          return true;
        } else {
          return false;
        }
      } else if (permission > 0) {
        if (
          profile.user_id === permission ||
          role === "Company admin" ||
          role === "Company editor" ||
          role === "Super admin"
        ) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    },
    deleteUser(item) {
      this.$dialog
        .confirm(
          "Are you sure, want to delete this service request?",
          this.$store.getters.popupOptions
        )
        .then(dialog => {
          this.$store
            .dispatch("deleteWorkOrderRequest", { id: item.id })
            .then(() => {
              this.items = this.$store.getters.getWorkOrders;
              this.totalRows = this.items.length;
            });
        });
    },
    onFiltered(filteredItems) {
      this.totalRows = filteredItems.length;
      this.currentPage = 1;
    },
    filterItems(filter) {
      let workOrders = this.$store.getters.getWorkOrders;
      workOrders.sort((a, b) => {
        let x = a.created_at;
        let y = b.created_at;
        if (x < y) return 1;
        if (x > y) return -1;
        return 0;
      });
      if (filter == "all") return workOrders;
      let filtered = workOrders.filter(workOrder => {
        return workOrder.status == filter;
      });
      return filtered;
    },
    filterItems1(filter) {
      let workOrders = this.$store.getters.getWorkOrders;
      workOrders.sort((a, b) => {
        let x = a.created_at;
        let y = b.created_at;
        if (x < y) return 1;
        if (x > y) return -1;
        return 0;
      });
      if (filter == "all") return workOrders;
      let filtered = workOrders.filter(workOrder => {
        return workOrder.order_priority_id == filter;
      });
      return filtered;
    },
    onStatusFiltered(filter) {
      this.statusFilter = filter.label;
      this.items = this.filterItems(filter.key);
    },
    onPriorityFiltered(filter) {
      this.priorityFilter = filter.label;
      this.items = this.filterItems1(filter.key);
    },
    changePageSize(perPage) {
      this.perPage = perPage;
    }
  }
};
</script>
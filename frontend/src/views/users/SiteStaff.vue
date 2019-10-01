<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Site staff" />
        <div class="separator mb-5"></div>
      </b-colxx>
    </b-row>
    <b-row>
      <b-colxx xxs="12">
        <b-card class="mb-4" title>
          <div class="mb-2 mt-2">
            <b-collapse id="displayOptions" class="d-md-block ds-block">
              <div class="d-block d-md-inline-block mb-2">
                <div class="search-sm d-inline-block float-md-left mr-1 align-top">
                  <b-input :placeholder="$t('menu.search')" v-model="filter" />
                </div>
              </div>
              <div class="float-md-right">
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
                  v-if="row.item.status === 1 || row.item.status === '1'"
                  class="mb-1"
                  pill
                  variant="primary"
                >Active</b-badge>
                <b-badge v-else class="mb-1" pill variant="secondary">Deactive</b-badge>
              </template>
              <template slot="actions" slot-scope="row">
                <b-button
                  size="sm"
                  variant="success"
                  :id="'tool-permissions-'+row.item.id"
                  @click="changePermissions(row.item)"
                >
                  <i class="simple-icon-lock"></i>
                </b-button>
                <b-tooltip
                  :target="'tool-permissions-'+row.item.id"
                  placement="right"
                  title="Change permissions"
                ></b-tooltip>
                <b-button
                  size="sm"
                  variant="primary"
                  :id="'tool-edit-'+row.item.id"
                  @click="edit(row.item)"
                >
                  <i class="simple-icon-note"></i>
                </b-button>
                <b-tooltip :target="'tool-edit-'+row.item.id" placement="right" title="Edit user"></b-tooltip>
                <b-button
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
                  title="Delete user"
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
      items: this.$store.getters.getSiteStaff,
      fields: [
        { key: "profile.name", label: "Name", sortable: true },
        { key: "email", label: "Email", sortable: true },
        { key: "profile.phone", label: "Phone", sortable: true },
        { key: "status", label: "Status" },
        { key: "actions", label: "Actions" }
      ],
      totalRows: 1,
      currentPage: 1,
      perPage: "All",
      pageOptions: [5, 10, 50, "All"],
      sortBy: null,
      sortDesc: false,
      sortDirection: "asc",
      filter: null
    };
  },
  mounted() {
    this.totalRows = this.items.length;
  },
  methods: {
    edit(item) {
      this.$router.push(`/app/users/edit/${item.id}/site-staff`);
    },
    show(item) {},
    deleteUser(item) {
      this.$dialog
        .confirm(
          "Are you sure, want to delete this user?",
          this.$store.getters.popupOptions
        )
        .then(dialog => {
          this.$store
            .dispatch("deleteUserRequest", { type: "site-staff", id: item.id })
            .then(() => {
              this.items = this.$store.getters.getContractorStaff;
              this.totalRows = this.items.length;
            });
        });
    },
    changePermissions(item) {
      this.$router.push(`/app/users/edit-permissions/${item.id}/site-staff`);
    },
    onFiltered(filteredItems) {
      this.totalRows = filteredItems.length;
      this.currentPage = 1;
    },
    changePageSize(perPage) {
      this.perPage = perPage;
    }
  }
};
</script>
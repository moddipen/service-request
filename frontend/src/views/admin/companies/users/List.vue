<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb :heading="_.capitalize(this.type)" />
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
                <!-- <b-button
                v-if="type === 'contractors'"
                size="sm"
                variant="secondary"
                :id="'tool-contractor-'+row.item.id"
                @click="show('contractor-staff', row.item)"
              >
                <i class="simple-icon-user"></i>
              </b-button>
              <b-tooltip
                v-if="type === 'contractors'"
                :target="'tool-contractor-'+row.item.id"
                placement="right"
                title="Show contractor staff"
              ></b-tooltip>
              <b-button
                v-if="type === 'site-admins'"
                size="sm"
                variant="success"
                :id="'tool-site-admin-'+row.item.id"
                @click="show('site-staff', row.item)"
              >
                <i class="simple-icon-user"></i>
              </b-button>
              <b-tooltip
                v-if="type === 'site-admins'"
                :target="'tool-site-admin-'+row.item.id"
                placement="right"
                title="Show site staff"
                ></b-tooltip>-->
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
      items: [],
      id: 0,
      type: "",
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
  created() {
    this.id = this.$route.params.id;
    this.type = this.$route.params.type;
    this.items = this.$store.getters.getChildsByParentId(this.id, this.type);
  },
  mounted() {
    this.totalRows = this.items.length;
  },
  methods: {
    edit(item) {
      this.$router.push(`/app/users/companies/edit/${this.type}/${item.id}`);
    },
    show(type, item) {
      this.$router.push(`/app/users/companies/${item.id}/${type}`);
    },
    deleteUser(item) {
      this.$dialog
        .confirm(
          "Are you sure, want to delete this user?",
          this.$store.getters.popupOptions
        )
        .then(dialog => {
          this.$store
            .dispatch("deleteCompanyRequest", {
              type: this.type,
              id: item.id,
              pid: this.id
            })
            .then(() => {
              this.items = this.$store.getters.getCompanies;
              this.totalRows = this.items.length;
            });
        });
    },
    changePermissions(item) {
      this.$router.push(
        `/app/users/companies/edit-permissions/${this.type}/${item.id}`
      );
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
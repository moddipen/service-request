<template>
  <div>
    <b-row>
      <b-colxx xxs="12">
        <piaf-breadcrumb heading="Site locations" />
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
                <router-link to="/app/locations/create">
                  <b-button variant="primary" class="white-color" size="md">Add new</b-button>
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
            <template slot="actions" slot-scope="row">
              <b-button
                size="sm"
                variant="primary"
                :id="'tool-edit-'+row.item.id"
                @click="edit(row.item)"
              >
                <i class="simple-icon-note"></i>
              </b-button>
              <b-tooltip :target="'tool-edit-'+row.item.id" placement="right" title="Edit location"></b-tooltip>
              <b-button
                size="sm"
                variant="danger"
                :id="'tool-delete-'+row.item.id"
                @click="deleteLocation(row.item)"
              >
                <i class="simple-icon-trash"></i>
              </b-button>
              <b-tooltip
                :target="'tool-delete-'+row.item.id"
                placement="right"
                title="Delete location"
              ></b-tooltip>
            </template>
          </b-table>
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
      items: this.$store.getters.getLocations,
      fields: [
        { key: "street", label: "Street", sortable: true },
        { key: "city", label: "City", sortable: true },
        { key: "postal_code", label: "Postal code", sortable: true },
        { key: "email", label: "Email", sortable: true },
        { key: "actions", label: "Actions" }
      ],
      totalRows: 1,
      currentPage: 1,
      perPage: 5,
      pageOptions: [5, 10, 50],
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
      this.$router.push(`/app/locations/${item.id}/edit`);
    },
    deleteLocation(item) {
      this.$dialog
        .confirm(
          "Are you sure, want to delete this location?",
          this.$store.getters.popupOptions
        )
        .then(dialog => {
          this.$store
            .dispatch("deleteLocationRequest", { id: item.id })
            .then(() => {
              this.items = this.$store.getters.getLocations;
              this.totalRows = this.items.length;
            });
        });
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
<template>
  <div>
    <b-row>
      <b-colxx lg="12" class="mb-12">
        <b-card>
          <h1>Service Request Details</h1>
          <div class="float-md-right">
            <h2>{{ workOrder.service_request_id }}</h2>
            <h4
              v-if="workOrder.purchase_order_number != ''"
            >Purchase order: {{ workOrder.purchase_order_number }}</h4>
          </div>
          <br />
          <br />
          <div class="float-md-left">
            <h4>{{ workOrder.title }}</h4>
          </div>
          <div class="float-md-right">
            <p>
              <b>Created on:</b>
              {{ moment(workOrder.created_at).format('LL') }} by {{ workOrder.order_by.profile.name }}
            </p>
          </div>
          <br />
          <div class>
            <p>{{ workOrder.description }}</p>
            <br />
            <b>Location details:</b>
            <p>{{ workOrder.location.street }}, {{ workOrder.location.city }}-{{ workOrder.location.postal_code }}</p>
            <p>
              <b>Status:</b>
              <b-badge
                v-if="(workOrder.status === 0 || workOrder.status === '0')"
                pill
                variant="primary"
              >Processing</b-badge>
              <b-badge
                v-else-if="(workOrder.status === 1 || workOrder.status === '1')"
                pill
                variant="secondary"
              >Closed</b-badge>
              <b-badge v-else pill variant="success">Completed</b-badge>
            </p>
            <p v-if="this.$isContractorAdmin() || this.$isCompanyAdmin()">
              <b>Contractor quotation:</b>
              ${{workOrder.contractor_cost}}
            </p>
            <p v-if="this.$isSiteAdmin() || this.$isCompanyAdmin()">
              <b>Company quotation:</b>
              ${{workOrder.company_cost}}
            </p>
          </div>

          <div class="float-md-left">
            <div
              class="image-gallery"
              v-for="(image, imageIndex) in workOrder.images"
              :key="imageIndex"
              @click="index = imageIndex"
              :style="{ backgroundImage: 'url(' + image.path + ')', width: '100px', height: '100px' }"
            >
              <!-- v-if="this.$IsSuperAdmin()" -->
              <b-button size="sm" variant="danger" :id="image.id" @click="deletePhoto(image.id)">
                <i class="simple-icon-trash"></i>
              </b-button>
            </div>
          </div>
          <br />
          <div class="float-md-right">
            <b-button
              v-if="this.$isCompanyAdmin()"
              size="sm"
              v-b-modal.updateStatus
              variant="primary"
            >Update status</b-button>
            <b-button
              v-if="this.$isCompanyAdmin()"
              size="sm"
              v-b-modal.assignOrder
              variant="warning"
            >Assign order</b-button>
            <b-button
              v-if="this.$isContractorAdmin() || this.$isCompanyAdmin()"
              size="sm"
              v-b-modal.addParts
              variant="warning"
            >Required Parts and Costs</b-button>
            <b-button
              v-if="this.$isContractorAdmin() && workOrder.contractor_cost <= 0.00 "
              size="sm"
              v-b-modal.contCost
              variant="primary"
            >Add quotation</b-button>
            <b-button
              v-if="this.$isCompanyAdmin()"
              size="sm"
              v-b-modal.compCost
              variant="primary"
            >Add quotation</b-button>
          </div>
        </b-card>
      </b-colxx>
    </b-row>
    <br />
    <b-row>
      <b-colxx xl="4" lg="6" md="12" class="mb-4">
        <b-card title="Tasks">
          <vue-perfect-scrollbar
            class="scroll dashboard-list-with-user"
            :settings="{ suppressScrollX: true, wheelPropagation: false }"
          >
            <div lass="card-body">
              <div
                v-for="(task, index) in workOrder.tasks"
                :key="index"
                class="d-flex flex-row mb-3 pb-3 border-bottom"
                @click="showTask(task)"
              >
                <div class="pl-3 pr-2">
                  <a
                    v-if="task.id === currentTask.id"
                    v-scroll-to="'#task-details'"
                    href="javascript:"
                    class="active-a"
                  >
                    <span class="font-weight-medium mb-0">{{ task.title }}</span>

                    <!-- <p class="text-muted mb-0 text-small">{{ task.description }}</p> -->
                  </a>
                  <a
                    v-else
                    href="javascript:"
                    v-scroll-to="'#task-details'"
                    @click="showTask(task)"
                  >
                    <p class="font-weight-medium mb-0">{{ task.title }}</p>
                    <!-- <p class="text-muted mb-0 text-small">{{ task.description }}</p> -->
                  </a>
                </div>
              </div>
            </div>
          </vue-perfect-scrollbar>
          <br />
          <div class="float-md-right">
            <b-button
              v-if="(workOrder.status === 0 || workOrder.status === '0') && this.$isNotSuperAdmin()"
              size="sm"
              v-b-modal.addTask
              variant="primary"
            >Add new task</b-button>
          </div>
        </b-card>
      </b-colxx>
      <b-colxx id="task-details" lg="8" xxs="12" class="mb-8">
        <b-card xxs="12" title="Task details">
          <div v-if="currentTask.title" class="card-body">
            <b-tabs content-class="mt-3" fill>
              <b-tab title="Details" active>
                <h4>{{ currentTask.title }}</h4>
                <p>{{ currentTask.description }}</p>
                <p>
                  <b>Category:</b>
                  {{ currentTask.category.name }}
                </p>
                <p>
                  <b>Priority:</b>
                  {{ currentTask.priority.name }} ( {{ currentTask.priority.description }} )
                </p>
                <b v-if="currentTask.company_notes !== ''">Company notes:</b>
                <p v-if="currentTask.company_notes !== ''">{{ currentTask.company_notes }}</p>
                <b v-if="currentTask.contractor_notes !== ''">Contractor notes:</b>
                <p v-if="currentTask.contractor_notes !== ''">{{ currentTask.contractor_notes }}</p>
                <br />
                <p>
                  <b>Added on:</b>
                  {{ moment(currentTask.created_at).format('LL') }} by {{ currentTask.added_by.profile.name }}
                </p>
                <br />
                <div class="float-md-right">
                  <b-button
                    class="pull-right"
                    type="button"
                    @click="editTaskF(currentTask)"
                    size="sm"
                    variant="primary"
                    v-b-modal.editTask
                  >
                    <i class="simple-icon-note"></i>
                  </b-button>

                  <b-button
                    size="sm"
                    v-if="this.$isCompanyAdmin() && this.currentTask.company_notes == ''"
                    v-b-modal.compNotes
                    variant="primary"
                  >Add company notes</b-button>
                  <b-button
                    size="sm"
                    v-if="this.$isContractorAdmin() && this.currentTask.contractor_notes == ''"
                    v-b-modal.contNotes
                    variant="primary"
                  >Add contractor notes</b-button>
                </div>
              </b-tab>
              <b-tab title="Comments">
                <vue-perfect-scrollbar
                  class="scroll dashboard-list-with-user"
                  :settings="{ suppressScrollX: true, wheelPropagation: false }"
                >
                  <div
                    v-for="(comment, index) in currentTask.comments"
                    :key="index"
                    class="d-flex flex-row mb-12 pb-12 border-bottom"
                  >
                    <div>
                      <p class="font-weight-medium mb-0 task-comment">{{ comment.message }}</p>
                      <br />
                      <p class="text-muted mb-0 text-small float-md-right">
                        <b>{{ moment(comment.created_at).format('LLL') }} by {{ comment.added_by.profile.name }}</b>
                      </p>
                      <br />
                    </div>
                  </div>
                </vue-perfect-scrollbar>
                <br />
                <div class="float-md-right">
                  <b-button
                    size="sm"
                    v-if="(workOrder.status !== '2' || workOrder.status !== 2) && this.$isNotSuperAdmin()"
                    v-b-modal.addComment
                    variant="primary"
                  >Add comment</b-button>
                </div>
              </b-tab>
              <b-tab title="Photos">
                <vue-perfect-scrollbar
                  class="scroll dashboard-list-with-user"
                  :settings="{ suppressScrollX: true, wheelPropagation: false }"
                >
                  <gallery :images="currentTask.images" :index="index" @close="index = null"></gallery>
                  <div
                    class="image-gallery"
                    v-for="(image, imageIndex) in currentTask.images"
                    :key="imageIndex"
                    @click="index = imageIndex"
                    :style="{ backgroundImage: 'url(' + image + ')', width: '300px', height: '200px' }"
                  ></div>
                </vue-perfect-scrollbar>
                <br />
                <div class="float-md-right">
                  <b-button
                    size="sm"
                    v-if="(workOrder.status !== '2' || workOrder.status !== 2) && this.$isNotSuperAdmin()"
                    v-b-modal.addPhotos
                    variant="primary"
                  >Add photos</b-button>
                </div>
              </b-tab>
            </b-tabs>
          </div>
          <div v-else class="card-body">No task available</div>
        </b-card>
      </b-colxx>
    </b-row>

    <b-modal
      id="editTask"
      ref="editTask"
      size="lg"
      title="Update new task to this service request"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="signUpForm">
        <label class="form-group has-float-label mb-4">
          <input-component v-model="taskForm.title" :v="this.editTask.title" label="Title" />
        </label>
        <label class="form-group has-float-label mb-4">
          <text-area-component
            v-model="taskForm.description"
            :v="this.editTask.description"
            label="Descriptions"
          />
        </label>
        <div class="form-group has-float-label">
          <select-component
            :options="categories"
            v-model="taskForm.category"
            :v="this.editTask.category"
            label="Category"
          />
        </div>
        <div class="form-group has-float-label">
          <select-component
            :options="priorities"
            v-model="taskForm.priority"
            :v="this.editTask.priority"
            label="Priority"
          />
        </div>

        <label>Images:</label>
        <vue-upload-multiple-image
          @upload-success="uploadImageSuccess"
          @before-remove="beforeRemove"
          @edit-image="editImage"
          :data-images="this.editTask.images"
          idUpload="myIdUpload"
          editUpload="myIdEdit"
          dragText="Drag or browse"
          dropText="Drop here"
          popupText="Upload task photos"
          browseText
          primaryText
          :maxImage="maxImage"
          markIsPrimaryText
        ></vue-upload-multiple-image>
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="taskFormSubmit()" class="mr-1">Add</b-button>
        <b-button variant="secondary" @click="hideModal('addTask')">Cancel</b-button>
      </template>
    </b-modal>

    <b-modal
      id="addTask"
      ref="addTask"
      size="lg"
      title="Add new task to this service request"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="signUpForm">
        <label class="form-group has-float-label mb-4">
          <input-component v-model="taskForm.title" :v="$v.taskForm.title" label="Title" />
        </label>
        <label class="form-group has-float-label mb-4">
          <text-area-component
            v-model="taskForm.description"
            :v="$v.taskForm.description"
            label="Descriptions"
          />
        </label>
        <div class="form-group has-float-label">
          <select-component
            :options="categories"
            v-model="taskForm.category"
            :v="$v.taskForm.category"
            label="Category"
          />
        </div>
        <div class="form-group has-float-label">
          <select-component
            :options="priorities"
            v-model="taskForm.priority"
            :v="$v.taskForm.priority"
            label="Priority"
          />
        </div>

        <label>Images:</label>
        <vue-upload-multiple-image
          @upload-success="uploadImageSuccess"
          @before-remove="beforeRemove"
          @edit-image="editImage"
          :data-images="taskForm.images"
          idUpload="myIdUpload"
          editUpload="myIdEdit"
          dragText="Drag or browse"
          dropText="Drop here"
          popupText="Upload task photos"
          browseText
          primaryText
          :maxImage="maxImage"
          markIsPrimaryText
        ></vue-upload-multiple-image>
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="taskFormSubmit()" class="mr-1">Add</b-button>
        <b-button variant="secondary" @click="hideModal('addTask')">Cancel</b-button>
      </template>
    </b-modal>

    <b-modal
      id="addComment"
      ref="addComment"
      size="lg"
      title="Add comment to this task"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="commentForm">
        <label class="form-group has-float-label mb-4">
          <text-area-component
            v-model="commentForm.message"
            :v="$v.commentForm.message"
            label="Message"
          />
        </label>
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="commentFormSubmit()" class="mr-1">Add</b-button>
        <b-button variant="secondary" @click="hideModal('addComment')">Cancel</b-button>
      </template>
    </b-modal>
    <b-modal
      id="addPhotos"
      ref="addPhotos"
      size="lg"
      title="Add photos to this task"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="photosForm">
        <label>Images:</label>
        <vue-upload-multiple-image
          @upload-success="uploadNewImageSuccess"
          @before-remove="beforeNewRemove"
          @edit-image="editNewImage"
          :data-images="photosForm.images"
          idUpload="myIdUpload"
          editUpload="myIdEdit"
          dragText="Drag or browse"
          dropText="Drop here"
          popupText="Upload task photos"
          browseText
          primaryText
          :maxImage="maxImage"
          markIsPrimaryText
        ></vue-upload-multiple-image>
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="photosFormSubmit()" class="mr-1">Add</b-button>
        <b-button variant="secondary" @click="hideModal('addPhotos')">Cancel</b-button>
      </template>
    </b-modal>
    <b-modal
      id="contNotes"
      ref="contNotes"
      size="lg"
      title="Add contractor note to this task"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="contractorNoteForm">
        <label class="form-group has-float-label mb-4">
          <text-area-component
            v-model="contractorNoteForm.contractor_notes"
            :v="$v.contractorNoteForm.contractor_notes"
            label="Contractor note"
          />
        </label>
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="contractorNoteFormSubmit()" class="mr-1">Add</b-button>
        <b-button variant="secondary" @click="hideModal('contNotes')">Cancel</b-button>
      </template>
    </b-modal>
    <b-modal
      id="contCost"
      ref="contCost"
      size="lg"
      title="Add cost to this service request"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="contractorNoteForm">
        <label class="form-group has-float-label mb-4">
          <input-component
            type="number"
            v-model="contractorCostForm.contractor_cost"
            :v="$v.contractorCostForm.contractor_cost"
            label="Service Request cost"
          />
        </label>
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="contractorCostFormSubmit()" class="mr-1">Add</b-button>
        <b-button variant="secondary" @click="hideModal('contCost')">Cancel</b-button>
      </template>
    </b-modal>
    <b-modal
      id="compCost"
      ref="compCost"
      size="lg"
      title="Add cost to this service request"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="companyCostForm">
        <label class="form-group has-float-label mb-4">
          <input-component
            type="number"
            v-model="companyCostForm.company_cost"
            :v="$v.companyCostForm.company_cost"
            label="Service Request cost"
          />
        </label>
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="companyCostFormSubmit()" class="mr-1">Add</b-button>
        <b-button variant="secondary" @click="hideModal('compCost')">Cancel</b-button>
      </template>
    </b-modal>
    <b-modal
      id="compNotes"
      ref="compNotes"
      size="lg"
      title="Add company note to this task"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="companyNoteForm">
        <label class="form-group has-float-label mb-4">
          <text-area-component
            v-model="companyNoteForm.company_notes"
            :v="$v.companyNoteForm.company_notes"
            label="Company note"
          />
        </label>
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="companyNoteFormSubmit()" class="mr-1">Add</b-button>
        <b-button variant="secondary" @click="hideModal('compNotes')">Cancel</b-button>
      </template>
    </b-modal>
    <b-modal
      id="updateStatus"
      ref="updateStatus"
      size="lg"
      title="Update service request status"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="statusForm">
        <div class="form-group has-float-label">
          <select-component
            :options="statusOptions"
            v-model="statusForm.status"
            :v="$v.statusForm.status"
            label="Status"
          />
        </div>
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="statusFormSubmit()" class="mr-1">Update</b-button>
        <b-button variant="secondary" @click="hideModal('updateStatus')">Cancel</b-button>
      </template>
    </b-modal>
    <b-modal
      id="assignOrder"
      ref="assignOrder"
      size="lg"
      title="Assign service request to contractor"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="statusForm">
        <div class="form-group has-float-label">
          <select-component
            :options="contractorOptions"
            v-model="assignForm.contractor"
            :v="$v.assignForm.contractor"
            label="Contractors"
          />
        </div>
        <!-- <b-row>
          <b-colxx xxs="12">
            <label>Quote required</label>
          </b-colxx>
          <b-colxx xxs="12">
            <switches v-model="assignForm.contractor_quote_required" theme="custom" color="primary"></switches>
          </b-colxx>
        </b-row>-->
        <br />
      </b-form>
      <template slot="modal-footer">
        <b-button variant="primary" @click="assignFormSubmit()" class="mr-1">Assign</b-button>
        <b-button variant="secondary" @click="hideModal('assignOrder')">Cancel</b-button>
      </template>
    </b-modal>
    <b-modal
      id="addParts"
      ref="addParts"
      size="lg"
      title="Required Parts and Costs"
      :hide-backdrop="selectedBackdrop=='false'"
      :no-close-on-backdrop="selectedBackdrop=='false' || selectedBackdrop=='static'"
    >
      <b-form id="partsForm">
        <b-row v-for="(part,k) in parts" :key="k">
          <b-colxx sm="8">
            <label class="form-group has-float-label mb-4">
              <input-component
                v-model="part.name"
                :disabled="!isContractor() || (workOrder.status == '2' || workOrder.status == 2)"
                :v="$v.partsForm.name"
                label="Name"
              />
            </label>
          </b-colxx>
          <b-colxx sm="3">
            <label class="form-group has-float-label mb-4">
              <input-component
                v-model="part.price"
                :disabled="!isContractor() || (workOrder.status == '2' || workOrder.status == 2)"
                :v="$v.partsForm.price"
                type="number"
                label="Price"
              />
            </label>
          </b-colxx>
          <b-colxx sm="1">
            <b-form-group label>
              <b-button
                v-show="(k || ( !k && parts.length > 1))"
                v-if="isContractor()  && (workOrder.status !== '2' || workOrder.status !== 2)"
                class="mb-2"
                size="xs"
                variant="primary"
                @click="remove(k)"
              >
                <i class="simple-icon-minus"></i>
              </b-button>
              <b-button
                v-show="(k == parts.length-1) && (isContractor()  && (workOrder.status !== '2' || workOrder.status !== 2))"
                @click="add(k)"
                class="mb-2"
                size="xs"
                variant="secondary"
              >
                <i class="simple-icon-plus"></i>
              </b-button>
            </b-form-group>
          </b-colxx>
        </b-row>
      </b-form>
      <template slot="modal-footer">
        <b-button
          variant="primary"
          v-if="isContractor() && (workOrder.status !== '2' || workOrder.status !== 2)"
          @click="partsFormSubmit()"
          class="mr-1"
        >Updates</b-button>
        <b-button variant="secondary" @click="hideModal('addParts')">Cancel</b-button>
      </template>
    </b-modal>
  </div>
</template>
<script>
import { required, numeric } from "vuelidate/lib/validators";
import VueGallery from "vue-gallery";
import VueUploadMultipleImage from "vue-upload-multiple-image";
import Switches from "vue-switches";
import InputComponent from "../partials/forms/InputComponent";
import TextAreaComponent from "../partials/forms/TextAreaComponent";
import SelectComponent from "../partials/forms/SelectComponent";
import vSelect from "vue-select";
import "vue-select/dist/vue-select.css";
import InputTag from "@/components/Form/InputTag";

export default {
  components: {
    gallery: VueGallery,
    Switches,
    InputComponent,
    TextAreaComponent,
    SelectComponent,
    VueUploadMultipleImage,
    InputTag,
    vSelect
  },
  data: function() {
    return {
      workOrder: {},
      currentTask: {},
      editTask: {},
      contractorOptions: [],
      statusOptions: [
        { label: "Processing", value: 0 },
        { label: "Closed", value: 1 },
        { label: "Completed", value: 2 }
      ],
      maxImage: 20,
      selectedBackdrop: "false",
      categories: [],
      priorities: [],
      taskForm: {
        work_order_id: this.$route.params.id,
        title: "",
        description: "",
        category: {},
        priority: {},
        photos: "",
        images: []
      },
      parts: [
        {
          name: "",
          price: ""
        }
      ],
      partsForm: {},
      commentForm: {
        work_order_id: this.$route.params.id,
        work_task_id: 0,
        message: ""
      },
      statusForm: {
        status: {}
      },
      companyNoteForm: {
        company_notes: ""
      },
      contractorNoteForm: {
        contractor_notes: ""
      },
      assignForm: {
        contractor: {}
        //contractor_quote_required: true
      },
      contractorCostForm: {
        contractor_cost: ""
      },
      companyCostForm: {
        company_cost: ""
      },
      photosForm: {
        images: []
      },
      index: null
    };
  },
  created() {
    this.workOrder = this.$store.getters.getWorkOrderById(
      this.$route.params.id
    );

    console.log("workOrder", this.workOrder);

    this.contractorCostForm.contractor_cost = this.workOrder.contractor_cost;
    this.companyCostForm.company_cost = this.workOrder.company_cost;

    this.currentTask =
      this.workOrder.tasks && this.workOrder.tasks.length
        ? this.workOrder.tasks[0]
        : {};

    this.images =
      this.workOrder.tasks && this.workOrder.tasks.length
        ? this.workOrder.tasks[0].images
        : {};

    this.categories = this.$store.getters.getCategories.map(category => {
      return {
        label: category.name,
        value: category.id
      };
    });
    this.priorities = this.$store.getters.getPriority.map(priority => {
      return {
        label: priority.name + " ( " + priority.description + " ) ",
        value: priority.id
      };
    });
    this.statusForm.status = this.statusOptions.filter(
      option => option.value === this.workOrder.status
    )[0];
    let role = this.$store.getters.getAuthRole;
    if (role === "Company admin") {
      this.contractorOptions = this.$store.getters.getContractorAdmins.map(
        contractor => {
          return {
            label: contractor.profile.name,
            value: contractor.id
          };
        }
      );
    }

    if (role !== "Super admin") {
      this.setParts();
    }
  },
  validations: {
    taskForm: {
      title: { required },
      description: { required },
      category: { required },
      priority: { required }
    },
    commentForm: {
      message: { required }
    },
    statusForm: {
      status: { required }
    },
    companyNoteForm: {
      company_notes: { required }
    },
    contractorNoteForm: {
      contractor_notes: { required }
    },
    assignForm: {
      contractor: { required }
    },
    contractorCostForm: {
      contractor_cost: { required }
    },
    companyCostForm: {
      company_cost: { required }
    },
    partsForm: {
      name: {},
      price: {}
    }
  },
  methods: {
    deletePhoto(item) {
      this.$dialog
        .confirm(
          "Are you sure, want to delete this image?",
          this.$store.getters.popupOptions
        )
        .then(dialog => {
          this.$store
            .dispatch("deleteWorkOrderPhotoRequest", { id: item })
            .then(() => {
              this.workOrder = this.$store.getters.getWorkOrderById(
                this.$route.params.id
              );
            });
        });
    },
    add(index) {
      this.parts.push({ name: "", price: "" });
    },
    remove(index) {
      this.parts.splice(index, 1);
    },
    hideModal(refname) {
      this.$v.$reset();
      this.$refs[refname].hide();
    },
    showTask(task) {
      this.currentTask = task;
    },
    editTaskF(task) {
      console.log("task", task);
      //this.editTask = task;
    },

    moment(...args) {
      return moment(...args);
    },
    isContractor() {
      let role = this.$store.getters.getAuthRole;
      if (role === "Contractor admin") {
        return true;
      } else {
        return false;
      }
    },
    setCurrentTask() {
      if (this.currentTask.id) {
        this.currentTask = this.workOrder.tasks.filter(
          task => task.id === this.currentTask.id
        )[0];
      } else {
        this.currentTask = this.workOrder.tasks[0];
      }
    },
    setParts() {
      if (this.workOrder.parts.length) {
        this.parts = this.workOrder.parts.map(part => {
          return {
            name: part.name,
            price: part.price.toString()
          };
        });
      }
    },
    taskFormSubmit: function() {
      this.$v.taskForm.$touch();
      if (this.$v.taskForm.$pending || this.$v.taskForm.$error) return;
      this.$store
        .dispatch("addTaskToWorkOrderRequest", { ...this.taskForm })
        .then(() => {
          this.workOrder = this.$store.getters.getWorkOrderById(
            this.$route.params.id
          );
          this.taskForm.title = "";
          this.taskForm.description = "";
          this.taskForm.category = "";
          this.taskForm.priority = "";
          this.taskForm.company_notes = "";
          this.taskForm.contractor_notes = "";
          this.taskForm.images = [];
          this.hideModal("addTask");
          this.setCurrentTask();
        });
    },
    commentFormSubmit: function() {
      this.$v.commentForm.$touch();
      if (this.$v.commentForm.$pending || this.$v.commentForm.$error) return;
      let data = {
        work_order_id: this.commentForm.work_order_id,
        message: this.commentForm.message,
        work_task_id: this.currentTask.id
      };
      this.$store.dispatch("addCommentToTaskRequest", data).then(() => {
        this.workOrder = this.$store.getters.getWorkOrderById(
          this.$route.params.id
        );
        this.setCurrentTask();
        this.commentForm.message = "";
        this.hideModal("addComment");
      });
    },
    photosFormSubmit: function() {
      if (this.photosForm.images.length) {
        let data = {
          work_order_id: this.workOrder.id,
          images: this.photosForm.images,
          work_task_id: this.currentTask.id
        };
        this.$store.dispatch("addPhotosToTaskRequest", data).then(() => {
          this.workOrder = this.$store.getters.getWorkOrderById(
            this.$route.params.id
          );
          this.setCurrentTask();
          this.photosForm.images = [];
          this.hideModal("addPhotos");
        });
      }
    },
    statusFormSubmit: function() {
      this.$v.statusForm.$touch();
      if (this.$v.statusForm.$pending || this.$v.statusForm.$error) return;
      let data = {
        id: this.workOrder.id,
        status: this.statusForm.status.value
      };
      this.$store.dispatch("updateWorkOrderStatusRequest", data).then(() => {
        this.workOrder = this.$store.getters.getWorkOrderById(
          this.$route.params.id
        );
        this.hideModal("updateStatus");
      });
    },
    contractorNoteFormSubmit: function() {
      this.$v.statusForm.$touch();
      if (
        this.$v.contractorNoteForm.$pending ||
        this.$v.contractorNoteForm.$error
      )
        return;
      let data = {
        work_order_id: this.workOrder.id,
        id: this.currentTask.id,
        contractor_notes: this.contractorNoteForm.contractor_notes
      };
      this.$store.dispatch("updateWorkOrderTaskRequest", data).then(() => {
        this.workOrder = this.$store.getters.getWorkOrderById(
          this.$route.params.id
        );
        this.setCurrentTask();
        this.contractorNoteForm.contractor_notes = "";
        this.hideModal("contNotes");
      });
    },
    companyNoteFormSubmit: function() {
      this.$v.statusForm.$touch();
      if (this.$v.companyNoteForm.$pending || this.$v.companyNoteForm.$error)
        return;
      let data = {
        work_order_id: this.workOrder.id,
        id: this.currentTask.id,
        company_notes: this.companyNoteForm.company_notes
      };
      this.$store.dispatch("updateWorkOrderTaskRequest", data).then(() => {
        this.workOrder = this.$store.getters.getWorkOrderById(
          this.$route.params.id
        );
        this.setCurrentTask();
        this.companyNoteForm.company_notes = "";
        this.hideModal("compNotes");
      });
    },
    assignFormSubmit: function() {
      this.$v.assignForm.$touch();
      if (this.$v.assignForm.$pending || this.$v.assignForm.$error) return;
      let data = {
        id: this.workOrder.id,
        contractor: this.assignForm.contractor.value,
        contractor_quote_required: 0
      };
      this.$store.dispatch("assignWorkOrderRequest", data).then(() => {
        this.workOrder = this.$store.getters.getWorkOrderById(
          this.$route.params.id
        );
        this.setCurrentTask();
        this.assignForm.contractor = "";
        this.hideModal("assignOrder");
      });
    },
    partsFormSubmit: function() {
      // this.$v.assignForm.$touch();
      // if (this.$v.assignForm.$pending || this.$v.assignForm.$error) return;
      let data = {
        id: this.workOrder.id,
        parts: this.parts
      };
      this.$store.dispatch("addPartsToWorkOrderRequest", data).then(() => {
        this.workOrder = this.$store.getters.getWorkOrderById(
          this.$route.params.id
        );
        this.setParts();
        this.hideModal("addParts");
      });
    },
    contractorCostFormSubmit: function() {
      this.$v.contractorCostForm.$touch();
      if (
        this.$v.contractorCostForm.$pending ||
        this.$v.contractorCostForm.$error
      )
        return;
      let data = {
        id: this.workOrder.id,
        contractor_cost: this.contractorCostForm.contractor_cost
      };
      this.$store.dispatch("addCostToWorkOrderRequest", data).then(() => {
        this.workOrder = this.$store.getters.getWorkOrderById(
          this.$route.params.id
        );
        this.hideModal("contCost");
      });
    },
    companyCostFormSubmit: function() {
      this.$v.companyCostForm.$touch();
      if (this.$v.companyCostForm.$pending || this.$v.companyCostForm.$error)
        return;
      let data = {
        id: this.workOrder.id,
        company_cost: this.companyCostForm.company_cost
      };
      this.$store
        .dispatch("addCompanyCostToWorkOrderRequest", data)
        .then(() => {
          this.workOrder = this.$store.getters.getWorkOrderById(
            this.$route.params.id
          );
          this.hideModal("compCost");
        });
    },

    uploadImageSuccess(formData, index, fileList) {
      this.taskForm.images = fileList;
    },
    beforeRemove(index, done, fileList) {
      this.taskForm.images = fileList;
      done();
    },
    editImage(formData, index, fileList) {
      this.taskForm.images = fileList;
    },
    uploadNewImageSuccess(formData, index, fileList) {
      this.photosForm.images = fileList;
    },
    beforeNewRemove(index, done, fileList) {
      this.photosForm.images = fileList;
      done();
    },
    editNewImage(formData, index, fileList) {
      this.photosForm.images = fileList;
    }
  }
};
</script> 
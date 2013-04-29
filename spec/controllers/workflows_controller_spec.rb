require 'spec_helper'

describe WorkflowsController do
  include_context "controller_spec"
  include_context "with_current_user"
  include_context "with_ability"
  before do
    sign_in current_user
  end

  let(:current_user) { create(:user) }
  let(:show_params) {{:id => a_workflow.id}}
  let(:update_params) {{:id => a_workflow.id, :workflow => {:name => "New name" }}}
  let(:a_workflow) { current_user.workflows.first }
  let(:workflow) {a_workflow.workflow}
  let(:create_params) do 
    {:workflow => {:name => "New workflow", :taverna_workflow => fixture_file_upload('/workflow_example.t2flow', 'image/jpg') } }
  end
  let(:destroy_params) { {:id => a_workflow.id} }


  context "with permissions" do

    describe "#index" do
      before { get_index }

      it { expect(assigns(:workflows)) }
      it { expect(response).to be_success }
    end

    describe "#new" do
      before { get :new }

      it { expect(assigns(:workflow)) }
      it { expect(response).to render_template('show') }
      it { expect(response).to be_success }
    end

    describe "#show" do
      before { get_show }

      it { expect(assigns(:workflow)) }
      it { expect(response).to be_success }
    end

    describe "#create" do

      context "with valid data" do
        before do 
          post_create
        end
        it { expect(assigns(:workflow)) }
        it { expect(response).to redirect_to(workflows_path) }
      end

      context "with invalid data" do
        before do 
          post_create 
        end
        let(:create_params) {{:workflow => {:name => ""}}}
        it { expect(response).to render_template('') }
        it { expect(assigns(:workflow)) }
      end

    end

    describe "#update" do
      context "with valid data" do
        before do
          put_update
        end

        it { expect(assigns(:workflow)) }
        it { expect(response).to render_template('show') }
      end

      context "with invalid data" do
        before do
          put_update
        end
        let(:update_params) {{:id => a_workflow.id, :workflow => {:name => "" }}}

        it { expect(response).to render_template('show') }
      end

    end

    describe "destroy" do
      before do
        delete_destroy
      end
      it { expect(response).to redirect_to(workflows_path) }
    end

  end


  context "without persmissions" do

    describe "#show" do
      before { ability.cannot :read, Workflow }
      it_behaves_like "show_access_forbidden"
    end

    describe "#create" do
      before { ability.cannot :create, Workflow }
      it_behaves_like "create_access_forbidden"
    end

    describe "#update" do
      before { ability.cannot :update, Workflow }
      it_behaves_like "update_access_forbidden"
    end

    describe "#destroy" do
      before { ability.cannot :destroy, Workflow }
      it_behaves_like "destroy_access_forbidden"
    end
  end

end

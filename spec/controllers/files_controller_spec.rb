require 'spec_helper'

describe FilesController do
  include_context "controller_spec"
  include_context "with_current_user"
  include_context "with_ability"
  before do
    sign_in current_user
  end

  let(:current_user) { create(:user) }
  let(:show_params) {{:id => a_file.id}}
  let(:update_params) {{:id => a_file.id, :uploaded_file => {:name => "New name" }}}
  let(:a_file) { current_user.uploaded_files.first }
  let(:file) {a_file.file}
  let(:create_params) do 
    {:uploaded_file => {:name => "New file", :file => fixture_file_upload('/workflow_example.t2flow', 'image/jpg') } }
  end
  let(:destroy_params) { {:id => a_file.id} }


  context "with permissions" do

    describe "#index" do
      before { get_index }

      it { expect(assigns(:files)) }
      it { expect(response).to be_success }
    end

    describe "#new" do
      before { get :new }

      it { expect(assigns(:file)) }
      it { expect(response).to render_template('show') }
      it { expect(response).to be_success }
    end

    describe "#show" do
      before { get_show }

      it { expect(assigns(:file)) }
      it { expect(response).to be_success }
    end

    describe "#create" do

      context "with valid data" do
        before do 
          post_create
        end
        it { expect(assigns(:file)) }
        it { expect(response).to redirect_to(files_path) }
      end

      context "with invalid data" do
        before do 
          post_create 
        end
        let(:create_params) {{:uploaded_file => {:name => ""}}}
        it { expect(response).to render_template('') }
        it { expect(assigns(:file)) }
      end

    end

    describe "#update" do
      context "with valid data" do
        before do
          put_update
        end

        it { expect(assigns(:file)) }
        it { expect(response).to render_template('show') }
      end

      context "with invalid data" do
        before do
          put_update
        end
        let(:update_params) {{:id => a_file.id, :uploaded_file => {:name => "" }}}

        it { expect(response).to render_template('show') }
      end

    end

    describe "destroy" do
      before do
        delete_destroy
      end
      it { expect(response).to redirect_to(files_path) }
    end

  end


  context "without persmissions" do

    describe "#show" do
      before { ability.cannot :read, UploadedFile }
      it_behaves_like "show_access_forbidden"
    end

    describe "#create" do
      before { ability.cannot :create, UploadedFile }
      it_behaves_like "create_access_forbidden"
    end

    describe "#update" do
      before { ability.cannot :update, UploadedFile }
      it_behaves_like "update_access_forbidden"
    end

    describe "#destroy" do
      before { ability.cannot :destroy, UploadedFile }
      it_behaves_like "destroy_access_forbidden"
    end
  end

end

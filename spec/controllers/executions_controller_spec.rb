require 'spec_helper'

describe ExecutionsController do
  include_context "controller_spec"
  include_context "with_current_user"
  include_context "with_ability"

  let(:current_user) { create(:user) }
  let(:show_params) {{:id => current_user.executions.first.id }}
  let(:create_params) {{:execution => {:input_parameters => "input1"}}}

  context "with permissions" do

    describe "#index" do
      before { get_index }

      it { expect(assigns(:executions)) }
      it { expect(response).to be_success }
    end

    describe "#new" do
      before { get :new }

      it { expect(assigns(:execution)) }
      it { expect(response).to render_template('show') }
      it { expect(response).to be_success }
    end

    describe "#show" do
      before { get_show }

      it { expect(assigns(:execution)) }
      it { expect(response).to be_success }
    end

    describe "#create" do
      before { post_create }

      it { expect(assigns(:execution)) }
      it { expect(response).to redirect_to(execution_path(assigns(:execution))) }
    end
  end


  context "without persmissions" do

    describe "#show" do
      before { ability.cannot :read, Execution }
      it_behaves_like "show_access_forbidden"
    end

    describe "#create" do
      before { ability.cannot :create, Execution }
      it_behaves_like "create_access_forbidden"
    end
  end

end

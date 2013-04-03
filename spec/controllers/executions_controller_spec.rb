require 'spec_helper'

describe ExecutionsController do
  include_context "controller_spec"
  include_context "with_current_user"
  include_context "with_ability"

  let(:current_user) { create(:user) }
  let(:show_params) {{:id => current_user.executions.first.id }}
  let(:create_params) {{:execution => {:name => "New execution"}}}

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
      it { expect(response).to redirect_to(executions_path) }

      context "with invalid data" do
        let(:create_params) {{:execution => {:name => "" }}}
        it { expect(response).to render_template('show') }
      end

    end

    describe "#notify" do
      before do
        Execution.should_receive(:find_by_taverna_id).and_return(execution)
        execution.should_receive(:update_status)
        execution.should_receive(:finished?).and_return(true)
        execution.should_receive(:update_results)
        execution.should_receive(:save)

        post :notify, :id => "96368d3b-3055-400d-89c1-2ead439230bf"
      end
      let(:execution) { current_user.executions.first }

      it { expect(assigns(:execution)) }
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

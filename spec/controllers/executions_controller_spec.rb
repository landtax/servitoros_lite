require 'spec_helper'

describe ExecutionsController do
  render_views

  before do
     controller.stub!(:current_user).and_return(user)
  end

  let(:user) { create(:user) }

  describe "#index" do
    before { get :index }

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
    before { get :show, :id => user.executions.first.id }

    it { expect(assigns(:execution)) }
    it { expect(response).to be_success }
  end

  describe "#create" do
    let(:params) {{:input_parameters => "input1"}}

    before { post :create, :execution => params }

    it { expect(assigns(:execution)) }
    it { expect(response).to redirect_to(execution_path(assigns(:execution))) }
  end

end

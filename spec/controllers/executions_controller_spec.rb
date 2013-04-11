require 'spec_helper'

describe ExecutionsController do
  include_context "controller_spec"
  include_context "with_current_user"
  include_context "with_ability"

  let(:current_user) { create(:user) }
  let(:show_params) {{:id => an_execution.id}}
  let(:update_params) {{:id => an_execution.id, :execution => {:name => "New name" }}}
  let(:an_execution) { current_user.executions.first }
  let(:create_params) do 
    {:execution => {:name => "New execution", :input_parameters => input_parameters  } }
  end
  let(:input_parameters) do
    {"inputs"=> {"input_urls"=>
                 "http://nlp.ilsp.gr/panacea/D4.3/data/201109/ENV_ES/1.xml\r\nhttp://nlp.ilsp.gr/panacea/D4.3/data/201109/ENV_ES/2.xml",
                   "language"=>"es"}}
  end

  context "with permissions" do

    describe "#index" do
      before { get_index }

      it { expect(assigns(:executions)) }
      it { expect(response).to be_success }
    end

    describe "#new" do
      before { get :new }

      it { expect(assigns(:execution)) }
      it { expect(assigns(:input_descriptor)) }
      it { expect(assigns(:input_ports)) }
      it { expect(response).to render_template('show') }
      it { expect(response).to be_success }
    end

    describe "#show" do
      before { get_show }

      it { expect(assigns(:execution)) }
      it { expect(response).to be_success }
    end

    describe "#create" do

      context "with valid data" do
        before do 
          Execution.any_instance.should_receive(:run!)
          post_create 
        end
        it { expect(assigns(:execution)) }
        it { expect(assigns(:execution).input_parameters).to eq input_parameters }
        it { expect(response).to redirect_to(executions_path) }
      end

      context "with invalid data" do
        before do 
          post_create 
        end
        let(:create_params) {{:execution => {:name => "" }}}
        it { expect(response).to render_template('show') }
      end

      context "with invalid input_parameters" do
        before do 
          post_create 
        end
        let(:input_parameters) do
          {"inputs"=> {"input_urls"=>
                       "",
                         "language"=>""}}
        end
        it { expect(response).to redirect_to(executions_path) }
      end

    end

    describe "#update" do
      context "with valid data" do
        before do
          Execution.stub(:find).and_return(an_execution)
          an_execution.should_receive(:update_attributes).with((update_params[:execution].merge({:user_id => current_user.id}).stringify_keys))
          put_update
        end

        it { expect(assigns(:input_descriptor)) }
        it { expect(assigns(:input_ports)) }
        it { expect(assigns(:execution)) }
        it { expect(response).to render_template('show') }
      end

      context "with invalid data" do
        before do
          put_update
        end
        let(:update_params) {{:id => an_execution.id, :execution => {:name => "" }}}

        it { expect(response).to render_template('show') }
      end

    end

    describe "#notify" do
      before do
        Execution.should_receive(:find_by_taverna_id).and_return(an_execution)
        an_execution.should_receive(:update_status)
        an_execution.should_receive(:finished?).and_return(true)
        an_execution.should_receive(:update_results)
        an_execution.should_receive(:save)

        post :notify, :id => "96368d3b-3055-400d-89c1-2ead439230bf"
      end

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

    describe "#update" do
      before { ability.cannot :update, Execution }
      it_behaves_like "update_access_forbidden"
    end
  end

end

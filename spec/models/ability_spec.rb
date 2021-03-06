require 'spec_helper'
require 'cancan/matchers'

describe "Abilities" do
  let(:ability) { Ability.new(user) }
  let(:user) { create(:user) }
  subject { ability }

  describe "Basic user" do
    let(:own_execution) { user.executions.first }
    let(:others_execution) { create(:execution, :user_id => -1) }
    let(:own_workflow) { user.workflows.first }
    let(:others_workflow) { create(:workflow, :user_id => -1) }

    it { should be_able_to(:manage, own_execution) }
    it { should_not be_able_to(:manage, others_execution) }

    it { should be_able_to(:manage, own_workflow) }
    it { should_not be_able_to(:manage, others_workflow) }
  end

end

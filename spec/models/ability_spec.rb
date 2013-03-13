require 'spec_helper'
require 'cancan/matchers'

describe "Abilities" do
  let(:ability) { Ability.new(user) }
  let(:user) { create(:user) }
  subject { ability }

  describe "Basic user" do
    let(:own_execution) { user.executions.first }
    let(:others_execution) { create(:execution, :user_id => -1) }

    it { should be_able_to(:manage, own_execution) }
    it { should_not be_able_to(:manage, others_execution) }
  end

end

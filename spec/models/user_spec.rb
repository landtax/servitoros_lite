require 'spec_helper'

describe User do
  subject {FactoryGirl.build(:user)}

  its(:email){ "test_mail@mymail.com"}
  

end

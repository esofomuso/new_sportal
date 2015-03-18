require '../spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  it "has courses taken" do
    user = FactoryGirl.build(:user)
    course = FactoryGirl.build(:course)

  end
end
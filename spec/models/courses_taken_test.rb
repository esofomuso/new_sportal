require '../spec_helper'

describe CoursesTaken do
  it "has a valid factory" do
    FactoryGirl.create(:courses_taken).should be_valid
  end
  it "is invalid without user_id" do
    FactoryGirl.build(:courses_taken, user_id: nil).should_not be_valid
  end

  it "is invalid without course_id" do
    FactoryGirl.build(:courses_taken, course_id: nil).should_not be_valid
  end
end
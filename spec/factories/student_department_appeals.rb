# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student_department_appeal do
    user_id 1
    department_id 1
    comment "MyString"
  end
end

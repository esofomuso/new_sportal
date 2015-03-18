FactoryGirl.define do
  factory :user do |f|
    f.email {Faker::Internet.safe_email}
    f.password {Faker::Internet.password}

  end

  factory :course do |f|
    f.name {Faker::Name.first_name}
    f.description {Faker::Lorem.sentence}
  end
end
FactoryGirl.define do
  factory :user, class: User do
    name Faker::Name.name
    email Faker::Internet.email
    password "12345678"
    password_confirmation "12345678"
    status CommonStatus.list.sample
  end
end

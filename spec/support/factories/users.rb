FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "12345678" }
    password_confirmation { "12345678" }
    status { CommonStatus.list.sample }
  end

  factory :invalid_user, parent: :user do
    name nil
    email nil
    password nil
    password_confirmation nil
    status nil
  end

end

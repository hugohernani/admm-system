FactoryGirl.define do
  factory :blogger do
    user
    theme { Faker::Name.title }
    description { Faker::Lorem.sentence(10, true, 10) }
    status { CommonStatus.list.sample }
  end

  factory :invalid_blogger, parent: :blogger do
    theme nil
    description nil
    status nil
  end
end

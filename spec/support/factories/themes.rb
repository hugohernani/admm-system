FactoryGirl.define do
  factory :theme do
    blogger
    title { Faker::Name.title }
    description { Faker::Lorem.sentence(10, true, 10) }
    status { CommonStatus.list.sample }
  end

  factory :invalid_theme, parent: :theme do
    title nil
    description nil
    status nil
  end
end

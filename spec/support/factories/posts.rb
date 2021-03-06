FactoryGirl.define do
  factory :post do
    theme
    title { Faker::Name.title }
    description { Faker::Lorem.sentence(10, true, 10) }
    body { Faker::Lorem.sentence(10, true, 10) }
  end

  factory :invalid_post, parent: :post do
    title nil
    description nil
    body nil
  end

end

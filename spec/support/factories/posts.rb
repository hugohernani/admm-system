FactoryGirl.define do
  factory :post do
    blogger
    title { Faker::Name.title }
    description { Faker::Lorem.sentence(10, true, 10) }
    body { Faker::Lorem.sentence(10, true, 10) }
  end

  factory :invalid_post, parent: :blog_post do
    title nil
    description nil
    body nil
  end

end

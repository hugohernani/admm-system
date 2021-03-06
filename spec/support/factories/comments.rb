FactoryGirl.define do
  factory :comment do
    user
    post
    visitor_name { Faker::Name.title }
    content { Faker::Lorem.sentence(10, true, 10) }
  end

  factory :invalid_comment, parent: :comment do
    title { nil }
    content { nil }
  end
end

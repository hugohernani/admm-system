FactoryGirl.define do
  factory :blog_comment, class: 'Blog::Comment' do
    user
    association :post, factory: :blog_post
    title { Faker::Name.title }
    content { Faker::Lorem.sentence(10, true, 10) }
  end

  factory :invalid_blog_comment, parent: :blog_comment do
    title { nil }
    content { nil }
  end
end

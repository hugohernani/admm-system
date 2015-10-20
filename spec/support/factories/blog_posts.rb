FactoryGirl.define do
  factory :blog_post, :class => 'Blog::Post' do
    user
    title { Faker::Name.title }
    description { Faker::Lorem.sentence(10, true, 10) }
    body { Faker::Lorem.sentence(10, true, 10) }
  end

  factory :invalid_blog_post, parent: :blog_post do
    title nil
    description nil
    body nil
  end

end

require 'factory_girl'
require 'faker'
ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

@user = User.create!(
  name: "Hugo Hernani",
  email: 'hhernanni@gmail.com',
  password: '12345678',
  password_confirmation: '12345678',
  status: CommonStatus::ACTIVE)

@blogger = FactoryGirl.create(:blogger, user: @user)
@post = FactoryGirl.create(:blog_post, user: @user)
@comment = FactoryGirl.create(:blog_comment, post: @post, user: @user, content: "New content")

require 'factory_girl'
require 'faker'
ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

@user = User.new(
  name: "Hugo Hernani",
  email: 'hhernanni@gmail.com',
  password: '12345678',
  password_confirmation: '12345678',
  status: CommonStatus::ACTIVE)
@user.skip_confirmation!
@user.save!

@blogger = FactoryGirl.create(:blogger, user: @user)
@post = FactoryGirl.create(:post, blogger: @blogger)
@comment = FactoryGirl.create(:comment, post: @post, user: @user, content: "New content")

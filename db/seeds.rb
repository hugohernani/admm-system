require 'factory_girl'
require 'faker'
ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

@admin = Role.create(
  name: "Admnistrador",
  description: "Papel de administrador",
  kind: RoleKind::ADMIN)

@blogger_role = Role.create(
  name: "Blogeiro",
  description: "Papel de blogueiro",
  kind: RoleKind::BLOGGER)

@user = User.new(
  name: "Hugo Hernani",
  email: 'hhernanni@gmail.com',
  password: '12345678',
  password_confirmation: '12345678',
  status: CommonStatus::ACTIVE,
  roles: [@admin, @blogger_role])

@user.skip_confirmation!
@user.save!

@user2 = User.new(
  name: "Pedro Henrique",
  email: 'pedro@gmail.com',
  password: '12345678',
  password_confirmation: '12345678',
  status: CommonStatus::ACTIVE,
  roles: [@blogger_role])
@user2.skip_confirmation!
@user2.save!

@blogger = FactoryGirl.create(:blogger, user: @user)
@blogger2 = FactoryGirl.create(:blogger, user: @user2)
@post = FactoryGirl.create(:post, blogger: @blogger)
@post3 = FactoryGirl.create(:post, blogger: @blogger)
@post4 = FactoryGirl.create(:post, blogger: @blogger)
@post2 = FactoryGirl.create(:post, blogger: @blogger2)
@comment = FactoryGirl.create(:comment, post: @post, user: @user2, content: "New content")
@comment = FactoryGirl.create(:comment, post: @post2, user: @user, content: "New content")

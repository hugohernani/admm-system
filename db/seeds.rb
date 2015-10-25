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
@theme1 = FactoryGirl.create(:theme, blogger: @blogger, status: CommonStatus::ACTIVE)
@theme2 = FactoryGirl.create(:theme, blogger: @blogger, status: CommonStatus::ACTIVE)
@theme3 = FactoryGirl.create(:theme, blogger: @blogger2, status: CommonStatus::ACTIVE)
@post = FactoryGirl.create(:post, theme: @theme1, status: CommonStatus::ACTIVE)
@post3 = FactoryGirl.create(:post, theme: @theme2, status: CommonStatus::ACTIVE)
@post4 = FactoryGirl.create(:post, theme: @theme1, status: CommonStatus::ACTIVE)
@post2 = FactoryGirl.create(:post, theme: @theme3, status: CommonStatus::ACTIVE)
@comment = FactoryGirl.create(:comment, post: @post, user: @user2, content: "New content")
@comment = FactoryGirl.create(:comment, post: @post2, user: @user, content: "New content")
@comment = FactoryGirl.create(:comment, post: @post, visitor_name: "Bruno Henrique", content: "New content", user: nil)

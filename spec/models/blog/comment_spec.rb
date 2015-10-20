require 'rails_helper'

module Blog
  RSpec.describe Comment, type: :model do
    context 'associations' do
      it { is_expected.to belong_to(:user)}
      it { is_expected.to belong_to(:post)}
    end

    context 'model validations' do
      it { is_expected.to validate_presence_of(:content) }
      it { is_expected.to validate_presence_of(:post) }
      it { is_expected.to validate_presence_of(:user) }
    end

    context 'table fields' do
      it { is_expected.to have_db_column(:title).of_type(:string) }
      it { is_expected.to have_db_column(:content).of_type(:text) }
      it { is_expected.to have_db_column(:blog_post_id).of_type(:integer) }
      it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    end

    context 'table indexes' do
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to have_db_index(:blog_post_id) }
    end

    context 'factories' do
      it { expect(build(:blog_comment)).to be_valid }
      it { expect(build(:invalid_blog_comment)).to_not be_valid }
    end

  end
end

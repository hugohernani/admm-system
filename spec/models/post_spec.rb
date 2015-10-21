require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:blogger)}
    it { is_expected.to have_many(:comments)}
  end

  context 'model validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:blogger) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_inclusion_of(:status).in_array(::CommonStatus.list) }
  end

  context 'table fields' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:body).of_type(:text) }
    it { is_expected.to have_db_column(:status).of_type(:integer) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
  end

  context 'table indexes' do
    it { is_expected.to have_db_index(:user_id) }
  end

  context 'factories' do
    it { expect(build(:post)).to be_valid }
    it { expect(build(:invalid_post)).to_not be_valid }
  end
end

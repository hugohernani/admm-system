require 'rails_helper'

RSpec.describe Blogger, type: :model do

  context 'associations' do
    it { is_expected.to belong_to(:user)}
    it { is_expected.to have_many(:posts)}
  end

  context 'model validations' do
    it { is_expected.to validate_presence_of(:theme) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_inclusion_of(:status).in_array(::CommonStatus.list) }
    it { is_expected.to validate_presence_of(:user) }
  end

  context 'table fields' do
    it { is_expected.to have_db_column(:theme).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:slug).of_type(:string) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
  end

  context 'table indexes' do
    it { is_expected.to have_db_index(:user_id) }
  end

  context 'factories' do
    it { expect(build(:blogger)).to be_valid }
    it { expect(build(:invalid_blogger)).to_not be_valid }
  end
end

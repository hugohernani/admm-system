FactoryGirl.define do
  factory :blogger do
    user
    status { CommonStatus.list.sample }
  end

  factory :invalid_blogger, parent: :blogger do
    status nil
  end
end

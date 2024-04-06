FactoryBot.define do
  factory :report do
    name { "MyString" }
    institution { create(:institution) }
    creation_scope { rand(1..3) }
    by { create(:user) }
  end
end

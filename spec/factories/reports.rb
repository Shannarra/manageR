FactoryBot.define do
  factory :report do
    name { "MyString" }
    institution { create(:institution) }
    creation_scope { 1 }
    by { create(:user) }
  end
end

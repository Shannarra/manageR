FactoryBot.define do
  factory :i_class do
    name { "MyString" }
    year { 1 }
    institution { create(:institution) }
  end
end

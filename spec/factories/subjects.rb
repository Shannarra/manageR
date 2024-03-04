FactoryBot.define do
  factory :subject do
    name { "MyString" }
    year { 1 }
    description { "MyString" }
    user { create(:user) }
    i_class { create(:i_class) }
  end
end

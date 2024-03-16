FactoryBot.define do
  factory :grade do
    value { 4 }
    reason { "MyString" }
    source_type { :regular }
    assignee { build(:user, institution: create(:institution)) }
    assigned_by { build(:user, institution: Institution.last) }
  end
end

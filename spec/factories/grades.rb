FactoryBot.define do
  factory :grade do
    value { 4 }
    reason { "MyString" }
    source_type { :regular }
    assignee { build(:user, institution: build(:institution, id: 1)) }
    assigned_by { build(:user, institution: build(:institution, id: 1)) }
  end
end

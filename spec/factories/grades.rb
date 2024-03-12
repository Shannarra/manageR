FactoryBot.define do
  factory :grade do
    value { 1 }
    reason { "MyString" }
    source { 1 }
    assignee { 1 }
    assigned_by { 1 }
  end
end

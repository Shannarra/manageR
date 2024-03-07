FactoryBot.define do
  factory :exam do
    exam_type { 1 }
    subject { nil }
    user { nil }
    schedule { "2024-03-07" }
  end
end

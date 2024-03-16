FactoryBot.define do
  factory :exam do
    name { Faker::Internet.name }
    exam_type { :physical }
    subject { create(:subject) }
    user { create(:user) }
    schedule { 5.days.from_now }
  end
end

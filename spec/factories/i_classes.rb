FactoryBot.define do
  factory :i_class do
    name { Faker::Educator.course_name }
    year { 1 }
    institution { create(:institution) }
  end
end

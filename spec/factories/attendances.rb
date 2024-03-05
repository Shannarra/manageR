FactoryBot.define do
  factory :attendance do
    attendance_type { :present }
    teacher_id { create(:user) }
    student_id { create(:user) }
    i_class { create(:i_class) }
  end
end

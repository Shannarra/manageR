FactoryBot.define do
  factory :attendance do
    attendance_type { :present }
    teacher { create(:user) }
    student { create(:user) }
    i_class { create(:i_class) }
    partial { false }
  end
end

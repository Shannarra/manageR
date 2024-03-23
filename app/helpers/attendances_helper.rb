module AttendancesHelper
  def accessible_users
    User.where(institution: current_user.institution)
  end

  def accessible_teachers
    select_options accessible_users
                     .where(access_type: :teacher)
  end

  def accessible_students
    select_options accessible_users
                     .where(access_type: :student)
  end

  def accessible_classes
    select_options IClass
                     .where(institution_id: institution)
  end

  def teacher(attendance)
    User.find(attendance.teacher_id)
  end

  def student(attendance)
    User.find(attendance.student_id) unless attendance.partial
  end

  def class_students(klass)
    User.where(i_class: klass, access_type: :student)
  end
end

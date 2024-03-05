module AttendancesHelper
  def accessible_users
    User.where(institution: current_user.institution)
  end

  def accessible_teachers
    accessible_users
      .where(access_type: :teacher)
      .map {|x| [x.name, x.id] }
  end

  def accessible_students
    accessible_users
      .where(access_type: :student)
      .map {|x| [x.name, x.id] }
  end

  def accessible_classes
    IClass
      .for(current_user.institution)
      .map {|x| [x.name, x.id] }
  end

  def teacher(attendance)
    User.find(attendance.teacher_id)
  end

  def student(attendance)
    User.find(attendance.student_id)
  end
end

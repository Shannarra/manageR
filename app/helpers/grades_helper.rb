module GradesHelper
  def users_for(type)
    institution.users.where(access_type: type)
  end

  def assignees
    select_options users_for(:student)
  end

  def teachers
    select_options users_for(:teacher)
  end

  def available_exams
    select_options Exam.where(user: institution.users.pluck(:id))
  end
end

module ExamsHelper
  def future?(exam)
    exam.schedule.future?
  end

  def humanized_schedule(exam)
    future?(exam) ?
      "in #{time_ago_in_words exam.schedule}" :
      "#{time_ago_in_words exam.schedule} ago"
  end

  def institution_subjects
    select_options Subject.where(
      i_class: IClass.for(institution).pluck(:id)
    )
  end

  def institution_teachers
    select_options User.where(institution: institution)
                     .where(access_type: :teacher)
  end
end

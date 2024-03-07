module SubjectsHelper
  def institution_users
    select_options Institution.find(current_user.institution.id).users
  end

  def subject_institution_classes
    select_options IClass.for(current_user.institution.id)
  end
end

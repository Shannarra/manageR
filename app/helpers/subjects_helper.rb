module SubjectsHelper
  def institution_users
    Institution.find(current_user.institution.id).users.map {|x| [x.name, x.id]}
  end

  def institution_classes
    IClass.for(current_user.institution.id).map {|x| [x.name, x.id]}
  end
end

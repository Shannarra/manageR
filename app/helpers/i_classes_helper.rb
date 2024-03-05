module IClassesHelper
  def students_for_class(klass)
    User.where(i_class: klass).count
  end
end

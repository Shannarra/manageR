module IClassesHelper
  def students_for_class(klass)
    User.where(i_class: klass, access_type: :student).count
  end
end

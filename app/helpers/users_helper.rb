module UsersHelper
  def can_change_access?
    @user != current_user && greater_access?
  end

  def greater_access?
    current_user.admin? || current_user.director?
  end

  def institution_classes(user_id)
    select_options IClass.for(user_id)
  end

  # def modal
  #   {
  #     title: 'Delete my profile',
  #     content: "<p> #{current_user.name}, you are about to <b>permamently delete</b> your profile.</p>
  #                   This action is not reversable. Are you sure?".html_safe,
  #     confirm: 'I understand, delete my profile',
  #   }
  # end
end

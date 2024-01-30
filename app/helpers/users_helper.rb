module UsersHelper
  def can_change_access?
    @user == current_user && greater_access?
  end

  def greater_access?
    @user.admin? || @user.director?
  end
end

module UsersHelper
  def can_change_access?
    @user == current_user && greater_access?
  end

  def greater_access?
    @user.admin? || @user.director?
  end

  def user_access_visible_to_me
    visible = %w[student]
    visible << %w[teacher director] if current_user.teacher? || current_user.director? || current_user.admin?
    visible << 'admin' if current_user.admin?

    visible.flatten
  end

  def users_visible_to_me
    @users.select do |user|
      user_access_visible_to_me.include? user.access_type
    end.sort_by(&:access_type)
  end
end

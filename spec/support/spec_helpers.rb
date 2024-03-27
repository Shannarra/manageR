module SpecHelpers
  def sign_in_user(user)
    @user = user
    sign_in(@user)
    @user
  end

  def current_user
    @user
  end
end

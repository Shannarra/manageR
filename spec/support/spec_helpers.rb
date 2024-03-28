module SpecHelpers
  def sign_in_user(user)
    @user = user
    sign_in(@user)
    @user
  end

  def current_user
    @user
  end

  # FactoryBot#build does not do the job we want
  def fabricate_user(access, institution= create(:institution), i_class= create(:i_class))
    User.create!(email: "test@mail.com", password: '123456', access_type: :director, institution: institution, i_class: i_class)
  end
end

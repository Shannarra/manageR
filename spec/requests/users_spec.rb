require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "trying to access content when not logged in" do
    it 'trying to access /users redirects to sign_in' do
      get manage_users_path
      expect(response.code).to eq '302' # :found
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'trying to access /users/:{id} redirects to sign_in' do
      get user_path(user)
      expect(response.code).to eq '302' # :found
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'trying to access /users/new redirects to sign_in' do
      put new_user_path
      expect(response.code).to eq '302' # :found
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'that are logged in can access' do
    before do
      sign_in user
    end

    it 'can access /users' do
      get users_path
      expect(response).not_to be_successful
    end

    it 'can access /users/:{id} successfully' do
      get user_path(user)
      expect(response).to be_successful
    end
  end
end

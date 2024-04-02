require "rails_helper"

RSpec.describe "users/verify_code" do
  include RSpecHtmlMatchers

  let(:user) { create(:user) }

  before do
    sign_in_user(user)
    render locals: { user: user }
  end

  context 'renders correctly' do
    it 'with all fields nessessary' do
      expect(rendered).to have_tag 'form' do
        with_tag 'input', with: { type: :text, name: "user[institution_code]" }
        with_tag 'input', with: { type: :password, name: "user[password]" }
        with_tag 'input', with: { type: :submit }
      end
    end
  end
end

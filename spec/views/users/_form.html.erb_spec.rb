require "rails_helper"

RSpec.describe "users/_form" do
  include RSpecHtmlMatchers

  let(:user) { create(:user) }

  before do
    sign_in_user(user)
    render locals: { user: user }
  end

  context 'renders correctly' do
    it 'with all fields nessessary' do
      expect(rendered).to have_tag 'form', with: { action: user_path(user) } do
        with_tag 'input', with: { type: :file, maxlength: 50, name: "user[image]" }
        with_tag 'input', with: { type: :text, maxlength: 50, name: "user[name]" }
        with_tag 'input', with: { type: :email, name: "user[email]" }
        with_tag 'input', with: { type: :submit }
      end
    end
  end
end

require "rails_helper"

RSpec.describe "i_classes/_form" do
  include RSpecHtmlMatchers

  let(:user) { create(:user) }
  let(:klass) { create(:i_class) }

  before do
    sign_in_user(user)
    assign(:klass, klass)
    render locals: { klass: klass }
  end

  context 'renders correctly' do
    it 'with all fields nessessary' do
      expect(rendered).to have_tag 'form', with: { action: class_path(institution_id: institution, class_id: klass) } do
        with_tag 'input', with: { type: :text, maxlength: 50, name: "i_class[name]" }
        with_tag 'input', with: { type: :text, maxlength: 50, name: "i_class[year]" }
        with_tag 'textarea', with: { rows: 20, name: "i_class[description]" }
      end
    end
  end
end

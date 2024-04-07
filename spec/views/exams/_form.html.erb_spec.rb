require "rails_helper"

RSpec.describe "exams/_form" do
  include RSpecHtmlMatchers

  let(:user) { create(:user) }
  let(:exam) { create(:exam) }

  before do
    sign_in_user(user)
    assign(:exam, exam)
    render locals: { exam: exam }
  end

  context 'renders correctly' do
    it 'with all fields nessessary' do
      expect(rendered).to have_tag 'form', with: {
                                     action: exam_path(exam)
                                   } do
        with_tag 'input', with: { type: :text, maxlength: 50, name: "exam[name]" }
        with_tag 'select', with: { name: "exam[exam_type]" }
        with_tag 'select', with: { name: "exam[subject_id]" }
        with_tag 'select', with: { name: "exam[user_id]" }
        with_tag 'input', with: { type: :file, name: "exam[attachment]" }
        with_tag 'input', with: { type: :date, name: "exam[schedule]" }
      end
    end
  end
end

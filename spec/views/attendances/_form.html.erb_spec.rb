require "rails_helper"

RSpec.describe "attendances/_form" do
  include RSpecHtmlMatchers

  let(:user) { create(:user) }
  let(:attendance) { create(:attendance) }

  before do
    sign_in_user(user)
    assign(:attendance, attendance)
    render locals: { attendance: attendance }
  end

  context 'renders correctly' do
    it 'with all fields nessessary' do
      expect(rendered).to have_tag 'form', with: { action: attendance_path(attendance) } do
        with_tag 'select', with: { name: "attendance[i_class_id]" }
        with_tag 'select', with: { name: "attendance[teacher_id]" }
        with_tag 'select', with: { name: "attendance[student_id]" }
        with_tag 'select', with: { name: "attendance[attendance_type]" }
        with_tag 'input', with: { type: :submit }
      end
    end
  end
end

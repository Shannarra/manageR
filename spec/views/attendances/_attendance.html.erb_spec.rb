require "rails_helper"

RSpec.describe "attendances/_attendance" do
  include RSpecHtmlMatchers

  let(:user) { create(:user) }
  let(:attendance) { create(:attendance) }

  before do
    sign_in_user(user)
    assign(:attendance, attendance)
    render locals: { attendance: attendance }
  end

  context 'renders correctly' do
    it 'with all rows and titles nessessary' do
      expect(rendered).to have_tag 'div', with: { class: 'card-body' }

      expect(rendered).to have_tag 'p', with: { class: 'mb-0' }, count: 4

      expect(rendered).to have_tag 'p', text: 'Student name'
      expect(rendered).to have_tag 'p', text: 'Attendance'
      expect(rendered).to have_tag 'p', text: 'Teacher'
      expect(rendered).to have_link text: 'Show this attendance'
    end

    it 'with all column info nessessary' do
      expect(rendered).to have_tag 'h4', text: attendance.student.name
      expect(rendered).to have_tag 'h4', inner_text: attendance.attendance_type
      expect(rendered).to have_tag 'h4', text: attendance.teacher.name
    end
  end
end

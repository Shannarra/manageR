require "rails_helper"

RSpec.describe "exams/index" do
  let(:user) { create(:user) }

  before do
    sign_in_user(user)
    assign(:exams, create_list(:exam, 10))
    render
  end

  context 'renders correctly' do
    it 'shows basic info' do
      expect(rendered).to have_content 'Exams'
    end
  end

  context 'renders partial "class" correctly' do
    let(:exam) { create(:exam) }

    it 'shows exam correctly' do
      render partial: 'exams/exam', locals: { exam: exam }

      expect(rendered).to have_selector('h4', text: exam.name)
      expect(rendered).to have_selector('p', text: "Teacher name")
      expect(rendered).to have_selector('h4', text: exam.user.name)
      expect(rendered).to have_selector('h4', text: exam.subject.name)
    end
  end
end

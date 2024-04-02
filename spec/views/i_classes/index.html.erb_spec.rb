require "rails_helper"

RSpec.describe "i_classes/index" do
  let(:user) { create(:user) }

  before do
    sign_in_user(user)
    assign(:i_classes, create_list(:i_class, 10))
    render
  end

  context 'renders correctly' do
    it 'shows basic info' do
      expect(rendered).to have_content 'Institution classes'
    end
  end

  context 'renders partial "class" correctly' do
    let(:klass) { build(:i_class, institution: institution, id: 0) }

    it 'shows klass correctly' do
      render partial: 'i_classes/i_class', locals: { i_class: klass }

      expect(rendered).to have_selector('h2', text: klass.name)
      expect(rendered).to have_selector('h6', text: "Study Year: #{klass.year}")
      expect(rendered).to have_selector('div', text: klass.description, class: 'text-roboto')
      expect(rendered).to have_link('Visit class subjects', href: subjects_url(institution_name: klass.institution.name, class_id: klass))
    end

    it 'hides edit link for users without access' do
      expect(rendered).not_to have_link "Edit this class"
    end

    context 'with director user' do
      let(:user) { fabricate_user(:director) }

      before do
        sign_in_user user
        render
      end

      it 'shows edit link for users with access' do
        expect(rendered).to have_link "Edit this class"
      end
    end
  end
end

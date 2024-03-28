require "rails_helper"

RSpec.describe "institutions/show" do
  let(:user) { create(:user) }

  before do
    sign_in_user(user)
    assign(:institution, create(:institution))
    render
  end

  context 'renders the institution information' do
    it "displays the basic info" do

      expect(rendered).to match /Classes for #{institution.name}/
      expect(rendered).to match /Location: #{institution.location}/
    end

    it 'hides add button for user without privileges' do
      expect(rendered).not_to have_link "Create a new class"
    end
  end

  context 'renders hidden fields' do
    let(:user) { fabricate_user(:director) }

    before do
      sign_in_user user
      render
    end

    it 'for people with correct access' do
      expect(rendered).to have_link "Create a new class"
    end
  end

  context 'renders partial "class" correctly' do
    let(:klass) { build(:i_class, institution: institution, id: 0) }

    it 'shows klass correctly' do
      render partial: 'institutions/class', locals: { klass: klass }

      expect(rendered).to have_selector('h1', text: klass.name)
      expect(rendered).to have_selector('h5', text: "Study year #{klass.year}")
      expect(rendered).to have_selector('p', text: klass.description)
      expect(rendered).to have_link('Visit class')
    end
  end
end

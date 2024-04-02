require "rails_helper"

RSpec.describe "institutions/manage" do
  include RSpecHtmlMatchers

  let(:user) { fabricate_user(:director) }
  let(:institutions) { create_list(:institution, 10) }

  describe 'when having institutions' do
    before do
      sign_in_user(user)
      assign(:institutions, Kaminari.paginate_array(institutions).page(1))

      render
    end

    context 'renders and' do
      it "displays the basic info" do
        expect(rendered).to have_content "Manage Institutions"
        expect(rendered).to have_link 'Go to institutions administration'
        expect(rendered).to have_content 'Find institution by name'
      end

      context 'shows a table' do

        it 'correctly' do
          expect(rendered).to have_table
        end

        it 'with correct number of rows' do
          expect(rendered).to have_tag('tr', count: institutions.count + 1)
        end

        it 'with correct data for each row' do
          institutions.each do |institution|
            expect(rendered).to have_tag 'a', text: institution.name, href: institution_url(institution_name: institution.name)

            expect(rendered).to have_content institution.location
            expect(rendered).to have_content institution.code
          end
        end
      end
    end
  end

  describe 'when having NO institutions' do
    before do
      sign_in_user(user)
      assign(:institutions, Kaminari.paginate_array([]).page(1))
      render
    end

    context 'renders and' do
      it "displays the basic info" do
        expect(rendered).to have_content "Manage Institutions"
        expect(rendered).to have_link 'Go to institutions administration'
        expect(rendered).to have_content 'Find institution by name'
      end

      it 'does NOT display a table' do
        expect(rendered).not_to have_table
      end

      it 'displays a message for failed search' do
        expect(rendered).to have_content "No matches found for #{params[:search]}"
      end
    end
  end
end

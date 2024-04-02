require "rails_helper"

RSpec.describe "users/manage" do
  include RSpecHtmlMatchers

  let(:user) { fabricate_user(:director) }
  let(:users) { create_list(:user, 10) }

  describe 'when having users' do
    before do
      sign_in_user(user)
      assign(:users, Kaminari.paginate_array(users).page(1))

      render
    end

    context 'renders and' do
      it "displays the basic info" do
        expect(rendered).to have_content "Manage Users"
        expect(rendered).to have_link "Go to users administration"
        expect(rendered).to have_content 'Find user by name'
      end

      context 'shows a table' do
        it 'correctly' do
          expect(rendered).to have_table
        end

        it 'with correct number of rows' do
          expect(rendered).to have_tag('tr', count: users.count + 1)
        end

        it 'with correct data for each row' do
          users.each do |user|
            expect(rendered).to have_tag 'a',
                                         text: user.name,
                                         href: user_url(user)

            expect(rendered).to have_tag 'td',
                                         text: user.email

            expect(rendered).to have_tag 'td',
                                         text: user.access_type

            expect(rendered).to have_tag 'a',
                                         text: user.institution.name,
                                         href: institution_url(institution_name: user.institution.name)

            expect(rendered).to have_tag 'a',
                                         text: 'Edit',
                                         href: edit_user_url(user)
          end
        end
      end
    end
  end

  describe 'when having NO users' do
    before do
      sign_in_user(user)
      assign(:users, Kaminari.paginate_array([]).page(1))
      render
    end

    context 'renders and' do
      it "displays the basic info" do
        expect(rendered).to have_content "Manage Users"
        expect(rendered).to have_link "Go to users administration"
        expect(rendered).to have_content 'Find user by name'
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

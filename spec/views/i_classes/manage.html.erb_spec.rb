require "rails_helper"

RSpec.describe "i_classes/manage" do
  include RSpecHtmlMatchers

  let(:user) { fabricate_user(:director) }
  let(:i_classes) { create_list(:i_class, 10) }

  describe 'when having i_classes' do
    before do
      sign_in_user(user)
      assign(:klasses, Kaminari.paginate_array(i_classes).page(1))

      render
    end

    context 'renders and' do
      it "displays the basic info" do
        expect(rendered).to have_content "Manage Classes"
        expect(rendered).to have_link "Go to #{current_user.institution.name} classes administration"
        expect(rendered).to have_content 'Find class by name'
      end

      context 'shows a table' do

        it 'correctly' do
          expect(rendered).to have_table
        end

        it 'with correct number of rows' do
          expect(rendered).to have_tag('tr', count: i_classes.count + 1)
        end

        it 'with correct data for each row' do
          i_classes.each do |i_class|
            expect(rendered).to have_tag 'a',
                                         text: i_class.name,
                                         href: class_url(institution_name: i_class.institution.name, class_id: i_class)

            expect(rendered).to have_content i_class.year
            expect(rendered).to have_tag 'a',
                                         text: 'Edit this class',
                                         href: edit_class_url(institution_name: i_class.institution.name, class_id: i_class)
          end
        end
      end
    end
  end

  describe 'when having NO i_classes' do
    before do
      sign_in_user(user)
      assign(:klasses, Kaminari.paginate_array([]).page(1))
      render
    end

    context 'renders and' do
      it "displays the basic info" do
        expect(rendered).to have_content "Manage Classes for #{current_user.institution.name}"
        expect(rendered).to have_link "Go to #{current_user.institution.name} classes administration"
        expect(rendered).to have_content 'Find class by name'
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

require "rails_helper"

RSpec.describe "reports/index" do
  include RSpecHtmlMatchers

  let(:user) { create(:user) }
  let(:reports) { create_list(:report, 10) }

  before do
    sign_in_user(user)
    assign(:reports, reports)
    render
  end

  context 'renders correctly' do
    it 'shows basic info' do
      expect(rendered).to have_content 'Reports'
    end

    it 'shows "new" button' do
      expect(rendered).to have_link "+ New report"
    end
  end

  context 'renders index correctly' do
    context 'shows a table' do
      it 'correctly' do
        expect(rendered).to have_table
      end

      it 'with correct number of rows' do
        expect(rendered).to have_tag('tr', count: reports.count + 1)
      end

      it 'with correct data for each row' do
        reports.each do |report|
          expect(rendered).to have_tag 'td',
                                       text: report.name

          expect(rendered).to have_tag 'td',
                                       text: report.format

          expect(rendered).to have_tag 'td',
                                       text: report.creation_scope

          expect(rendered).to have_tag 'a',
                                       text: report.by.name,
                                       href: user_url(report.by)
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "institutions/index", type: :view do
  before(:each) do
    assign(:institutions, [
      Institution.create!(
        name: "Name",
        location: "Location"
      ),
      Institution.create!(
        name: "Name",
        location: "Location"
      )
    ])
  end

  it "renders a list of institutions" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Location".to_s), count: 2
  end
end

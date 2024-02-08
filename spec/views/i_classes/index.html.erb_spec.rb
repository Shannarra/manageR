require 'rails_helper'

RSpec.describe "i_classes/index", type: :view do
  before(:each) do
    assign(:i_classes, [
      IClass.create!(
        name: "Name",
        year: 2,
        institution: create(:institution)
      ),
      IClass.create!(
        name: "Name",
        year: 2,
        institution: create(:institution)
      )
    ])
  end

  it "renders a list of i_classes" do
    render
    # cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    # assert_select cell_selector, text: Regexp.new("Name".to_s), count: i_classes.count
    # assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    # assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end

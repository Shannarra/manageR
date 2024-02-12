require 'rails_helper'

RSpec.describe "i_classes/show", type: :view do
  before(:each) do
    assign(:i_class, IClass.create!(
      name: "Name",
      year: 2,
      institution: create(:institution)
    ))
  end

  it "renders attributes in <p>" do
    render
    # expect(rendered).to match(/Name/)
    # expect(rendered).to match(/2/)
    # expect(rendered).to match(//)
  end
end

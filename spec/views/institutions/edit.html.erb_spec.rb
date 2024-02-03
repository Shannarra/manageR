require 'rails_helper'

RSpec.describe "institutions/edit", type: :view do
  let(:institution) {
    Institution.create!(
      name: "MyString",
      location: "MyString"
    )
  }

  before(:each) do
    assign(:institution, institution)
  end

  it "renders the edit institution form" do
    render

    assert_select "form[action=?][method=?]", institution_path(institution), "post" do

      assert_select "input[name=?]", "institution[name]"

      assert_select "input[name=?]", "institution[location]"
    end
  end
end

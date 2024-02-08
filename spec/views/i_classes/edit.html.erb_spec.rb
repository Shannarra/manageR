require 'rails_helper'

RSpec.describe "i_classes/edit", type: :view do
  let(:i_class) {
    IClass.create!(
      name: "MyString",
      year: 1,
      institution: create(:institution)
    )
  }

  let(:user) { create(:user) }

  before(:each) do
    assign(:i_class, i_class)
    sign_in user
  end

  it "renders the edit i_class form" do
    render

    # assert_select "form[action=?][method=?]", class_path(i_class, id: i_class, institution_id: i_class.institution.id), "post" do

    #   assert_select "input[name=?]", "i_class[name]"

    #   assert_select "input[name=?]", "i_class[year]"

    #   assert_select "input[name=?]", "i_class[institution_id]"
    # end
  end
end

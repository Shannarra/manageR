require 'rails_helper'

RSpec.describe "i_classes/new", type: :view do
  let(:i_class) { create(:i_class) }
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  it "renders new i_class form" do
    render

    # assert_select "form[action=?][method=?]", classes_path(institution_id: i_class.institution), "post" do

    #   assert_select "input[name=?]", "i_class[name]"

    #   assert_select "input[name=?]", "i_class[year]"

    #   assert_select "input[name=?]", "i_class[institution_id]"
    # end
  end
end

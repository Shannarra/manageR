require 'rails_helper'

RSpec.describe "users/index.html.erb", type: :view do
  before(:each) do
    assign(:users, [
             create(:user)
           ])
  end

  it "renders a list of users" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    # assert_select cell_selector, text: Regexp.new("Name".to_s), count: 1
    # assert_select cell_selector, text: Regexp.new("Location".to_s), count: 1
  end
end

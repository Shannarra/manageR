require "rails_helper"

RSpec.describe InstitutionsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/institutions/1").to route_to("institutions#show", institution_id: "1")
    end
  end
end

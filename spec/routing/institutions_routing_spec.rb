require "rails_helper"

RSpec.describe InstitutionsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/institutions/myinstitute").to route_to("institutions#show", institution_name: "myinstitute")
    end
  end
end

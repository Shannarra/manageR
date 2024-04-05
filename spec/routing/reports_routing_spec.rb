require "rails_helper"

RSpec.describe ReportsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "institutions/asd/reports").to route_to("reports#index", institution_name: "asd")
    end

    it "routes to #new" do
      expect(get: "institutions/asd/reports/new").to route_to("reports#new", institution_name: "asd")
    end

    it "routes to #create" do
      expect(post: "institutions/asd/reports").to route_to("reports#create", institution_name: "asd")
    end
  end
end

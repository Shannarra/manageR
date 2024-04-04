require "rails_helper"

RSpec.describe ReportsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "institutions/asd/reports").to route_to("reports#index", institution_name: "asd")
    end

    it "routes to #new" do
      expect(get: "institutions/asd/reports/new").to route_to("reports#new", institution_name: "asd")
    end

    it "routes to #show" do
      expect(get: "institutions/asd/reports/1").to route_to("reports#show", institution_name: "asd", report_id: "1")
    end

    it "routes to #edit" do
      expect(get: "institutions/asd/reports/1/edit").to route_to("reports#edit", institution_name: "asd", report_id: "1")
    end


    it "routes to #create" do
      expect(post: "institutions/asd/reports").to route_to("reports#create", institution_name: "asd")
    end

    it "routes to #update via PUT" do
      expect(put: "institutions/asd/reports/1").to route_to("reports#update", institution_name: "asd", report_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "institutions/asd/reports/1").to route_to("reports#update", institution_name: "asd", report_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "institutions/asd/reports/1").to route_to("reports#destroy", institution_name: "asd", report_id: "1")
    end
  end
end

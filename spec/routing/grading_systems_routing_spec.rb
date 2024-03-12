require "rails_helper"

RSpec.describe GradingSystemsController, type: :routing do
=begin
  Why is this done?

  In short, we want to assure that making any request to /grading_systems will redirect to
  the #action_not_found error handler.

  This assures that the only way to access the endpoing is via the ActiveAdmin endpoints,
  containing their own CRUD forms within.
=end

  describe "routing" do
    it "routes to #index" do
      expect(get: "/grading_systems").to route_to("application#action_not_found", unmatched: 'grading_systems')
    end

    it "routes to #new" do
      expect(get: "/grading_systems/new").to route_to("application#action_not_found", unmatched: 'grading_systems/new')
    end

    it "routes to #show" do
      expect(get: "/grading_systems/1").to route_to("application#action_not_found", unmatched: 'grading_systems/1')
    end

    it "routes to #edit" do
      expect(get: "/grading_systems/1/edit").to route_to("application#action_not_found", unmatched: 'grading_systems/1/edit')
    end


    it "routes to #create" do
      expect(post: "/grading_systems").to route_to("application#action_not_found", unmatched: 'grading_systems')
    end

    it "routes to #update via PUT" do
      expect(put: "/grading_systems/1").to route_to("application#action_not_found", unmatched: 'grading_systems/1')
    end

    it "routes to #update via PATCH" do
      expect(patch: "/grading_systems/1").to route_to("application#action_not_found", unmatched: 'grading_systems/1')
    end

    it "routes to #destroy" do
      expect(delete: "/grading_systems/1").to route_to("application#action_not_found", unmatched: 'grading_systems/1')
    end
  end
end

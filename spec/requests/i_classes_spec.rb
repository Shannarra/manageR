require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/classes", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # IClass. As you add validations to IClass, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:i_class)
  }

  let(:invalid_attributes) {
    attributes_for(:user)
  }

  context 'Performing requests when not logged in' do
    describe "GET /index" do
      it "renders an unsuccessful response" do
        klass = IClass.create! valid_attributes
        get class_url institution_name: klass.institution.name, class_name: klass.name
        expect(response).to_not be_successful
      end
    end

    describe "GET /show" do
      it "renders an unsuccessful response" do
        klass = IClass.create! valid_attributes
        get class_url(class_name: klass.name, institution_name: klass.institution.name)
        expect(response).to_not be_successful
      end
    end

    describe "GET /new" do
      it "renders an unsuccessful response" do
        get class_url(institution_name: 0, class_name: 0)
        expect(response).to_not be_successful
      end
    end

    describe "GET /edit" do
      it "renders a successful response" do
        klass = IClass.create! valid_attributes
        get edit_class_url(class_name: klass.name, institution_name: klass.institution.name)
        expect(response).to_not be_successful
      end
    end
  end
end

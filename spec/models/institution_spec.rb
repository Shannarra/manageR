require 'rails_helper'

RSpec.describe Institution, type: :model do
  describe 'is valid' do
    let(:institution_attribs) { attributes_for(:institution) }

    it 'with valid attributes' do
      expect(Institution.new(institution_attribs)).to be_valid
    end
  end
end

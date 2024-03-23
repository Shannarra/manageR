require 'rails_helper'

RSpec.describe Attendance, type: :model do
  let(:attendance_attribs) { attributes_for(:attendance) }
  self::MODEL_ATTRIBUTES = %w[attendance_type teacher_id student_id i_class_id] # partial is optional here

  describe 'is valid' do
    it 'with valid attributes' do
      expect(Attendance.new(attendance_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    context 'without a value' do
      self::MODEL_ATTRIBUTES.each do |attribute|
        it "for a required attribute #{attribute}" do
          attendance = Attendance.new(attendance_attribs.merge("#{attribute}": nil))
          expect(attendance).not_to be_valid
        end
      end
    end
  end

  describe 'scope' do
    let(:partials) { FactoryBot.create_list :attendance, 3, partial: true }
    let(:new_one) { create(:attendance) }

    it 'returns correct values for taking_types' do
      expect(Attendance.taking_types).not_to include :unknown
    end

    it 'returns correct values for partial' do
      expect(Attendance.partial).to match_array partials
      expect(Attendance.partial.count).to eq partials.count
    end

    it 'returns correct values for daily' do
      expect(Attendance.daily).to match_array [*partials, new_one]
    end

    let(:institution) { create(:institution) }
    let(:klass) { build(:i_class, { institution: institution }) }
    let(:same_class_attendances) {
      FactoryBot.create_list :attendance, 5, i_class: klass
    }

    it 'returns correct values for for_institution' do
      expect(Attendance.for_institution(institution)).to match_array same_class_attendances
    end
  end
end

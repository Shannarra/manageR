require 'rails_helper'

RSpec.describe Exam, type: :model do
  let(:exam_attribs) { attributes_for(:exam) }
  self::MODEL_ATTRIBUTES = %w[
    exam_type
    schedule
    name
    subject_id
    user_id
  ] # attachment and description optional

  describe 'is valid' do
    it 'with valid attributes' do
      expect(Exam.new(exam_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    context 'without a value' do
      self::MODEL_ATTRIBUTES.each do |attribute|
        it "for a required attribute #{attribute}" do
          exam = Exam.new(exam_attribs.merge("#{attribute}": nil))
          expect(exam).not_to be_valid
        end
      end
    end
  end

  describe 'scope' do
    let(:future_exams) {
      FactoryBot.create_list :exam, 5, schedule: rand(2.days.from_now..10.days.from_now)
    }

    it 'returns correct values for creation_types' do
      expect(Exam.creation_types).to_not include :unknown
    end

    it 'returns correct values for upcoming' do
      expect(Exam.upcoming).to match_array future_exams
    end

    let(:user) { create(:user) }
    let(:user_exams) {
      build(:future_exams, institution_id: user.institution)
    }

    it 'returns correct values for user_exams' do
      expect(Exam.user_exams(user)).to eq []
    end
  end
end

FactoryBot.define do
  factory :grading_system do
    name { "Bulgarian" }
    start_grade { 2 }
    end_grade { 6 }
    step { 1 }
    direction { :positive }
    description { "Test desc" }
    # possible_grades { "MyString" } #should autogen
    institution_id { Institution.first }
  end
end

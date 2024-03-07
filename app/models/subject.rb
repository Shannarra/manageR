class Subject < ApplicationRecord
  belongs_to :user
  belongs_to :i_class

  def teacher
    user
  end

  def klass
    i_class
  end
end

class IClassPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record.to_a.first # force convert to array and check only first
  end

  def index?
    return true if with_elevated_privileges?

    @record.institution_id == @user.institution.id
  end
end

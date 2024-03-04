class IClassPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    return true if with_elevated_privileges?

    @record.institution_id == @user.institution.id
  end

  def edit?
    @user.has_elevated_privileges?
  end
end

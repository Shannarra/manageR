class InstitutionPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    return true if with_elevated_privileges?

    @user.institution_code == @record.code
  end
end

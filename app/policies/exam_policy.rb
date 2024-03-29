class ExamPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.can_grade?
  end

  def show?
    true
  end

  def create?
    with_elevated_privileges? || user.can_grade?
  end

  def new?
    create?
  end

  def update?
    user.can_grade?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end

class ReportPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    privileged?
  end

  def create?
    privileged?
  end

  def new?
    create?
  end

  def update? # noop for reports
    false
  end

  def edit? # noop
    false
  end

  def destroy? # go through admin or do it automatically
    false
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

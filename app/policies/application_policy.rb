# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user:, record: nil, **args)
    @user = user
    @record = record

    super(args)
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end

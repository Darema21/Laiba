class EventPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # scope.where(user:user) # This is for users to see their own event
    end
  end

  def show?
    return true
  end

  def create?
    return true
  end

  def edit?
    return update?
  end

  def update?
    return record.user == user
  end

  def destroy?
    return record.user == user
  end
end

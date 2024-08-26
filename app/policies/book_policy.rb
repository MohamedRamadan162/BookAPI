class BookPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  def index?
    true
  end
  def show?
    true
  end
  def create?
    user.admin?
  end
  def update?
    user.admin?
  end
  def destroy?
    user.admin?
  end 
end

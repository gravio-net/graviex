module Admin
  class Ability
    include CanCan::Ability

    def initialize(user)
      return unless user.admin?

      can :read, Order
      can :read, Trade
      can :read, Proof
      can :update, Proof
      can :manage, Document
      can :manage, Member
      can :manage, Ticket
      can :manage, IdDocument
      can :manage, TwoFactor

      can :menu, Deposit
      can :menu, Withdraw

      klassnames = ::Deposits.constants.select { |cl| not (cl.to_s.include? 'able' or cl.to_s.include? 'Controller') }
      klassnames.each do |klassname|
        can :manage, "::Deposits::#{klassname}".constantize
        can :manage, "::Withdraws::#{klassname}".constantize
      end
      
    end
  end
end

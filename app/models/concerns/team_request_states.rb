module TeamRequestStates
  extend ActiveSupport::Concern

  included do
    state_machine :status, initial: :pending do
      event :accept do
        transition pending: :accepted
      end

      event :reject do
        transition pending: :rejected
      end

      after_transition on: :accept do |team_request, transition|
        team_request.request_accepted
      end

      after_transition on: :reject do |team_request, transition|
        team_request.update_column :status, :rejected
      end
    end

    statuses.each do |status|
      scope status, -> { where(status: status) }
    end
  end

  module ClassMethods
    def statuses
      state_machines[:status].states.map(&:name)
    end
  end
end

module Account::Billing
  extend ActiveSupport::Concern

  included do
    has_one :subscription, class_name: "Account::Subscription", dependent: :destroy
  end

  def plan
    subscription&.plan || Plan.default
  end
end

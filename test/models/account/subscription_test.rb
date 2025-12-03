require "test_helper"

class Account::SubscriptionTest < ActiveSupport::TestCase
  test "plan returns the Plan object" do
    subscription = Account::Subscription.new(plan_key: "free_v1")
    assert_equal Plan[:free_v1], subscription.plan
  end

  test "active? returns true when status is active" do
    subscription = Account::Subscription.new(status: "active")
    assert subscription.active?
  end

  test "paid? returns true for active non-free plan" do
    subscription = Account::Subscription.new(plan_key: "monthly_v1", status: "active")
    assert subscription.paid?
  end

  test "paid? returns false for free plan" do
    subscription = Account::Subscription.new(plan_key: "free_v1", status: "active")
    assert_not subscription.paid?
  end
end

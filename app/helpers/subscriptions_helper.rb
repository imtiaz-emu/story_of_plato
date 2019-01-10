module SubscriptionsHelper

  def subscription_duration(subscription)
    if subscription.duration_type.present?
      return subscription.duration_type == 'Annually' ? subscription.duration / 12 : subscription.duration
    else
      return 1
    end
  end

  def disable_select_plan(subscription, plan_id)
    if subscription.new_record?
      return false
    else
      return subscription.plan_id != plan_id
    end
  end

  def check_subscription(subscription, plan_id)
    return subscription.plan_id.present? ? subscription.plan_id == plan_id : true
  end

  def check_subscriber(subscription)
    return subscription.new_record? ? false : true
  end

end

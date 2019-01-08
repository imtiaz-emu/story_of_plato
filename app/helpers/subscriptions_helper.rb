module SubscriptionsHelper

  def subscription_duration(subscription)
    if subscription.duration_type.present?
      return subscription.duration_type == 'Annually' ? subscription.duration / 12 : subscription.duration
    else
      return 1
    end
  end

end

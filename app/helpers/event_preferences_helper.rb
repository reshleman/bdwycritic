module EventPreferencesHelper
  def positive_preference_link(event)
    link_to "I want to see this",
    event_preferences_path(event, wants_to_see: true),
    method: :post
  end

  def negative_preference_link(event)
    link_to "I want to see this",
    event_preferences_path(event, wants_to_see: false),
    method: :post
  end
end

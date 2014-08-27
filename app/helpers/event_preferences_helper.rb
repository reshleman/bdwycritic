module EventPreferencesHelper
  def positive_preference_link(event)
    link_to "I want to see this",
      event_preferences_path(event, wants_to_see: true),
      id: "positive-preference-link",
      method: :post,
      remote: true
  end

  def negative_preference_link(event)
    link_to "Not interested",
      event_preferences_path(event, wants_to_see: false),
      id: "negative-preference-link",
      method: :post,
      remote: true
  end

  def positive_preference_text
    content_tag :span,
      "You want to see this",
      id: "positive-preference-text"
  end

  def negative_preference_text
    content_tag :span,
      "You're not interested",
      id: "negative-preference-text"
  end
end

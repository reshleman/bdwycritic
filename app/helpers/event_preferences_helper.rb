module EventPreferencesHelper
  def positive_preference_link(event)
    link_to "[I want to see this]",
      event_preferences_path(event, wants_to_see: true),
      method: :post,
      remote: true
  end

  def negative_preference_link(event)
    link_to "[I'm not interested]",
      event_preferences_path(event, wants_to_see: false),
      method: :post,
      remote: true
  end

  def positive_preference_text
    content_tag :span,
      "You want to see this."
  end

  def negative_preference_text
    content_tag :span,
      "You're not interested."
  end
end

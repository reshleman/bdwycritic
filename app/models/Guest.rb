class Guest
  def admin?
    false
  end

  def can_review?(_event)
    false
  end
end

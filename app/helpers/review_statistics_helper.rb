module ReviewStatisticsHelper
  def format_media_review(score)
    # Convert score proportionally from (-1..1) to (0..100)
    (((score || -1) + 1) * 50).round(1)
  end

  def format_user_review(score)
    (score || 0).round(1)
  end
end

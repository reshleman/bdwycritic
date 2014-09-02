module ReviewStatisticsHelper
  def format_media_review(score)
    # Convert score proportionally from (-1..1) to (0..100)
    format_review(((score || -1) + 1) * 50)
  end

  def format_user_review(score)
    format_review(score || 0)
  end

  private

  def format_review(score)
    score.round(1)
  end
end

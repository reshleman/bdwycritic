class ReviewScore
  def to_s
    if score == 0
      "--"
    else
      format_score.to_s
    end
  end

  private

  attr_reader :score

  def format_score
    if score.integer?
      score.round(0)
    else
      score.round(1)
    end
  end
end

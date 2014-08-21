class SentimentAnalyzer
  def initialize(text)
    @text = text
  end

  def positive
    0.1
  end

  def negative
    0.9
  end

  def neutral
    0.675
  end
end

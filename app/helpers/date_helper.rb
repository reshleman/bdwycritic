module DateHelper
  def closing_date_in_words(date)
    if still_open?(date)
      "closing #{distance_of_date_in_words(date)}"
    else
      "closed #{distance_of_date_in_words(date)}"
    end
  end

  private

  def still_open?(date)
    date >= Date.today
  end

  def distance_of_date_in_words(from_date, to_date = Date.today)
    distance = distance_in_days(from_date, to_date)

    case
    when distance < -1
      distance_of_time_in_words(from_date, to_date) + " ago"
    when distance == -1
      "yesterday"
    when distance == 0
      "today"
    when distance == 1
      "tomorrow"
    when distance > 1
      "in " + distance_of_time_in_words(from_date, to_date)
    end
  end

  def distance_in_days(from_date, to_date)
    (from_date - to_date).to_i
  end
end

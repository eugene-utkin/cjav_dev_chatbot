module ChatMessagesHelper
  def long_date(date)
    date.strftime("%B %d, %Y")
  end
end

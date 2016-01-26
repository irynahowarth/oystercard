class Oystercard

  attr_reader :balance,
              :journey_list

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize
    @balance = 0
    @journey_list = []
  end

  def top_up amount
    message = "Balance will exceed maximum #{MAX_LIMIT}!"
    fail message if balance + amount > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    return false if @journey_list.empty?
    return false if journey_list.last.has_key?(:end_journey)
    !!@journey_list
  end

  def touch_in  station
    fail "Not enough money!" if balance < MIN_LIMIT
    @journey_list << {start_journey: station}
  end

  def touch_out station
    deduct MIN_LIMIT
    @journey_list.last[:end_journey] = station
  end

  private

  def deduct amount
    @balance -= amount
  end

end
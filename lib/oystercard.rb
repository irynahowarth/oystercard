class Oystercard

  attr_reader :balance, :entry_station

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize
    @balance = 0
  end

  def top_up amount
    message = "Balance will exceed maximum #{MAX_LIMIT}!"
    fail message if balance + amount > MAX_LIMIT
    @balance += amount
  end

  def in_jorney?
    !!entry_station
  end

  def touch_in  station
    fail "Not enough money!" if balance < MIN_LIMIT
    @entry_station = station
  end

  def touch_out
    deduct MIN_LIMIT
    @entry_station = nil
  end

  private

  def deduct amount
    @balance -= amount
  end

end
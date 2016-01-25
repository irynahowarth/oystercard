class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up amount
    fail "Balance will exceed maximum #{MAX_LIMIT}!" if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

  def deduct amount
    @balance -= amount
  end

  def in_jorney?
    @journey
  end

  def touch_in
    @journey = true
  end

  def touch_out
    @journey = false
  end

end
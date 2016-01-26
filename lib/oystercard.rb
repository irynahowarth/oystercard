class Oystercard

  attr_reader :balance

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up amount
    message = "Balance will exceed maximum #{MAX_LIMIT}!"
    fail message if balance + amount > MAX_LIMIT
    @balance += amount
  end

  def in_jorney?
    @journey
  end

  def touch_in
    fail "Not enough money!" if balance < MIN_LIMIT
    @journey = true
  end

  def touch_out
    deduct MIN_LIMIT
    @journey = false
  end

  private

  def deduct amount
    @balance -= amount
  end

end
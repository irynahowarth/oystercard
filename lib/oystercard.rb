require_relative 'journey'
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

  def touch_in station
    fail "Not enough money!" if balance < MIN_LIMIT
    if !@journey_list.empty?
      unless @journey_list.last.complete?
        @journey_list.last[:end_st]= "penalty"
        deduct Journey::PENALTY_FARE
      end
    end
    journey = Journey.new
    journey[:start_st] = station
    @journey_list << journey
  end

  def touch_out station
    if @journey_list.empty? || @journey_list.last.complete?
      deduct Journey::PENALTY_FARE
      journey = Journey.new
      journey[:end_st]= station
      journey[:start_st]= "penalty"
      @journey_list << journey
    else
      @journey_list.last[:end_st] = station
      deduct @journey_list.last.fare
    end
  end

  private

  def deduct amount
    @balance -= amount
  end

end

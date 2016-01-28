require_relative 'journey'

class JourneyLog

  attr_accessor :journey_klass, :one_journey, :journeys, :current_journey

  def initialize journey_klass = Journey
    @journey_klass = journey_klass
    @journeys = []
  end

  def start_journey station
    @one_journey = @journey_klass.new station
  end

  def exit_journey
  end

  def current_journey
    return @one_journey unless @one_journey.complete?
    @one_journey = @journey_klass.new
  end
end
require_relative 'oystercard.rb'

class Journey < Struct.new :start_st, :end_st

  PENALTY_FARE = 6

  def complete?
    !!self.start_st && !!self.end_st
  end

  def fare
   self.complete? ? Oystercard::MIN_LIMIT :  PENALTY_FARE
  end

end

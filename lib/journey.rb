class Journey < Struct.new :start_st, :end_st
  def complete?
    !!self.start_st && !!self.end_st
  end
  def fare
  end
end

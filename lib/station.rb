class Station < Struct.new :name, :zone

end

# station_list = [{'london',1},{'paddington',2},{'kingth cross',3}]

# station = station_list.find{|item| item[:name]=='london' }
# station[:zone]
class Station < Struct.new :name, :zone
end

# [
#   {'Aldgate', 1},
#   {'Bank', 1},
#   {'St.Paul', 1},
#   {'Holborn', 1},
#   {'Wimbledon',2},
#   {'West Brompton',2},
#   {'Bow Church',2},
#   {'Royal Victoria',3},
#   {'Cyprus',3},
#   {'Barking', 4},
#   {'Newbury Park', 4},
#   {'Oakwood', 5},
#   {'Heathrow Terminal 5', 5}
# ]

# station_list = [{'london',1},{'paddington',2},{'kingth cross',3}]
# station = station_list.find{|item| item[:name]=='london' }
# station[:zone]

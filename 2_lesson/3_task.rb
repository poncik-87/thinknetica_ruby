arr = [0, 1]

loop do
  value = arr[-1] + arr[-2]
  break if value >= 100
  arr << value
end

puts arr

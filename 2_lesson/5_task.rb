print "Введите число: "
day = gets.chomp.to_i

print "Введите месяц: "
month = gets.chomp.to_i

print "Введите год: "
year = gets.chomp.to_i

is_leap_year = (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0))

months = [
  31,
  is_leap_year ? 29 : 28,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31,
]

days = day

count = 1
while count < month do
  days += months[count - 1]
  count += 1
end

puts "Вы ввели #{days} день года"

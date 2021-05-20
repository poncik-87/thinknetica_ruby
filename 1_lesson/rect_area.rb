print "Введите значение основания треугольника: "
base = gets.chomp.to_i

print "Введите значение высоты треугольника: "
height = gets.chomp.to_i

area = 0.5 * base * height

puts "Площадь треугольника равна #{area}"

print "Введите первую сторону треугольника: "
a = gets.chomp.to_i

print "Введите вторую сторону треугольника: "
b = gets.chomp.to_i

print "Введите третью сторону треугольника: "
c = gets.chomp.to_i

if (a == b && a == c)
  puts "Треугольник является равносторонним"
elsif (a == b || a == c || b == c)
  puts "Треугольник является равнобедренным"
else
  sides = [a, b, c]
  max_side = sides.max
  rest_sides = sides.select {|item| item != max_side}

  if (rest_sides[0] ** 2 + rest_sides[1] ** 2 == max_side ** 2)
    puts "Треугольник является прямоугольным"
  else
    puts "Это обычный треугольник"
  end
end

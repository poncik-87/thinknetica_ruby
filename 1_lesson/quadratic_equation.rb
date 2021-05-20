print "Введите коэффициент a квадратного уравнения: "
a = gets.chomp.to_i

print "Введите коэффициент b квадратного уравнения: "
b = gets.chomp.to_i

print "Введите коэффициент c квадратного уравнения: "
c = gets.chomp.to_i

d = b ** 2 - 4 * a * c

if (d > 0)
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)

  puts "Дискриминант: #{d}, корень 1: #{x1}, корень 2: #{x2}"
elsif (d == 0)
  x = -b / (2 * a)

  puts "Дискриминант: #{d}, корень: #{x}"
else
  puts "Корней нет"
end

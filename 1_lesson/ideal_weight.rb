print "Введите ваше имя: "
name = gets.chomp

print "Введите ваш рост: "
height = gets.chomp.to_i

ideal_weight = (height - 110) * 1.15

if (ideal_weight < 0)
  puts "Ваш вес уже оптимальный"
else
  puts "#{name}, оптимальный вес для вашего роста - #{ideal_weight} кг."
end

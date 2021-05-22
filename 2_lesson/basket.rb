input = ""
basket = Hash.new

while input.downcase != "стоп" do
  print "Введите название товара: "
  input = gets.chomp
  break if input.downcase == "стоп"
  name = input

  print "Введите цену за единицу: "
  input = gets.chomp
  break if input.downcase == "стоп"
  price = input.to_i

  print "Введите количество: "
  input = gets.chomp
  break if input.downcase == "стоп"
  amount = input.to_i

  basket[name] = {
    amount: amount,
    price: price,
  }
end

if basket.empty?
  puts "Корзина пуста"
else
  sum = 0
  products_report = "Итоговая сумма по товарам: "
  basket.each do |name, product|
    product_sum = product[:amount] * product[:price]
    products_report += "#{name} - #{product_sum}; "
    sum += product_sum
  end

  puts "Список товаров:"
  puts basket
  puts products_report
  puts "Общая сумма корзины: #{sum}"
end

total = 0
products = {}
loop do
  puts 'Название товара'
  name = gets.chomp
  break if name == 'stop'

  puts 'Цена за единицу товара'
  price = gets.chomp.to_i

  puts 'Количество купленного товара'
  size = gets.chomp.to_i

  products[name] = { price: price, size: size }
end
products.each do |_, product|
  total += (product[:price] * product[:size])
end
p total

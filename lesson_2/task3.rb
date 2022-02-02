
sevens = []
numbers = (1..100).to_a
numbers.each do |number|
  sevens << number if number.to_s.include?("7")
end
puts sevens


users_and_numbers = {
  'mike' => 21,
  'john' => 56,
  'nick' => 11,
  'david' => 4,
  'mikhail' => 1,
  'max' => 8
}
user_founded = false
users_and_numbers.each do |user, _number|
  user_founded = true if user == 'max'
end
puts user_founded

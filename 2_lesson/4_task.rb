letters = ('а'..'е').to_a + ['ё'] + ('ж'..'я').to_a
lowels_arr = ['а', 'е', 'ё', 'и', 'о', 'е', 'у', 'ы', 'э', 'ю', 'я']
vowels_hash = Hash.new

lowels_arr.each do |lowel|
  vowels_hash[lowel] = letters.index(lowel) + 1
end

puts vowels_hash

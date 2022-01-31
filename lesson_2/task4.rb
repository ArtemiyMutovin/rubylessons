vowel = ["а","е","ё","и","о","у","ы","э","ю","я"]
vowel_hash = {}

("а".."я").each_with_index {|letter, index| vowel_hash[letter] = index if vowel.include?(letter) }

print vowel_hash

stop_words = %w{the a by on for of are with just but and to the my I as some in}
lines = File.readlines(ARGV[0])
line_count = lines.size
text = lines.join

# Count the characters
total_characters = text.length
total_characters_nospaces = text.gsub(/\s+/, "").length

# Count the words, sentences, and paragraphs
word_count = text.split.length
paragraph_count = text.split(/\n\n/).length
sentence_count = text.split(/\.|\?\!/).length

# Make a list of words in the text that aren't stop words,
# count them, and work out the percentage of substantive words
# out of all words
all_words = text.scan(/\w+/)
key_words = all_words.reject { |word| stop_words.include?(word) }
key_percentage = (key_words.length.to_f / all_words.length.to_f * 100).to_i

# Summarize the text by cherry picking some choice sentences
sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length }
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted[one_third, one_third + 1]
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }

# Give the analysis back to the user
puts "#{line_count} lines"
puts "#{total_characters} characters"
puts "#{total_characters_nospaces} characters excluding spaces"
puts "#{word_count} words"
puts "#{paragraph_count} paragraphs"
puts "#{sentence_count} sentences"
puts "#{sentence_count / paragraph_count} sentences per paragraph"
puts "#{word_count / sentence_count} words per sentence"
puts "Percentage of words that are non-fluff words: #{key_percentage}"
puts "Summary:\n\n #{ideal_sentences.join(". ")}."
puts "\n -- End of analysis"
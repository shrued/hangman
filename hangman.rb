class Hangman

  def initialize
    @word = words.sample
    @lives = 7
    @word_teaser = ""

    @word.first.size.times do
      @word_teaser += "_ "
    end
  end

  def words
    [
      ["zeus", "God of the Sky"],
      ["hera", "Goddess of Marriage, Mothers and Families"],
      ["poseiden", "God of the Sea"],
      ["demeter", "Goddess of Agriculture"],
      ["ares", "God of War"],
      ["athena", "Goddess of Wisdom, War, and Useful Arts"],
      ["apollo", "God of Archery, Music, Poetry, Prophecy, Medicine, and later on, the God of the Sun"],
      ["artemis", "Goddess of the Moon, the Hunt, and Young Maidens"],
      ["haphaestus", "God of Blacksmiths and Fire"],
      ["aphrodite", "Goddess of Love and Beauty"],
      ["hades", "God of the Underworld"],
      ["dionysus", "God of Wine"],
      ["hypnos", "God of Sleep"],
      ["nemesis", "Goddess of Revenge"],
      ["hecate", "Goddess of Magic, Crossroads and Ghosts"],
    ]
  end

  def print_teaser last_guess = nil
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser last_guess
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      # replace blank values with guessed letter if matches letter in word
      if letter == '_' && @word.first[index] == last_guess
        new_teaser[index] = last_guess
      end
    end

    @word_teaser = new_teaser.join(' ')
  end

  def make_guess
    if @lives > 0
      puts "Enter a letter"
      guess = gets.chomp

      good_guess = @word.first.include? guess

      if guess == "exit"
        puts "Thank you for playing!"
        
      #if guess is longer than 1 letter
      elsif guess.length > 1
        puts "Only guess 1 letter at a time please."
          make_guess
        
      elsif good_guess
        puts "You are correct!"

        print_teaser guess

        if @word.first == @word_teaser.split.join
          puts "You got it!"
        else
          make_guess
        end
      else
        @lives -= 1
        puts "You have #{ @lives } lives left. Try again!"
        make_guess
      end
    else
      puts "Game over."
    end
  end

  def begin
    # ask user for a letter
    puts "Your new word is #{ @word.first.size } characters long"
    puts "To exit game at any point type 'exit'"
    print_teaser

    puts "Clue: #{ @word.last }"

    make_guess
  end

end

game = Hangman.new
game.begin
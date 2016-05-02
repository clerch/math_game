
##require "pry"
class Player
  attr_accessor :lives, :score
  attr_reader :name
  # the state of the game is initialized
  def initialize
    # each player has three lives
    @lives = 3
    @score = 0
    @name = promptName
  end

  def promptName
    puts "what is your name? "
    gets.chomp
  end
end

class Game 
  # players are asked alternately random math questions
  def initialize
    puts "How many players?"
    @num_players = gets.chomp.to_i
    @players = []
    @num_players.times do |n|
      @players << Player.new
    end

    # the current player is a piece of game state
    @current_player = 0
  end

  def play_game
    loop do
      player = @players[@current_player]
      # a question is generated and asked
      question = generate_question
      puts "#{player.name}'s turn:"
      puts question[:text]
      # an answer is requested and determined to be correct or incorrect
      answer = prompt_for_answer #(question, player)
      correct = question[:answer] == answer
      # the player gains a point or loses a life
      if correct
        puts "Correct!"
        award_point(player)
      else
        puts "No you iiidiot"
        deduct_life(player)
      end
      # it is determined whether the game is over
      break if dead?(player)
      swap_player
    end
    display_final_score(@players)
  end

  def generate_question
    operator = [:+, :-, :*, :/].sample
    num_1 = rand(1..20)
    num_2 = rand(1..20)
    question_text = "What is #{num_1} #{operator} #{num_2}?"
    question_answer = num_1.send(operator, num_2)
    {
      text: question_text,
      answer: question_answer
    }
  end

  def dead?(player)
    player.lives == 0
  end

  def award_point(player)
    player.score += 1
  end

  def deduct_life(player)
    player.lives -= 1
  end

  def swap_player
    @current_player == (@num_players-1) ? @current_player = 0 : @current_player +=1
  end

  def prompt_for_answer
    gets.chomp.to_i
  end

  def display_final_score(player)
    
    @num_players.times do |n|
      player_name = player[n].name
      player_score = player[n].score
      player_lives = player[n].lives
      puts "Player #{player_name} has #{player_score} points with #{player_lives} lives remaining."    end
    end
  end



    #   player_one_score = @players[0].score
    #   player_one_lives = @players[0].lives
    #   player_two_score = @players[1].score
    #   player_two_lives = @players[1].lives
    #   puts "Player one has #{player_one_score} points with #{player_one_lives} lives remaining."
    #   puts "Player two has #{player_two_score} points with #{player_two_lives} lives remaining."
    
  ## binding.pry




my_game = Game.new
my_game.play_game






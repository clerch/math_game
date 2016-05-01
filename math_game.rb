
##require "pry"

# the state of the game is initialized
def initialize_game_state
  initialize_players
  # the current player is a piece of game state
  @current_player = 0
end

# players are asked alternately random math questions
def play_game
  loop do
    player = @players[@current_player]
    # a question is generated and asked
    question = generate_question
    puts "Player #{@current_player+1}'s turn:"
    puts question[:text]
    # an answer is requested and determined to be correct or incorrect
    answer = prompt_for_answer #(question, player)
    correct = question[:answer] == answer.to_i
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
  display_final_score
end

def initialize_players
  # there are two players
  # each player has three lives
  @players = [{
    lives: 3,
    score: 0
  }, {
    lives: 3,
    score: 0
  }]
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
  player[:lives] == 0
end

def award_point(player)
  player[:score] += 1
end

def deduct_life(player)
  player[:lives] -= 1
end

def swap_player
  @current_player == 1 ? @current_player = 0 : @current_player = 1
end

def prompt_for_answer
  gets.chomp
end

def play_the_game
  initialize_game_state
  play_game
end

def display_final_score
player_one_score = @players[0][:score]
player_one_lives = @players[0][:lives]
player_two_score = @players[1][:score]
player_two_lives = @players[1][:lives]
puts "Player one has #{player_one_score} points with #{player_one_lives} lives remaining."
puts "Player two has #{player_two_score} points with #{player_two_lives} lives remaining."
end
## binding.pry


play_the_game






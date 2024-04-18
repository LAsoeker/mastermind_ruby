class Player
  attr_reader :name

  def initialize (game_mode)
    @game_mode = game_mode
    @name = greeting(@game_mode)
    @valid_colors = ["red", "green", "blue", "magenta", "cyan", "white"]
    @valid_feedback =["black", "white"]
    @peg_spots = ["first","second","third","last"]
  end


  def get_move(peg_number)
    user_input_peg_color = nil
    until @valid_colors.include?(user_input_peg_color)
      print "\n\t#{@name} please pick #{@peg_spots[peg_number]} peg: " 
      user_input_peg_color = gets.chomp.downcase
      unless @valid_colors.include?(user_input_peg_color)
        puts "\n\tPlease pick a valid color!"
      end
    end
    user_input_peg_color
  end

  def give_feedback(peg_number)
    player_feedback_input_color = nil
    puts "\n\t#{@name} please give feedback. You don't have to randomize your feedback. The Feedback will be randomized for you."
    until @valid_feedback.include?(player_feedback_input_color)
      print "\n\t#{@name} Feedback for #{@peg_spots[peg_number]} peg: " 
      player_feedback_input_color = gets.chomp.downcase
      unless @valid_feedback.include?(player_feedback_input_color)
        puts "\n\tPlease pick a valid Feedback color!"
      end
    end
    player_feedback_input_color
  end

  def greeting(game_mode)
    case game_mode
    when "Player(Codebreaker) vs. KI"
      print "\n\tWelcome to Codebreaker-Mode! Try to break the AI's code. What's your name? "
      name = gets.chomp
    when "Player(Codesetter) vs. KI"
      print "\n\tWelcome to Codesetter-Mode! Set a unbreakable code and let the AI try and break it. What's your name? "
      name = gets.chomp
    else
      puts "Unbekannter Modus!"
    end
    name
  end
  
  private
  

  def greeting_codesetter
    print "\n\t\tWelcome to Mastermind! What's your name: "
    @name = gets.chomp
    puts "\n\t\t#{@name} you are the code setter. Please pick 4 valid colors: "
  end
end

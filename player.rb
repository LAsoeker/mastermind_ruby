class Player
  attr_reader :name

  def initialize (game_mode)
    @game_mode = game_mode
    @name = greeting(@game_mode)
    @valid_colors = ["red", "green", "blue", "magenta", "cyan", "white"]
  end


  def get_move(peg_number)
    peg_spots = ["first","second","third","last"]
    user_input_peg_color = nil
    until @valid_colors.include?(user_input_peg_color)
      print "\n\t#{@name} please pick #{peg_spots[peg_number]} peg: " 
      user_input_peg_color = gets.chomp.downcase
      unless @valid_colors.include?(user_input_peg_color)
        puts "\n\tPlease pick a valid color!"
      end
    end
    user_input_peg_color
  end

  def give_feedback
    feedback = []
    puts "\n\t#{@name} please give feedback"
    
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

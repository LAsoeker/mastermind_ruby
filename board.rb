class Board


  def initialize(rows, game_mode)
    @state = Array.new(rows) {Array.new(8, "empty")}
    @round = 0
    @peg_colors = {
      "empty" => "\u25ef",
      "red" => "\e[91m\u2b24E\e[0m",
      "green" => "\e[92m\u2b24E\e[0m",
      "blue" => "\e[94m\u2b24E\e[0m",
      "magenta" => "\e[95m\u2b24E\e[0m",
      "cyan" => "\e[96m\u2b24E\e[0m",
      "white" => "\e[97m\u2b24E\e[0m"
    }

    @code_to_break = Array.new(4) { "empty" }
    
    @feedback_colors = {
      "empty" => "\u25ef",
      "black" => "\e[30m\u25cf\e[0m",
      "white" => "\e[97m\u25cf\e[0m"
    }
  end

  def display(player_name, current_round)
    display_rules(player_name)
    puts "\n\n\t\t\tWe are in the #{current_round+1}. round"
    puts "\n\tPlease pick a Color #{@peg_colors["red"]} #{@peg_colors["green"]} #{@peg_colors["blue"]} #{@peg_colors["magenta"]} #{@peg_colors["cyan"]} #{@peg_colors["white"]}"
    
    puts "\n\t\u2554" + ("\u2550" * 4 + "\u2566") * (@state[0..3].length) + "\u2550" * 9 + "\u2557"
    @state.each_with_index do |row, index|
      new_row = row[0..3].map do |item|
        if item == "empty"
          item = " #{@peg_colors[item]}  "
        else 
          item = " #{@peg_colors[item]} "
        end
      end

      new_feedback_values = row[4..7].map {|item| "#{@feedback_colors[item]}"}.join(" ")

      puts "\t\u2551#{new_row.join("\u2551")}\u2551 #{new_feedback_values} \u2551"
      if index == @state.length - 1  
        puts "\t\u255A" + ("\u2550" * 4 + "\u2569") * @state[0..3].length + "\u2550" * 9 + "\u255D"
      else
        puts "\t\u2560" + ("\u2550" * 4 + "\u256C") * @state[0..3].length + "\u2550" * 9 + "\u2563"
      end
    end
  end

  def display_codesetter_view(player_name)
    display_rules(player_name)
    puts "\n\tThis view is only for the eyes of the codesetter #{player_name}"
    puts "\n\t\u2554" + ("\u2550" * 4 + "\u2566") * (@code_to_break.length-1) + "\u2550" * 4 + "\u2557" 
    new_row = @code_to_break.map do |item|
      if item == "empty"
        item = " #{@peg_colors[item]}  "
      else 
        item = " #{@peg_colors[item]} "
      end
    end
    puts "\t\u2551#{new_row.join("\u2551")}\u2551"
    puts "\t\u255A" + ("\u2550" * 4 + "\u2569") * (@code_to_break.length-1) + "\u2550" * 4 + "\u255D"
  end

  def display_feedback_view(player_name, row)
    display_rules(player_name)
    
    # puts "\n\t\u2554" + ("\u2550" * 4 + "\u2566") * (@state[0..3].length) + "\u2550" * 9 + "\u2557"
    # @state[row].each_with_index do |element, index|
    #   new_row = @state[row][0..3].map do |item| 
    #     if item == "empty"
    #       item = " #{@peg_colors[item]}  "
    #     else 
    #       item = " #{@peg_colors[item]} "
    #     end
    #   end
    #   #HERE display funktioniert noch nicht richtig
    #   new_feedback_values = @state[row][4..7].map {|item| "#{@feedback_colors[item]}"}.join(" ")

    #   puts "\t\u2551#{new_row.join("\u2551")}\u2551 #{new_feedback_values} \u2551"
    #   if index == @state.length - 1  
    #     puts "\t\u255A" + ("\u2550" * 4 + "\u2569") * @state[0..3].length + "\u2550" * 9 + "\u255D"
    #   else
    #     puts "\t\u2560" + ("\u2550" * 4 + "\u256C") * @state[0..3].length + "\u2550" * 9 + "\u2563"
    #   end
    # end
  end

  def set_move(row, col, color)
    if valid_color?(color)
      if valid_guess_position?(row, col)
        @state [row][col] = color
      else
        return
      end
    else
      puts "pls enter valid color"
    end
  end

  def set_code(index, color)
    if valid_color?(color)
      @code_to_break[index] = color
    else
      puts "pls enter valid color"
    end
  end
  
  def generate_feedback(row)
    feedback = []
    code_to_break = @code_to_break.clone
    guess_state = @state[row][0..3].clone

    # Check for correct colors in correct positions (black pegs)
    code_to_break.each_with_index do |code_color, index|
      if code_color == guess_state[index]
        feedback.push('black')
        guess_state[index] = nil
        code_to_break[index] = nil
      end
    end

    # Check for correct colors in wrong positions (white pegs)
    guess_state.compact.each_with_index do |peg_color, index|
      if code_to_break.include? peg_color
        feedback.push('white')
        code_to_break.delete_at(index)
      else 
        feedback.push('empty')
      end
    end

    update_feedback_state(feedback, row)
  end

  def winner?(row)
    if @state[row][0..3].eql? @code_to_break
      puts "\n\n\tWOW! You got the code right!\n\n"
      true
    elsif row > 9
      puts "\n\n\tGAME OVER! You reached the guess limit.\n\n"
      true
    else
      false
    end
  end

  def get_player_feedback(player_feedback, row)
    update_feedback_state(player_feedback, row)
  end

  private

  def display_rules(player_name)
    red = "\e[101m red \e[0m"
    green = "\e[102m green \e[0m"
    blue = "\e[104m blue \e[0m"
    magenta = "\e[105m magenta \e[0m"
    cyan = "\e[106m cyan \e[0m"
    white = "\e[107m white \e[0m"

    puts File.read('./mastermind.txt')
    puts "\tWelcome to Mastermind #{player_name}!\n"
    puts "\tIn this game, one player will set a secret code and the other player will try to guess it.\n"
    puts "\tThe code is a sequence of 4 pegs. Each peg can be one of six colors:"
    puts "\t1. #{@peg_colors["red"]} - Red"
    puts "\t2. #{@peg_colors["green"]} - Green"
    puts "\t3. #{@peg_colors["blue"]} - Blue"
    puts "\t4. #{@peg_colors["magenta"]} - Magenta"
    puts "\t5. #{@peg_colors["cyan"]} - Cyan"
    puts "\t6. #{@peg_colors["white"]} - White\n"
    puts "\tOn each turn, the guesser will enter their guess of the secret code."
    puts "\tThe setter will then give feedback on the guess using up to four feedback pegs:"
    puts "\t#{@feedback_colors["black"]} - Black: A black feedback peg means that one of the guessed pegs is the correct color and in the correct position."
    puts "\t#{@feedback_colors["white"]} - White: A white feedback peg means that one of the guessed pegs is the correct color but in the wrong position."
    puts "\t#{@feedback_colors["empty"]} - Empty: An empty feedback peg means that one of the guessed pegs is not in the secret code at all."
    puts "\tThe feedback pegs do not correspond to specific guessed pegs; they only give information about the entire guess."
    puts "\tThe guesser wins if they guess the secret code correctly. If they do not guess the code in 10 turns, the setter wins."
    puts "\tLet's start the game!"
  end

  def generate_code_to_break(game_mode)
    if game_mode == "Player(Codesetter) vs. KI"
      
    elsif game_mode == "Player(Codebreaker) vs. KI"
      Array.new(4){ @peg_colors.keys.reject{|color| color == "empty" }.sample }
    end
  end

  def update_feedback_state(feedback, row)
    # Shuffle and update the state with the feedback
    feedback.shuffle!.each_with_index do |feedback_color, index|
      @state[row][index+4] = feedback_color
    end
  end

  def valid_color?(color)
    @peg_colors.has_key?(color)    
  end

  def valid_guess_position? (row, col)
    row.between?(0, @state.length - 1) && col.between?(0, @state[0].length - 4)
  end
end

class KIenemy

  def initialize (code_length = 4)
    @valid_colors = ["red", "green", "blue", "magenta", "cyan", "white"]
    @code_length = code_length
    @guess = generate_initial_guess(@valid_colors)
    @possible_codes = @valid_colors.repeated_permutation(@code_length).to_a
  end

  def get_move(i)
    @guess[i]
  end

  def five_guess_algorithm
    #1. Create an Initial Set of Possible Codes
    puts "Number of possible codes: #{possible_codes.length}"
    #2. make initial guess
    #3. get player feedback
  end

  private

  def generate_initial_guess(valid_colors)
    generated_guess = []
    generated_guess[0] = valid_colors.sample
    generated_guess[1] = generated_guess[0]
    generated_guess[2] = valid_colors.reject{|el| el == generated_guess[0]}.sample
    generated_guess[3] = generated_guess[2]
    generated_guess
  end
end
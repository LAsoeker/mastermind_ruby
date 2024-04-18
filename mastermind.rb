require './board.rb'
require './player.rb'
require './ki_enemy.rb'

class Mastermind
  attr_reader :game_mode
  def initialize
    clear_screen
    puts File.read('./mastermind.txt')

    @game_modi = {
      pvp: "Player vs. Player",
      codebreaker: "Player(Codebreaker) vs. KI",
      codesetter: "Player(Codesetter) vs. KI"
    }

    @game_mode = @game_modi[get_game_mode()]

    if @game_mode == @game_modi[:codebreaker]
      @player = Player.new(@game_mode)
      @board = Board.new(10, @game_mode)
    elsif @game_mode == @game_modi[:codesetter]
      @player = Player.new(@game_mode)
      @board = Board.new(10, @game_mode)
      @ki_enemy = KIenemy.new()
    else
      #code for PvP
    end
    @game_over = false
    @current_round = 0
  end

  def play_game
    until @game_over
      if @game_mode == @game_modi[:codebreaker]
        play_round_codebreaker()
      elsif @game_mode == @game_modi[:codesetter]
        player_set_code
        @game_over = true
        # play_round_codesetter()
      else
        puts "SORRY THIS MODE IS NOT FINISHED"
        #code for PvP
      end
    end
  end

  private

  def player_set_code 
    satisfied_with_code = false
    puts "SORRY THIS MODE IS NOT FINISHED"
    # until satisfied_with_code
    #   4.times do |i|
    #     clear_screen
    #     @board.display_codesetter_view(@player.name)
    #     @board.set_code(i, @player.get_move(i))
    #   end
    #   clear_screen
    #   @board.display_codesetter_view(@player.name)

    #   print "\n\tAre you satisfied with this code? (yes/no) "
    #   satisfied_with_code = gets.chomp.downcase == 'yes'
    #   if !satisfied_with_code
    #     4.times do |i|
    #       @board.set_code(i, "empty")
    #     end
    #   end
    # end
  end

  def play_round_codesetter
    4.times do |i|
      @board.set_move(@current_round, i, @ki_enemy.get_move(i))
    end
    @game_over = @board.winner?(@current_round)
    4.times do |i|
      clear_screen
      @board.display(@player.name, @current_round)
      @board.display_feedback_view(@player.name, @current_round)
      @board.get_player_feedback(@player.give_feedback(i), @current_round)
    end
  end

  def play_round_codebreaker
    4.times do |i|
      clear_screen
      @board.display(@player.name, @current_round)
      @board.set_move(@current_round, i, @player.get_move(i))
    end
    @game_over = @board.winner?(@current_round)
    @board.generate_feedback(@current_round)
    @current_round += 1
  end
  

  def get_game_mode
    game_mode = [:pvp, :codebreaker, :codesetter]
    game_mode_input = 0

    puts "\n\n\t\tWelcome to Mastermind! Please chose one of the following game modi"
    puts "\n\t\t\t1. #{@game_modi[:pvp]}"
    puts "\t\t\t2. #{@game_modi[:codebreaker]}"
    puts "\t\t\t3. #{@game_modi[:codesetter]}"
    print "\n\t\tGame mode 1,2 or 3: "

    until game_mode_input.between?(1,3)
      game_mode_input = gets.chomp.to_i
      unless game_mode_input.between?(1,3)
        print "\n\t\t\tPlease pick a valid game mode(1,2 or 3): "
      end
    end
    game_mode[game_mode_input-1]
  end

  def clear_screen
    system('clear') || system('cls')
  end
end

mastermind = Mastermind.new()
mastermind.play_game()

# mastermind_ruby
Assignment  Build a Mastermind game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer’s random code.

Player as Codesetter: Gameplay Steps

    Player Sets the Secret Code:
        Prompt the player to set a secret code. Ensure it adheres to game rules (e.g., correct number of pegs, valid colors). (done)
        Store this secret code securely such that the AI cannot directly access it. (done)

    Initialize AI's First Guess:
        Depending on the implementation of Knuth's Algorithm, the first guess can be a fixed guess or randomly generated from the possible set of codes.

    Game Loop:
        The AI makes a guess.
        Provide feedback to the AI (using the method we outlined or similar).
        Based on the feedback, the AI refines its next guess.

    Check for End Conditions:
        If the AI's guess matches the player's secret code (i.e., it gets all black pegs), the AI wins. Display a win message for the AI.
        If the AI exceeds the maximum number of allowed guesses without cracking the code, the player wins. Display a win message for the player.

    Option to Play Again:
        Once a game ends, ask the player if they want to play again or choose a different mode or exit.

    UI Enhancements (as you progress):
        Display the AI's guesses in a visually appealing manner.
        Show the feedback (black and white pegs) next to each guess.
        Consider adding suspense elements, like a slight delay before the AI makes a guess, to enhance the gaming experience.

    Error Handling:
        Ensure that the secret code input by the player is valid.
        Handle any unexpected scenarios or inputs gracefully.
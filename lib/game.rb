require "./board.rb"
require "./player.rb"

module Morpion
  class Game
    attr_accessor :player1, :player2, :turn, :board

    @@winning_positions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]

    def initialize(player1, player2, board)
      ##initialize les objets dont j'ai besoin pour cette classe.
      @player1 = player1
      @player2 = player2
      @board = board

      ##initialize les tours pour la partie
      @current_turn = 1
      @winner = nil 

      #execute la partie
      play
    end

    def play #le jeu commence
      play_turn
      take_turns

    end

    private

    def play_turn #j'itère sans savoir qui commencera
      @current_turn_player == @player1 ? @player2 : @player1
      @turn_count +=1
    end

    def take_turns #vérifie le tour des joueurs (qui commence, numero de tour)
      until draw? || @winner != ""
        next_turn
        turn(@current_turn_player)
      end
      puts "Match nul!" if draw? #verifie si match nul à la fin boucle
    end

                                    
    def turn(player) #un tour pour le joueur
      puts "Tour #{@current_turn}:"
      puts "---------------------------\n\n\n"
      @board.generate_board
      @board.add_symbol(get_valid_position(player), player.sym)
      announce_win(player)
      @current_turn += 1
    end

    def get_valid_position(player) #saisie mouvement valide du joueur
      input = 0
      until valid_input?(input)
        print "#{player.name}, Entrez le numéro de case, chiffre (1-9) uniquement: "
        input = gets.chomp.to_i
        print "Saisie invalide! Entrez un nouveau numéro " unless valid_input?(input)
        puts "Le numéro doit être entre 1-9 uniquement" unless (input > 0 && input < 10)
        puts "Numéro ok. Case validée." if @board.space_taken?(input - 1)
      end
      input - 1
    end

    def announce_win(player)
      check_winner(player)
      if @winner == player.name
        puts "Bravo, vous avez gagné #{player.name}!"
      end
    end

    def draw? #vérifie si c'est match nul, tableau rempli?
      (@current_turn == @board.spaces.length) && (@winner == "")
    end
            #création d'un variable d'instance pour le joueur gagnant, s'il a rempli les cases
    def check_winner(player) 
         @@winning_positions.each do |triplet|
        @winner = player.name if triplet.all? { |a| @board.spaces[a] == player.sym }
      end
    end

    def valid_input?(input) #verifie si la saisie respecte les conditions: range 1...9
      return input > 0 && input < 10 && !@board.space_taken?(input - 1)
    end

    def game_end?
      draw? || @winner != ""
    end
  end
end
game = main.new
game.play
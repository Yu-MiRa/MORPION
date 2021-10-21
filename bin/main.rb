require ".lib/game.rb"
require ".lib/player.rb"
require ".lib/board.rb"

module Morpion
  class Application
    attr_accessor :name1, :name2, :game_data

    def initialize
      welcome_screen
      perform
    end

    def welcome_screen #salue et demande le noms des joueurs
      puts "|| Bienvenue au jeu de Morpion! ||"
      puts "||-------------------------||\n\n\n"
      print "Entrez le nom du joueur 1: "
      @name1 = gets.chomp
      puts " "
      print "Entrez le nom du joueur 1: "
      @name2 = gets.chomp
      puts " "
    end
            #boucle les parties jusqu'à la fin et demande si
            #les joueurs veulent faire une nouvelle partie
    def perform 
      game_start
      play_again
    end
            #crée la partie et fait tourner le jeu
    def game_start 
      board = Board.new
      player1, player2 = Player.new(@name1), Player.new(@name2)
      game = Game.new(player1, player2, board)
    end

        #demande si le joueur veut faire une nouvelle partie
    def play_again
      loop do 
        puts "Voulez-vous rejouer ? (O/N): "
        input = gets.chomp.upcase
        if input == "O" 
          return true
        elsif input == "N"
          return false 
        end
        puts "Merci d'avoir joué. A la prochaine! "
      end
    end
    
    def game_loop
      while play_again
        game_start
      end
    end

  end
end

Application.new
Application.welcome_screen
Application.perform


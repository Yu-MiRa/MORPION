module Morpion
    class Board
      attr_accessor :spaces
            #création instance
      def initialize
        @spaces = Array.new(9, "-")
      end
            #création board
      def generate_board 
        board = ""
        (0..8).step(3) do |i|
          board += "| #{@spaces[i]} | #{@spaces[i + 1]} | #{@spaces[i + 2]} |\n"
        end
        puts board + "\n\n\n"
      end
            #rajoute une position dans la case
      def add_kase(position, kase) 
        @spaces[position] = kase
      end
            #verifie si la position est occupée
      def space_busy?(position) #checks if a certain space is taken
        return @spaces[position] == "X" || @spaces[position] == "O"
      end
    end
  end
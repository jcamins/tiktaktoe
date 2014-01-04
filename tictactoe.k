
module TICTACTOE-SYNTAX
    syntax Game ::= Board | Game Turn
    syntax Board ::= "board" Int Int
    syntax Turn ::= Player Coord
    syntax Coord ::= Int Int
    syntax Player ::= "w" | "b"
    syntax Val ::= "e" | Player
endmodule

module TICTACTOE
    imports TICTACTOE-SYNTAX
    configuration <T>
        <k color="green">$PGM:K</k>
        <turn>w</turn>
        <square multiplicity="*">
            <x>0</x>
            <y>0</y>
            <v>e</v>
        </square>
    </T>

    rule <k> board X Y => X Y ...</k>
         (. => <square> <x> X </x> <y> Y </y> <v> e </v> </square>)
endmodule

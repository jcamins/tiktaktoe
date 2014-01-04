
module TICTACTOE-SYNTAX
    syntax Game ::= Board | Game Turn
    syntax Board ::= "board" Int
    syntax Turn ::= Player Int Int
    syntax Player ::= "w" | "b"
    syntax Coord ::= Int Int
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

    rule <k> board W:Int ...</k> => <square> <x> W </x> <y> W </y> </square> <square> <x> W -Int 1 </x> <y> W -Int 1 </y> </square>
endmodule

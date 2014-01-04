
module TICTACTOE-SYNTAX
    syntax Game ::= Board | Game Turn
    syntax Board ::= "board" Int
    syntax Build ::= Column Cell
    syntax Column ::= "column" Int
    syntax Cell ::= "cell" Int Int
    syntax Turn ::= Player Int Int
    syntax Player ::= "w" | "b"
    syntax Coord ::= Int Int
    syntax Val ::= "e" | Player
endmodule

module TICTACTOE
    imports TICTACTOE-SYNTAX
    configuration <T>
        <k color="green">$PGM:K</k>
        <width>0</width>
        <height>0</height>
        <turn>w</turn>
        <square multiplicity="*">
            <x>0</x>
            <y>0</y>
            <v>e</v>
        </square>
    </T>

    rule <k> board W:Int => column W -Int 1 ...</k> <width> _ => W </width> <height> _ => W </height>
    rule <height> H </height> <k> column 0 => cell 0 (H -Int 1) ...</k>
    rule <height> H </height> <k> column X => column (X -Int 1) ~> cell X (H -Int 1) ...</k> when X >Int 0
    rule <k> cell X 0 => . ...</k> (. => <square> <x> X </x> <y> 0 </y> <v> e </v> </square>)
    rule <k> cell X Y => cell X (Y -Int 1) ...</k> (. => <square> <x> X </x> <y> Y </y> <v> e </v> </square>) when Y >Int 0
endmodule

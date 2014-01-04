
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

    //rule <k> board W:Int ...</k> => <square> <x> W </x> <y> W </y> </square> <square> <x> W -Int 1 </x> <y> W -Int 1 </y> </square>
    rule <k> board W:Int => column 0 ...</k> <width> _ => W </width> <height> _ => W </height>
    rule <k> column X => column X +Int 1 cell X 0 ...</k>
    rule <k> cell X Y ...</k> => <square> <x> X </x> <y> Y </y> <v> e </v> </square> when Y =Int 0
    rule <k> cell X Y => cell X Y +Int 1 ...</k> <width> W </width> <square> <x> X </x> <y> Y </y> <v> e </v> </square> when Y <Int W
    //rule <k> cell X:Int Y:Int => cell X +Int 1 Y ...</k> <square> <x> X </x> <y> Y </y> <v> e </v> </square>
endmodule

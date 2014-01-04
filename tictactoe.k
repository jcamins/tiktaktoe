
module TICTACTOE-SYNTAX
    syntax Stmt ::= Exp ";" [strict]
                    | Stmt Stmt [strict, left]
    syntax Exp ::= Board | Column | Cell | Turn
    syntax Board ::= "board" Int
    syntax Column ::= "column" Int
    syntax Cell ::= "cell" Int Int
    syntax Turn ::= Player Int Int
    syntax Player ::= "w" | "b"
endmodule

module TICTACTOE
    imports TICTACTOE-SYNTAX
    configuration <T>
        <k color="green">board 3; $PGM:K</k>
        <width>0</width>
        <height>0</height>
        <turn>w</turn>
        <winner>.</winner>
        <square multiplicity="*">
            <x>.</x>
            <y>.</y>
            <v>.</v>
        </square>
    </T>

    syntax Player ::= "swap" "(" Player ")" [function]
    rule swap(w) => b 
    rule swap(b) => w

    rule St1:Stmt St2:Stmt => St1 ~> St2
    rule Exp ; => Exp
    rule <k> board W:Int => column (W -Int 1) ...</k>
         <width> _ => W </width>
         <height> _ => W </height>
    rule <height> H </height>
         <k> column 0 => cell 0 (H -Int 1); ...</k>
    rule <height> H </height>
         <k> column X => column (X -Int 1); ~> cell X (H -Int 1); ...</k>
             when X >Int 0
    rule <k> cell X 0 => . ...</k>
         (. => <square> <x> X </x> <y> 0 </y> <v> . </v> </square>)
    rule <k> cell X Y => cell X (Y -Int 1) ...</k>
         (. => <square> <x> X </x> <y> Y </y> <v> . </v> </square>)
            when Y >Int 0

    rule <turn> P => swap(P) </turn>
         <k> P X Y => . ...</k>
         <square> <x> X </x> <y> Y </y> <v> . => P</v> </square>

    rule <square> <x> X </x> <v> P </v> ...</square>
         <square> <x> X </x> <v> P </v> ...</square>
         <square> <x> X </x> <v> P </v> ...</square> <winner> . => P </winner>

    rule <square> <y> Y </y> <v> P </v> ...</square>
         <square> <y> Y </y> <v> P </v> ...</square>
         <square> <y> Y </y> <v> P </v> ...</square> <winner> . => P </winner>

    rule <square> <x> N1 </x> <y> N1 </y> <v> P </v> ...</square>
         <square> <x> N2 </x> <y> N2 </y> <v> P </v> ...</square>
         <square> <x> N3 </x> <y> N3 </y> <v> P </v> ...</square> <winner> . => P </winner>
endmodule

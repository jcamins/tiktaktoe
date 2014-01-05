module TICTACTOE-SYNTAX
    syntax Exp ::= Exp Exp [strict, left]
                 | "board"
                 | "column" Int
                 | "cell" Int Int
                 | Turn
    syntax Turn ::= Player Int Int
    syntax Player ::= "w" | "b"
endmodule

module TICTACTOE
    imports TICTACTOE-SYNTAX
    configuration <T>
        <k color="green">board $PGM:K</k>
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
    rule E1:Exp E2:Exp => E1 ~> E2

    rule <k> board => column 2 ...</k>
    rule <k> column 0 => cell 0 2 ...</k>
    rule <k> column X => column (X -Int 1) ~> cell X 2 ...</k>
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
         <square> <x> X </x> <v> P </v> ...</square>
                  <winner> . => P </winner>

    rule <square> <y> Y </y> <v> P </v> ...</square>
         <square> <y> Y </y> <v> P </v> ...</square>
         <square> <y> Y </y> <v> P </v> ...</square>
                  <winner> . => P </winner>

    rule <square> <x> N1 </x> <y> N1 </y> <v> P </v> ...</square>
         <square> <x> N2 </x> <y> N2 </y> <v> P </v> ...</square>
         <square> <x> N3 </x> <y> N3 </y> <v> P </v> ...</square>
                  <winner> . => P </winner>
endmodule

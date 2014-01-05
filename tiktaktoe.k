module TIKTAKTOE-SYNTAX
    syntax Exp ::= Exp Exp [strict, left]
                 | "board"
                 | "won"
                 | "column" Int
                 | "cell" Int Int
                 | Turn
    syntax Turn ::= Player Int Int
    syntax Player ::= "w" | "b"
endmodule

module TIKTAKTOE
    imports TIKTAKTOE-SYNTAX
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
         <k> P X Y => won ...</k>
         <square> <x> X </x> <y> Y </y> <v> . => P</v> </square>
         <square> <x> X2 </x> <y> Y2 </y> <v> P </v> ...</square>
         <square> <x> X3 </x> <y> Y3 </y> <v> P </v> ...</square>
                  <winner> . => P </winner>
                  when          ((X +Int X2 +Int X3) %Int 3 ==Int 0)
                        andBool ((Y +Int Y2 +Int Y3) %Int 3 ==Int 0)
                        andBool (
                                   (X ==Int Y andBool X ==Int 1)
                            orBool (X2 ==Int Y2 andBool X2 ==Int 1)
                            orBool (X3 ==Int Y3 andBool X3 ==Int 1)
                            orBool (X ==Int X2)
                            orBool (Y ==Int Y2)
                        )

    rule <turn> P => swap(P) </turn>
         <k> P X Y => . ...</k>
         <square> <x> X </x> <y> Y </y> <v> . => P </v> </square>
         <square> <x> X </x> <y> Y2 </y> <v> P2 </v> ...</square>
         <square> <x> X2 </x> <y> Y </y> <v> P3 </v> ...</square>
                  when X2 =/=Int X andBool Y2 =/=Int Y

endmodule

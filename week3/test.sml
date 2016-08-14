use "hw.sml";

(* 1a *)
val t1a1 = all_except_option ("string", ["string"]) = SOME []
val t1a2 = all_except_option ("str", ["string"]) = NONE
val t1a3 = all_except_option ("string", ["bar", "string", "foo"]) = SOME ["bar", "foo"]


(* 1b *)
val t1b1 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val t1b2 = get_substitutions1 ([["foo", "yep"],["there"]], "foo") = ["yep"]
val t1b3 = get_substitutions1 ([["foo", "there"],["there", "foo"]], "foo") = ["there", "there"]

(* 1c *)
val t1c1 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val t1c2 = get_substitutions2 ([["foo", "yep"],["there"]], "foo") = ["yep"]
val t1c3 = get_substitutions2 ([["foo", "there"],["there", "foo"]], "foo") = ["there", "there"]

(* 1d *)
val test4 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
        [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
         {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
(* 2a *)
val t2a1 = card_color (Clubs, Num 2) = Black
val t2a2 = card_color (Hearts, Ace) = Red

(* 2b *)
val t2b1 = card_value (Clubs, Num 2) = 2
val t2b2 = card_value (Clubs, Ace) = 11
val t2b3 = card_value (Clubs, Queen) = 10

(* 2c *)
val t2c1 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val t2c2 = remove_card ([(Hearts, Ace), (Clubs, Queen)], (Hearts, Ace), IllegalMove) = [(Clubs, Queen)]
val t2c3 = remove_card ([(Hearts, Ace), (Clubs, Queen), (Hearts, Ace)], (Hearts, Ace), IllegalMove) = [(Clubs, Queen), (Hearts, Ace)]

(* 2d *)
val t2d1 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val t2d2 = all_same_color [(Hearts, Ace), (Diamonds, Ace)] = true
val t2d3 = all_same_color [(Hearts, Ace), (Clubs, Ace)] = false

(* 2e *)
val t2e1 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val t2e2 = sum_cards [(Clubs, Num 2),(Clubs, Ace)] = 13
val t2e3 = sum_cards [(Clubs, Queen),(Clubs, Num 1)] = 11

(* 2f *)

val t2f1 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val t2f2 = score ([(Hearts, Num 8),(Clubs, Num 4)],10) = 6
val t2f3 = score ([(Spades, Num 8),(Clubs, Num 4)],10) = 3
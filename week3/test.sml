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
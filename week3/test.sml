use "hw.sml";

(* 1a *)
val t1a1 = all_except_option ("string", ["string"]) = SOME []
val t1a2 = all_except_option ("str", ["string"]) = NONE
val t1a3 = all_except_option ("string", ["bar", "string", "foo"]) = SOME ["bar", "foo"]


(* 1b *)
val t1b1 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val t1b2 = get_substitutions1 ([["foo", "yep"],["there"]], "foo") = ["yep"]
val t1b3 = get_substitutions1 ([["foo", "there"],["there", "foo"]], "foo") = ["there", "there"]
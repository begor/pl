use "hw.sml";

(* 1a *)
val t1a1 = all_except_option ("string", ["string"]) = SOME []
val t1a2 = all_except_option ("str", ["string"]) = NONE
val t1a3 = all_except_option ("string", ["bar", "string", "foo"]) = SOME ["bar", "foo"]

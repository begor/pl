use "hw.sml";

(* 1 *)
val t11 = only_capitals ["A","B","C"] = ["A","B","C"]
val t12 = only_capitals ["A","bB","C"] = ["A","C"]
val t13 = only_capitals ["aA","bB","cC"] = []

(* 2 *)
val t21 = longest_string1 ["A","bc","C"] = "bc"
val t22 = longest_string1 [] = ""
val t23 = longest_string1 ["aA","bc","C"] = "aA"

(* 3 *)
val t31 = longest_string2 ["A","bc","C"] = "bc"
val t32 = longest_string2 [] = ""
val t33 = longest_string2 ["aA","bc","C"] = "bc"

(* 4 *)
val t41 = longest_string3 ["A","bc","C"] = "bc"
val t42 = longest_string3 [] = ""
val t43 = longest_string3 ["aA","bc","C"] = "aA"
val t44 = longest_string4 ["A","bc","C"] = "bc"
val t45 = longest_string4 [] = ""
val t46 = longest_string4 ["aA","bc","C"] = "bc"
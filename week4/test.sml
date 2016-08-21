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

(* 5 *)
val t51 = longest_capitalized ["A","bc","C"] = "A"
val t52 = longest_capitalized ["A","Bc","C"] = "Bc"
val t53 = longest_capitalized ["a","bc","cC"] = ""

(* 6 *)
val t61 = rev_string "abc" = "cba"
val t62 = rev_string "" = ""
val t63 = rev_string "aBc" = "cBa"

(* 7 *)
val t71 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4
val t72 = first_answer (fn x => if x > 4 then SOME x else NONE) [1,2,3,4,5] = 5
val t73 = ((first_answer (fn x => if x > 6 then SOME x else NONE) [1,2,3,4,5]); false) handle NoAnswer => true
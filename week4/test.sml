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

(* 8 *)
val t81 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val t82 = all_answers (fn x => if x < 8 then SOME [x] else NONE) [2,3,4,5,6,7] = SOME [2,3,4,5,6,7]
val t83 = all_answers (fn x => if x < 8 then SOME [x * 2] else NONE) [2,3,4,5,6,7] = SOME [4,6,8,10,12,14]
val t84 = all_answers (fn x => if x < 5 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val t85 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [] = SOME []

(* 9 *)
val t9a1 = count_wildcards Wildcard = 1
val t9a2 = count_wildcards (TupleP [Wildcard, Wildcard, UnitP]) = 2
val t9a3 = count_wildcards UnitP = 0

val t9b1 = count_wild_and_variable_lengths (Variable("a")) = 1
val t9b2 = count_wild_and_variable_lengths Wildcard = 1
val t9b3 = count_wild_and_variable_lengths (Variable("abc")) = 3
val t9b4 = count_wild_and_variable_lengths (TupleP [Variable("ab"), Wildcard, UnitP]) = 3

val t9c1 = count_some_var ("x", Variable("x")) = 1
val t9c2 = count_some_var ("x", Variable("a")) = 0
val t9c3 = count_some_var ("x", (TupleP [Variable("x"), Variable("a"), UnitP])) = 1
val t9c4 = count_some_var ("x", (TupleP [Variable("x"), Variable("a"), Variable("x")])) = 2

(* 10 *)
val t101 = check_pat (Variable("x")) = true
val t102 = check_pat (TupleP [Variable("x"), Variable("a"), UnitP]) = true
val t103 = check_pat (TupleP [Variable("x"), Variable("a"), Variable("a")]) = false
val t104 = check_pat UnitP = true

(* 11 *)
val t111 = match (Const(1), UnitP) = NONE
val t112 = match (Const(1), ConstP(1)) = SOME []
val t113 = match ((Tuple [Const(1), Const(3)]),
				  (TupleP [Variable("x"), Variable("a")])) = SOME [("x", Const 1),("a", Const 3)]

(* 12 *)
val test121 = first_match Unit [UnitP] = SOME []
val test122 = first_match Unit [Wildcard, ConstP(1), UnitP] = SOME []
val test123 = first_match (Const 1) [Wildcard, ConstP(1), UnitP] = SOME []
val test124 = first_match (Const 1) [UnitP, UnitP] = NONE
val test125 = first_match (Const 1) [Variable "x", Wildcard, ConstP(1), UnitP] = SOME [("x", Const 1)]
val test126 = first_match (Const 1) [Wildcard, Variable "x", ConstP(1), UnitP] = SOME []
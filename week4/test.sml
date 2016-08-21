use "hw.sml";

val t11 = only_capitals ["A","B","C"] = ["A","B","C"]
val t12 = only_capitals ["A","bB","C"] = ["A","C"]
val t13 = only_capitals ["aA","bB","cC"] = []
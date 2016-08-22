(* Type inference *)

(*

sum : T1 -> T2
xs  : T1

xs  : T3 list (pattern-match against list)
T2  : int ([] => 0, and 0 is an int)
x   : T3
xs' : T3 list (x::xs pattern)
x   : int (we + it, and + must be an int, because other matching branch is an int)
xs' : int list

So,

sum : int list -> int

*)
fun sum xs =
	case xs of
		[] => 0
		| x::xs' => x + sum xs'

(*

THIS WILL NOT TYPE-CHECK

sum : T1 -> T2
xs  : T1

xs  : T3 list (pattern-match against list)
T2  : int ([] => 0, and 0 is an int)
x   : T3
xs' : T3 list (x::xs pattern)
x   : int (we + it, and + must be an int, because other matching branch is an int)

So far: sum : int list -> int

But his will not type-check, because we call int list -> int with int

*)
fun sum xs =
	case xs of
		[] => 0
		| x::xs' => x + sum x
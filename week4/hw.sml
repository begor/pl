(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* 1 *)
fun only_capitals xs =
	let 
		fun is_capital w = Char.isUpper(String.sub(w, 0))
	in
		List.filter is_capital xs
	end

(* 2 *)
fun longest_string1 xs =
	let 
		fun longer(x, y) = if String.size x > String.size y then x else y
	in 
		List.foldl longer "" xs 
	end

(* 3 *)
fun longest_string2 xs =
	let 
		fun longer(x, y) = if String.size x >= String.size y then x else y
	in 
		List.foldl longer "" xs 
	end

(* 4 *)
fun longest_string_helper f xs = List.foldl f "" xs 
val longest_string3 = longest_string_helper (fn (x, y) => if String.size x > String.size y then x else y)

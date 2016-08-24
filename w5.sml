(* Type inference *)

(*

sum : T1 -> T2
xs  : T1

xs  : T3 list (pattern-match against list)
T1  = T3 list
T2  = int ([] => 0, and 0 is an int)
x   : T3
xs' : T3 list (x::xs pattern)
x   : int (we + it, and + must be an int, because other matching branch is an int)
T3  = int
T1  = int list
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
T1  = T3 list
T2  = int ([] => 0, and 0 is an int)
x   : T3
xs' : T3 list (x::xs pattern)
x   : int (we + it, and + must be an int, because other matching branch is an int)
T3  = int

So far: sum : int list -> int

But his will not type-check, because we call int list -> int with int

fun sum xs =
    case xs of
        [] => 0
        | x::xs' => x + sum x
*)


(* Polymorphic types *)

(*
len : T1 -> T2
xs  : T1
xs  : T3 list (pattern match it)
T2  : int (return 0 in one branch)
x   : T3 

So far: len: T3 list -> int
This is all the constraints, so T3 can be any type, call it 'a
So:
len: 'a list -> int
*)
fun len xs =
    case xs of
        [] => 0
        | x::xs' => 1 + len xs'


(* 

f : T1 -> T2
T1 = T3 * T4 * T5
T2 = T3 * T4 * T5 | T4 * T3 * T5 = T3 * T3 * T5 (we need it to return the same type)

So,
f : 'a * 'a * 'b -> 'a * 'a * 'b

*)
fun f (x, y, z) = 
    if true
    then (x, y, z)
    else (y, x, z)

(*
compose : T1 * T2 -> T3
f       : T1
g       : T2 
x       : T4
T3      = T4 -> T5          
T2      = T4 -> T6
T1      = T6 -> T5

So,

compose : ('a -> 'b) * ('c -> 'a) -> ('c -> 'b)
*)
fun compose (f, g) = fn x => f(g x)


(* Mutual recursion and state machines *)
fun match xs = 
    let fun need_one xs =
            case xs of
                [] => true
                | 1::xs' => need_two xs'
                | _ => false
        (* and instead of fun for mutual recursion *)
        and need_two xs =
            case xs of
                [] => false
                | 2::xs' => need_one xs'
                | _ => false
    in
        need_one xs
    end

val t = match [1, 2, 1, 2, 1, 2]
val f = match [1, 2, 2, 1]

(* Works with datatypes also *)
datatype t1 = 
    One of int 
    | Two of t2
and t2 =
    Three of int
    | Four of t1

(* Signatures *)
signature MATH = 
sig
    val fact : int -> int
    (* val half_pi : real *) (* Omitting is the form of hiding *) 
end

structure MyMath :> MATH = 
struct
    fun fact x = 
        if x = 0
        then 1
        else x * fact (x - 1)
    val half_pi = Math.pi / 2.0
end

val hundred_twenty = MyMath.fact 5
(* val an_error = MyMath.half_pi *)
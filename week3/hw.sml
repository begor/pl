(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* a *)
fun all_except_option(str, lst) = 
    let fun remove_from_list(str, lst) =
        case lst of
            [] => []
            | x::xs => if same_string(str, x) 
                       then remove_from_list(str, xs)
                       else x::remove_from_list(str,xs)
        val filtered_list = remove_from_list(str, lst)
    in
        if filtered_list = lst then NONE else SOME filtered_list
    end

(* b *)
fun get_substitutions1(subs, str) = 
    case subs of
        [] => []
        | x::xs => case all_except_option(str, x) of
                        NONE => get_substitutions1(xs, str)
                        | SOME i => get_substitutions1(xs, str) @ i

(* c *)
fun get_substitutions2(subs, str) = 
    let fun aux(subs, acc) =
            case subs of
                [] => acc
                | x::xs => case all_except_option(str, x) of
                                NONE => aux(xs, acc)
                                | SOME i => aux(xs, acc @ i)
    in 
        aux(subs, [])
    end

(* d *)
fun similar_names(subs, name) = 
    let val {first=first, last=last, middle=middle} = name

        fun get_similars(names) =
            case names of
                [] => []
                | x::xs => {first=x, last=last, middle=middle}::get_similars(xs)
    in
        name::get_similars(get_substitutions2 (subs, first))
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(* a *)
fun card_color card =
    case card of
        (Spades, _) => Black
        | (Clubs, _) => Black
        | _ => Red

(* b *)
fun card_value card =
    case card of
        (_, Num i) => i
        | (_, Ace) => 11
        | _ => 10 

(* c *)
fun remove_card (cs, c, e) =
    case cs of
        [] => raise e
        | x::xs => if x = c
                   then xs
                   else x::remove_card(xs, c, e) 


(* d *)
fun all_same_color cs =
    case cs of
        [] => true
        | x::[] => true
        | x::y::ys => if card_color x = card_color y
                      then all_same_color (y::ys)
                      else false

(* e *)
fun sum_cards cs =
    let fun aux (cs, acc) = 
            case cs of
                [] => acc
                | x::xs => aux(xs, acc + card_value x)
    in 
        aux(cs, 0)
    end
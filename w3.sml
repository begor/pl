

datatype exp = 
    Constant of int 
    | Negate of exp
    | Add of exp * exp
    | Multiply of exp * exp
    | Div of exp * exp

fun max_constant e =
    case e of
        Constant i => i
        | Negate e1 => max_constant e1
        | Add (e1, e2) => Int.max(max_constant e1, max_constant e2)
        | Multiply (e1, e2) => Int.max(max_constant e1, max_constant e2)
        | Div (e1, e2) => Int.max(max_constant e1, max_constant e2)

fun eval e = 
    case e of
        Constant i => i
        | Negate e => ~ (eval e)
        | Add (e1, e2) => eval e1 + eval e2
        | Multiply (e1, e2) => eval e1 * eval e2
        | Div (e1, e2) => eval e1 div eval e2


datatype ('a, 'b) tree = 
    Leaf of int 
    | Node of int * ('a, 'b) tree * ('a, 'b) tree

val my_tree = Node(3, Leaf 4, Node(5, Leaf 6, Leaf 7))


fun mapTree (f, t) =
    case t of
        Leaf i => Leaf (f i)
        | Node (x, t1, t2) => Node (f x, mapTree (f, t1), mapTree (f, t2))


fun inc i = i + 1
val xxx = mapTree (inc, my_tree)

fun sum_tree t = 
    case t of
        Leaf i => i
        | Node (x, t1, t2) => x + sum_tree t1 + sum_tree t2


fun max_in_tree t = 
    case t of
        Leaf i => i
        | Node (x, t1, t2) => Int.max(Int.max(x, max_in_tree t1), max_in_tree t2)


fun count_of_nodes t =
    case t of
        Leaf _ => 0
        | Node (_, lft, rgt) => 2 + count_of_nodes lft + count_of_nodes rgt

val sum = sum_tree my_tree
val max = max_in_tree my_tree
val c = count_of_nodes my_tree


fun eq_types (a, al) =
    a = hd al

fun sum_of_two (_, x, y) = 
    x + y 

val z = sum_of_two (42, 1, 2)

exception Ololo

fun zip triples = 
    case triples of
        ([], [], []) => []
        | (h1::t1, h2::t2, h3::t3) => (h1, h2, h3)::zip(t1, t2, t3)
        | _ => raise Ololo


fun unzip lst =
    case lst of
        [] => ([], [], [])
        | (a, b, c)::tl => let val (l1, l2, l3) = unzip tl
                           in 
                            (a::l1, b::l2, c::l3)
                           end

val klkl = unzip(zip([1, 2, 3], [4, 5, 6], [7, 8, 9]))
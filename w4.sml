fun map (f, x) =
	case x of
		[] => []
		| x::xs => (f x)::map(f, xs)

fun filter (f, x) =
	case x of 
		[] => []
		| x::xs => if f x then x::filter(f, xs) else filter(f, xs)


val a = [1, 2, 3, 4, 5]
val a_sqr = map(fn x => x * x, a)
val a_even = filter(fn x => x mod 2 = 0, a)
val a_odd = filter(fn x => x mod 2 <> 0, a)

fun fold (f, acc, xs) =
	case xs of 
		[] => acc
		| x::xs' => fold (f, f(acc, x), xs')

val sum_a = fold(fn (x, y) => x + y, 0, a)
val not_all_even = fold(fn (x, y) => x andalso y mod 2 = 0, true, a)
val all_even = fold(fn (x, y) => x andalso y mod 2 = 0, true, a_even)

(* map and filter in terms of fold *)
fun map1 (f, xs) = fold(fn (xs, x) => (f x)::xs, [], xs)

val a_sqr1 = map(fn x => x * x, a)

fun filter1 (f, xs) = 
	let
		fun filter_and_append (xs, x) = if f x then x::xs else xs
	in
		fold(filter_and_append, [], xs)
	end

val a_even1 = filter(fn x => x mod 2 = 0, a)

fun mul_two x = x * 2
fun sqr x = x * x

val mul_two_squared = map(mul_two o sqr, a)

(* infix combination *)
infix |>
fun x |> f = f x

fun even_only xs = filter(fn x => x mod 2 = 0, xs)
fun greater_two xs = filter(fn x => x > 2, xs)

fun even_greater_two xs = xs |> even_only |> greater_two

val xs = [1, 2, 3, 4, 5, 6, 7, 8]
val xs_bigger_two_and_even = even_greater_two xs


(* currying *)
fun sorted_tupled (x, y, z) = z >= y andalso y >= x
val sorted_curried = fn x => fn y => fn z => z >= y andalso y >= x

val s1 = sorted_tupled (2, 4, 6)
val s2 = sorted_curried 2 4 6 (* equivalent *)

(* also equivalent, syntactic sugar for sorted_curried *)
fun sorted x y z = z >= y andalso y >= x
val s3 = sorted 2 4 6


fun fold_c f acc xs =
	case xs of 
		[] => acc
		| x::xs' => fold_c f (f(acc, x)) xs'


fun sum_list xs = fold_c (fn (x, y) => x + y) 0 xs

val four = sum_list [1, 1, 2]
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
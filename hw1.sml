(* Helper functions. 
We use #n very often, so it's reasonable to abstract those things.*)
fun year(date: int * int * int) = #1 date
fun month(date: int * int * int) = #2 date
fun day(date: int * int * int) = #3 date


(* Takes two dates and evaluates to true or false.  *)
fun is_older(date1: int * int * int, 
             date2: int * int * int) =
  (year date1 < year date2) 
  orelse 
  (year date1 = year date2 andalso month date1 < month date2)
  orelse
  (year date1 = year date2 andalso month date1 = month date1 andalso day date1 < day date2)


(* Takes a date and a month number and return number of dates in that month. *)
fun number_in_month(dates: (int * int * int) list, month_number: int) =
    if null dates
    then 0
    else if month (hd dates) = month_number
         then 1 + number_in_month(tl dates, month_number)
         else number_in_month(tl dates, month_number)


(* Takes a date and a list of months's numbers and return number of dates in those months. *)
fun number_in_months(dates: (int * int * int) list, months: int list) =
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)


(* Takes a list of dates and a month number and returns dates in that month. *)
fun dates_in_month(dates: (int * int * int) list, month_number: int) =
    if null dates
    then []
    else if month (hd dates) = month_number
         then (hd dates)::dates_in_month(tl dates, month_number)
         else dates_in_month(tl dates, month_number)


(* Takes a list of dates and a list of months and returns dates in those months. *)
fun dates_in_months(dates: (int * int * int) list, months: int list) =
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)


(* Takes a list of strings and an int n and returns the nth element of the list *)
fun get_nth(strings: string list, index: int) =
    if index = 1
    then hd strings
    else get_nth(tl strings, index - 1)


(* Takes a date and returns a string of the form January 20, 2013 *)
fun date_to_string(date: (int * int * int)) = 
    let val months = ["January", "February", "March", "April", "May", "June", 
                      "July", "August", "September", "October", "November", "December"]
    in 
        get_nth(months, month date) ^ " " ^ Int.toString (day date) 
        ^ ", " ^ Int.toString (year date)
    end


(* Return n - number of elements in numbers list such that 
the first n elements of the list add to less than sum, but the first
n + 1 elements of the list add to sum or more *)
fun number_before_reaching_sum(sum: int, numbers: int list) =
    let fun reach(numbers: int list, index: int, acc: int) =
            if acc + hd numbers >= sum
            then index
            else reach(tl numbers, index + 1, acc + hd numbers)
    in
        reach(numbers, 0, 0)
    end


(* Takes a day of year and returns what month that day is in. *)
fun what_month(day: int) =
    let val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum(day, months) + 1
    end


(* Takes two days of the year day1 and day2 and returns an int list
[m1,m2,...,mn] where m1 is the month of day1, m2 is the month of day1+1 
and mn is the month of day day2. *)
fun month_range(d1: int, d2: int) =
    if d1 > d2
    then []
    else what_month(d1)::month_range(d1 + 1, d2)


(* Takes a list of dates and evaluates to an (int*int*int) option. 
It evaluates to NONE if the list has no dates 
and SOME d if the date d is the oldest date in the list. *)
fun oldest(dates: (int * int * int) list) =
    let fun old(dates: (int * int * int) list, oldest: int * int * int) =
            if null dates
            then oldest
            else let val current_oldest = if is_older(oldest, hd dates) then oldest else hd dates
                 in 
                    old(tl dates, current_oldest)
                 end
    in
        if null dates
        then NONE
        else SOME (old(tl dates, hd dates))
    end

fun unique(l: int list) =
    let fun in_list(el: int, l: int list) = 
            if null l
            then false
            else if hd l = el
                 then true
                 else in_list(el, tl l)

        fun remove(l: int list, acc: int list) =
            if null l
            then acc
            else if in_list(hd l, acc)
                 then remove(tl l, acc)
                 else remove(tl l, (hd l)::acc)
    in
        remove(l, [])
    end

fun number_in_months_challenge(dates: (int * int * int) list, months: int list) =
    number_in_months(dates, unique months)


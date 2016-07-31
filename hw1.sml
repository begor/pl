(* Helper functions. We use #n very often, so it's reasonable to abstract those things.*)
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
    else let val date = hd dates
             val others = tl dates
         in 
            if month date = month_number
            then date::dates_in_month(others, month_number)
            else dates_in_month(others, month_number)
         end


fun dates_in_months(dates: (int * int * int) list, months: int list) =
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)


fun get_nth(strings: string list, index: int) =
    if index = 1
    then hd strings
    else get_nth(tl strings, index - 1)


fun date_to_string(date: (int * int * int)) = 
    let val months = ["January", "February", "March", "April", "May", "June", 
                      "July", "August", "September", "October", "November", "December"]
        val month_string = get_nth(months, #2 date)
    in 
        month_string ^ " " ^ Int.toString (#3 date) ^ ", " ^ Int.toString (#1 date)
    end

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
(* Takes two dates and evaluates to true or false.  *)
fun is_older(date1: int * int * int, 
             date2: int * int * int) =
  (#1 date1 < #1 date2) 
  orelse 
  (#1 date1 = #1 date2 andalso #2 date1 < #2 date2)
  orelse
  (#1 date1 = #1 date2 andalso #2 date1 = #2 date1 andalso #3 date1 < #3 date2)


fun number_in_month(dates: (int * int * int) list, month: int) =
    if null dates
    then 0
    else if #2 (hd dates) = month
         then 1 + number_in_month(tl dates, month)
         else number_in_month(tl dates, month)


fun number_in_months(dates: (int * int * int) list, months: int list) =
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)


fun dates_in_month(dates: (int * int * int) list, month: int) =
    if null dates
    then []
    else let val date = hd dates
             val others = tl dates
         in 
            if #2 date = month
            then date::dates_in_month(others, month)
            else dates_in_month(others, month)
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
        val day_string = Int.toString (#3 date)
        val year_string = Int.toString (#1 date)
    in 
        month_string ^ " " ^ day_string ^ ", " ^ year_string
    end
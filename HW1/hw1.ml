(* PROBLEM 1: SUBSET*)

(* Subset - returns true if b is a subset of a, otherwise returns false  *)
let rec subset a b = match b with
	| [] -> true (* empty set is always a subset *)
	| first::rest -> if isElement first a then subset a rest 
                   else false;;

(* returns true if element is in the set *)
let rec isElement element set = match set with
  |[] -> false (* Assume that set will not be empty *)
  |first::rest -> if (first = element) then true
                  else isElement element rest;;
  
(* PROBLEM 2: SUBSET*)
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
  
(* PROBLEM 2: EQUAL SETS*)

(* Returns true if the two sets are equal, repeating elements is OK *)
let equalSets a b =
  if subset a b then 
    if subset b a then true
    else false
  else false;;

(* PROBLEM 3: SET UNION *)

(* Returns the union of two sets, repeating elements is OK *)
let rec setUnion a b = match b with
  |[] -> a (* if b is empty set, then the union is a *)
  |first::rest -> setUnion (a @ [first]) rest;;

(* PROBLEM 4: SET INTERSECTION *)

(* Returns the intersection of two sets *)
let rec setIntersection a b = match b with
  |[] -> []
  |first::rest -> if isElement first a then first :: (setIntersection a rest)
                  else setIntersection a rest;;

(* PROBLEM 5: SET DIFF *)

(* returns a list representing a−b, that is,
 the set of all members of a that are not also members of b *)
let rec setDiff a b = match a with
  |[] -> []
  |first::rest -> if isElement first b then setDiff rest b
                  else first :: (setDiff rest b);;

(* PROBLEM 5: FIXED POINTS *)
let rec computed_fixed_point eq f x = 
  if eq (f x) x then x
  else computed_fixed_point eq f (f x);;



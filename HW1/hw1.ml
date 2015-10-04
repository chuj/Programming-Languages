(* PROBLEM 1: SUBSET*)

(* returns true if element is in the set *)
let rec isElement element set = match set with
  |[] -> false (* Assume that set will not be empty *)
  |first::rest -> if (first = element) then true
                  else isElement element rest;;

(* Subset - returns true if a is a subset of b, otherwise returns false  *)
let rec subset a b = match a with
	| [] -> true (* empty set is always a subset *)
	| first::rest -> if isElement first b then subset rest b 
                   else false;;
  
(* PROBLEM 2: EQUAL SETS*)

(* Returns true if the two sets are equal, repeating elements is OK *)
let equal_sets a b =
  if subset a b then 
    if subset b a then true
    else false
  else false;;

(* PROBLEM 3: SET UNION *)

(* Returns the union of two sets, repeating elements is OK *)
let rec set_union a b = match b with
  |[] -> a (* if b is empty set, then the union is a *)
  |first::rest -> set_union (a @ [first]) rest;;

(* PROBLEM 4: SET INTERSECTION *)

(* Returns the intersection of two sets *)
let rec set_intersection a b = match b with
  |[] -> []
  |first::rest -> if isElement first a then first :: (set_intersection a rest)
                  else set_intersection a rest;;

(* PROBLEM 5: SET DIFF *)

(* returns a list representing a−b, that is,
 the set of all members of a that are not also members of b *)
let rec set_diff a b = match a with
  |[] -> []
  |first::rest -> if isElement first b then set_diff rest b
                  else first :: (set_diff rest b);;

(* PROBLEM 5: FIXED POINTS *)
let rec computed_fixed_point eq f x = 
  if eq (f x) x then x
  else computed_fixed_point eq f (f x);;

(* PROBLEM 6: COMPUTED PERIODIC POINT *)

(* returns the value of the next period *)
let rec next_period f p  x =
  if p = 0 then x
  else
    next_period f (p - 1) (f x);;

(* returns the computed periodic point *)
let rec computed_periodic_point eq f p x =
  if eq x (next_period f p x)
  then x
  else computed_periodic_point eq f p (f x);;

(* PROBLEM 7: FILTER BLIND ALLEYS *)

(* First go through the rules and identify terminal rules, save
those symbols in a list, then recursively go through the rules,
using the terminal rules to determine what new rules are also non blind alley rules
I use computed fixed points to determine when we've found all the non-blind-alley rules *)

type ('nonterminal, 'terminal) symbol =
  |T of 'terminal
  |N of 'nonterminal;;

(* This helper function reorders the list of non-blind alley rules to the correct order *)
let rec reorder unordered original_rules ordered = match original_rules with
  | [] -> ordered
  |first::rest -> if List.mem first unordered then first::(reorder unordered rest ordered)
                  else reorder unordered rest ordered;;

(* This helper function checks to see if the symbol can be substituted to be terminal*)
let is_symbol_terminal symbol terminal_rules = match terminal_rules with
  | sym , _ ->  if sym = symbol then true
                else false;;

(* Checks to see if the rule is already in the list*)
let rec not_in_list first terminal_rules = match terminal_rules with
  |[] -> true
  |a::b ->  if (a = first) then false
            else 
              not_in_list first b;; 

(* Checks to see if the rhs is terminal, first check if the rule is T, if not check the symbols
  to see if they can be substitued into terminals*)
let rec is_rhs_terminal rhs terminal_rules = match rhs with
    |[] -> true
    |first::rest -> match first with
                    |T _ -> is_rhs_terminal rest terminal_rules
                    |N symbol ->  if List.exists (is_symbol_terminal symbol) terminal_rules
                                    then is_rhs_terminal rest terminal_rules
                                  else false;;

(* returns a list of terminal rules using helper functions*)
let rec get_terminal_rules rules terminal_rules = match rules with
  |[] -> terminal_rules
  |first::rest -> match first with
                  |_ , rhs -> if (is_rhs_terminal rhs terminal_rules) && (not_in_list first terminal_rules)
                                then first::(get_terminal_rules rest terminal_rules)
                              else get_terminal_rules rest terminal_rules;;

(* returns the list of non-blind-alley rules*)
let filter_blind_alleys g = match g with
  | start_symbol, rules -> (start_symbol, reorder (computed_fixed_point equal_sets (get_terminal_rules rules) []) rules []);;

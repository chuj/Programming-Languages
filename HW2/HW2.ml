(*type def*)
type ('nonterminal, 'terminal) symbol =
	| N of 'nonterminal
	| T of 'terminal ;;

(* PROBLEM 1 *)

let rec get_rules non_terminal rules = match rules with
	|[] -> []
	|(symbol, rhs)::rest -> if non_terminal = symbol
										then rhs::(get_rules non_terminal rest)
										else	get_rules non_terminal rest;;

let convert_grammar g = match g with
	|start_symbol, rules -> (start_symbol,
													fun non_terminal-> get_rules non_terminal rules);;

(* PROBLEM 2 *)

(* rules is a list of lists containing what the symbol can be substituted with *)
let rec matcher_or start_sym prod_fun rules deriv acceptor frag = match rules with
	|[] -> None (* Iterated through all the rules and found no match*)
	|first::rest -> match (matcher_and prod_fun first acceptor (deriv@[start_sym, first]) frag) with (* here either some or none will be returned*) (*matcher_and - has to be a complete match to return something*)
									| None -> matcher_or start_sym prod_fun rest deriv acceptor frag (* not a match, move on to next rule*)
									| x -> x

and matcher_and prod_fun rule acceptor deriv frag = match rule with
	|[] -> acceptor deriv frag (* everything matched! so we return the output of acceptor*)
	|_ -> match frag with
				|[] -> None (* Bad case: rule is not done, but frag is empty *)
				|fst_frag::rst_frag ->  match rule with
																(*[] -> acceptor deriv frag*)
																|a::b -> match a with
																								|(N symbol) -> (matcher_or symbol prod_fun (prod_fun symbol) deriv (matcher_and (prod_fun) b acceptor) frag)
																								|(T symbol) ->if (symbol = fst_frag)
																														then matcher_and prod_fun b acceptor deriv rst_frag
																														else None

(* Main function, makes the call to matcher, returns parser generator*)
let parse_prefix gram acceptor frag = match gram with
	|(start_sym , prod_fun) -> matcher_or start_sym (prod_fun) (prod_fun start_sym) [] acceptor frag


































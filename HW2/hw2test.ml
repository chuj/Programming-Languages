let accept_all derivation string = Some (derivation, string)
let accept_empty_suffix derivation = function
   | [] -> Some (derivation, [])
   | _ -> None;;

type ('nonterminal, 'terminal) symbol =
	| N of 'nonterminal
	| T of 'terminal ;;

type awksub_nonterminals =
  | Expr | Term | Lvalue | Incrop | Binop | Num

let awkish_grammar =
  (Expr,
   function
     | Expr ->
         [[N Term; N Binop; N Expr];
          [N Term]]
     | Term ->
	 [[N Num];
	  [N Lvalue];
	  [N Incrop; N Lvalue];
	  [N Lvalue; N Incrop];
	  [T"("; N Expr; T")"]]
     | Lvalue ->
	 [[T"$"; N Expr]]
     | Incrop ->
	 [[T"++"];
	  [T"--"]]
     | Binop ->
	 [[T"+"];
	  [T"-"]]
     | Num ->
	 [[T"0"]; [T"1"]; [T"2"]; [T"3"]; [T"4"];
	  [T"5"]; [T"6"]; [T"7"]; [T"8"]; [T"9"]])

let test0 =
  ((parse_prefix awkish_grammar accept_all ["ouch"]) = None)

let test1 =
  ((parse_prefix awkish_grammar accept_all ["9"])
   = Some ([(Expr, [N Term]); (Term, [N Num]); (Num, [T "9"])], []))

let test2 =
  ((parse_prefix awkish_grammar accept_all ["9"; "+"; "$"; "1"; "+"])
   = Some
       ([(Expr, [N Term; N Binop; N Expr]); (Term, [N Num]); (Num, [T "9"]);
	 (Binop, [T "+"]); (Expr, [N Term]); (Term, [N Lvalue]);
	 (Lvalue, [T "$"; N Expr]); (Expr, [N Term]); (Term, [N Num]);
	 (Num, [T "1"])],
	["+"]));;

let test3 =
  ((parse_prefix awkish_grammar accept_empty_suffix ["9"; "+"; "$"; "1"; "+"])
   = None)

(* My own grammar tests*)

type ('nonterminal, 'terminal) symbol =
	| N of 'nonterminal
	| T of 'terminal ;;

(* NP = noun phrase, VP = verb phrase, Deter = determiner*)
type eng_nonterminals =
  | Sentence | NP | VP | Verb | Deter | Noun

let eng_grammar =
  (Sentence,
   function
     | Sentence ->
         [[N NP; N VP; N NP];
          [N NP; N VP]]
     | NP ->
		 [[N Noun];
		  [N Deter; N Noun];
		  [N Noun; N Deter; N Noun]]
     | VP ->
	 	[[N Verb; N Deter]; [N Verb]]
     | Deter ->
		 [[T"and"];
		  [T"a"];
		  [T"the"]]
     | Verb ->
		 [[T"ate"];
		  [T"saw"];
		  [T"tested"];
		  [T"played"]]
     | Noun ->
		 [[T"Jon"]; [T"Andy"]; [T"Allen"]; [T"Tasha"]; [T"Michelle"];
		  [T"Candy"]; [T"Dinosaur"]; [T"Program"]; [T"Dog"]])

let test_1 =
  (parse_prefix eng_grammar accept_empty_suffix ["Michelle"; "and"; "Tasha"; "saw"; "a"; "Dinosaur"])
   = Some ([(Sentence, [N NP; N VP; N NP]); (NP, [N Noun; N Deter; N Noun]);
   (Noun, [T "Michelle"]); (Deter, [T "and"]); (Noun, [T "Tasha"]);
   (VP, [N Verb; N Deter]); (Verb, [T "saw"]); (Deter, [T "a"]);
   (NP, [N Noun]); (Noun, [T "Dinosaur"])],
  []);;

let test_2 = 
	(parse_prefix eng_grammar accept_empty_suffix ["Jon"; "the"; "Dog"; "played"])
	= Some ([(Sentence, [N NP; N VP]); (NP, [N Noun; N Deter; N Noun]);
   (Noun, [T "Jon"]); (Deter, [T "the"]); (Noun, [T "Dog"]); (VP, [N Verb]);
   (Verb, [T "played"])],
  []);;










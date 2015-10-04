(* Test Cases for HW 1*)

(*Subset test cases*)
let subset_test0 = subset [] [3;5;6]
let subset_test1 = subset [2] [1;2;3]
let subset_test2 = not (subset [1;3;7] [9;8;3])

(*Equal set test cases*)
let equal_sets_test0 = equal_sets [2;4] [4;2;2]
let equal_sets_test1 = not (equal_sets [2;4;5] [4;2;4])

(*Equal set test cases*)
let set_union_test0 = equal_sets (set_union [] [2;3;4]) [2;3;4]
let set_union_test2 = equal_sets (set_union [] []) []

(*Set intersection test cases*)
let set_intersection_test0 =
  equal_sets (set_intersection [] [2;3;4]) []
let set_intersection_test1 =
  equal_sets (set_intersection [2;0;2] [0;1;2]) [0;2]

(*Set Diff test cases*)
let set_diff_test0 = equal_sets (set_diff [2;3] [2;5;4;2]) []
let set_diff_test1 = equal_sets (set_diff [3;2;0;0;2] [0;2]) [3]

(*Computed fixed point test cases*)
let my_computed_fixed_point_test1 =
  computed_fixed_point (=) (fun x -> x ** 3.) 3. = infinity

(*Computed periodic point test cases*)
let computed_periodic_point_test0 =
  computed_periodic_point (=) (fun x -> x / 2) 0 (-1) = -1

(*Filter blind alley test cases*)
type blind_alley_nonterminals =
  | Expr | Lvalue | Incrop | Binop | Num
;;

let blind_alley_test0 =
  filter_blind_alleys (Expr,
      [Expr, [N Num];
       Expr, [N Lvalue];
       Expr, [N Expr; N Lvalue];
       Expr, [N Lvalue; N Expr];
       Expr, [N Expr; N Binop; N Expr];
       Expr, [N Expr; N Lvalue; N Num];
       Lvalue, [N Lvalue; N Expr];
       Lvalue, [N Expr; N Lvalue];
       Lvalue, [N Incrop; N Lvalue];
       Lvalue, [N Lvalue; N Incrop];
       Lvalue, [N Lvalue; N Incrop; N Expr];
       Incrop, [T"++"]; Incrop, [T"--"];
       Binop, [T"+"]; Binop, [T"-"];
       Num, [T"0"]; Num, [T"1"]; Num, [T"2"]; Num, [T"3"]; Num, [T"4"]])
  = (Expr,
     [Expr, [N Num];
      Expr, [N Expr; N Binop; N Expr];
      Incrop, [T"++"]; Incrop, [T"--"];
      Binop, [T "+"]; Binop, [T "-"];
      Num, [T "0"]; Num, [T "1"]; Num, [T "2"]; Num, [T "3"]; Num, [T "4"]])


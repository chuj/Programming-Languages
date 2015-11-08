% N, a nonnegative integer specifying the number of cells on each side of the KenKen square
% C, a list of numeric cage constraints as described below.
% T, a list of list of integers. All the lists have length N. This represents the N×N grid.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      PART 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Addition rules
% Base Case: add [] to S gives you S
addition([], S, S, _).
% Recursive addition
addition([First|Rest], RunningSum , S , T) :- 
  getElement(First, V, T), 
  NewRunSum #= RunningSum + V,
  addition(Rest, NewRunSum, S, T)
.

% Subtraction rules
subtraction(D, _, _, _, D).
%Recursive Subtraction - case j - k
subtraction(D, J, K, T) :-
  getElement(J, J_val, T),
  getElement(K, K_val, T),
  D_result #= J_val - K_val,
  subtraction(D, J, K, T, D_result) 
.
%Recursive Subtraction - case k - j
subtraction(D, J, K, T) :-
  getElement(J, J_val, T),
  getElement(K, K_val, T),
  D_result #= K_val - J_val,
  subtraction(D, J, K, T, D_result) 
.

% Multiplication rules
multiplication([], P, P, _).
% Recursive multiplication
multiplication([First | Rest], RunningProd, P, T) :-
  getElement(First, V, T),
  NewRunProd #= RunningProd * V,
  multiplication(Rest, NewRunProd, P, T)
.

% Division rules
%Base case
division(Q, _, _, _, Q).
%Recursive Division case j / k
division(Q, J, K, T) :- 
  getElement(J, J_val, T),
  getElement(K, K_val, T),
  Q_result #= J_val / K_val,
  division(Q, J, K, T, Q_result)
.
%Recursive Division case k / j
division(Q, J, K, T) :- 
  getElement(J, J_val, T),
  getElement(K, K_val, T),
  Q_result #= K_val / J_val,
  division(Q, J, K, T, Q_result)
.

%Helper goal to get element value in matrix
getElement(Row-Col, V, T) :-
  nth( Row, T, T_row),
  nth( Col, T_row, V)  
.

% helper goal for checking list length equals N
getlength(N, List) :-  length(List, N). 

% Use fd_domain to set values from 1 to N
setDomain(N, List) :- fd_domain(List, 1, N).

% Transposing a list of lists, from clpfd.pl module
transpose([], []).
transpose([F|Fs], Ts) :-
    transpose(F, [F|Fs], Ts).

transpose([], _, []).
transpose([_|Rs], Ms, [Ts|Tss]) :-
        lists_firsts_rests(Ms, Ts, Ms1),
        transpose(Rs, Ms1, Tss).

lists_firsts_rests([], [], []).
lists_firsts_rests([[F|Os]|Rest], [F|Fs], [Os|Oss]) :-
        lists_firsts_rests(Rest, Fs, Oss).

kenken(N, C, T) :- 
  % use length/2 to see if length of T is same as N
  length(T, N),
  % additionally, each list in T must also be length N
  maplist(getlength(N) , T),
  % set the domain over all the elements
  maplist(setDomain(N), T),
  % Constraints must be met
  maplist(iterate_constraints(T) , C),
  % no numbers can be repeated in row or columns
  maplist(fd_all_different, T),
  % transpose T, call transposed matrix X
  transpose(T, X),
  % no numbers can be repeated in row or columns
  maplist(fd_all_different, X),
  % use fd_labeling to assign values
  maplist(fd_labeling, T)
  .

%helper goal for matching constraints
iterate_constraints(T, Constraint) :- match_constraint(T, Constraint).
%match the constraint with the following forms:
match_constraint(T, +(S, L)) :- addition( L, 0, S, T) .
match_constraint(T, *(P, L)) :- multiplication(L, 1, P, T).
match_constraint(T, -(D, J, K)) :- subtraction(D, J, K, T).
match_constraint(T, /(Q, J, K)) :- division(Q, J, K, T).

kenken_testcase(
  6,
  [
   +(11, [1-1, 2-1]),
   /(2, 1-2, 1-3),
   *(20, [1-4, 2-4]),
   *(6, [1-5, 1-6, 2-6, 3-6]),
   -(3, 2-2, 2-3),
   /(3, 2-5, 3-5),
   *(240, [3-1, 3-2, 4-1, 4-2]),
   *(6, [3-3, 3-4]),
   *(6, [4-3, 5-3]),
   +(7, [4-4, 5-4, 5-5]),
   *(30, [4-5, 4-6]),
   *(6, [5-1, 5-2]),
   +(9, [5-6, 6-6]),
   +(8, [6-1, 6-2, 6-3]),
   /(2, 6-4, 6-5)
  ]
).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      PART 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





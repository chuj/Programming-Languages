% N, a nonnegative integer specifying the number of cells on each side of the KenKen square
% C, a list of numeric cage constraints as described below.
% T, a list of list of integers. All the lists have length N. This represents the N×N grid.


kenken(N, C, T) :- 
  % use length/2 to see if length of T is same as N
  length(T, N),
  % additionally, each list in T must also be length N
  maplist(getlength(N) , T),
  % no numbers can be repeated in row or columns
  maplist(fd_all_different, T),
  % constraints have to be met
  

  .
  


% helper goal for checking list length equals N
getlength(N, List) :-  length(List, N). 

% Addition rules
%add [] to A gives you A
addition([], A, A, T).
%
addition([First|Rest], A, , T) :- .

% Subtraction rules
subtraction([], S, S).

% Multiplication rules
multiplication().

% Division rules
division().

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



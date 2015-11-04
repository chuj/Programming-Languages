let rec reverse a = match a with
	|[] -> []
	|h::t -> reverse t @ [h];;


let rec reverse = function
	|h::t -> reverse t @ [h]
	|[] -> [];;

let rec reverse l a  = match l with
	|[] -> a
	|h::t -> reverse t ([h] @ a);;

let rec minval l = match l with
	|[] -> nan
	|h::t ->  let m = minval t in
			
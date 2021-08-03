(* Write a function last : 'a list -> 'a option that returns the last element of a list. *)
let rec last = function
  | [] -> None
  | h :: [] -> Some h
  | _ :: t -> last t


(* Find the last but one (last and penultimate) elements of a list. *)
let rec last_two = function
  | [] | [_] -> None
  | [x; y] -> Some (x, y)
  | _ :: t -> last_two t


(* Find the K'th element of a list. *)
let rec at k = function
  | [] -> None
  | h :: t -> if k = 1 then Some h else at (k - 1) t


(* Find the number of elements of a list *)
let rec length = function
  | [] -> 0
  | _ :: t -> length t + 1


(* Reverse a list *)
(* 
  simple recursive implementation requires `append` operation,
  so we need change the calculation direction.  
*)
let rev lst = 
  let rec inner acc = function
    | [] -> acc 
    | h :: t -> inner (h :: acc) t 
  in  inner [] lst

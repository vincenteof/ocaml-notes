(* 1. Write a function last : 'a list -> 'a option that returns the last element of a list. *)
let rec last = function
  | [] -> None
  | h :: [] -> Some h
  | _ :: t -> last t


(* 2. Find the last but one (last and penultimate) elements of a list. *)
let rec last_two = function
  | [] | [_] -> None
  | [x; y] -> Some (x, y)
  | _ :: t -> last_two t


(* 3. Find the K'th element of a list. *)
let rec at k = function
  | [] -> None
  | h :: t -> if k = 1 then Some h else at (k - 1) t


(* 4. Find the number of elements of a list. *)
let rec length = function
  | [] -> 0
  | _ :: t -> length t + 1


(* 5. Reverse a list. *)
(* 
  simple recursive implementation requires `append` operation,
  so we need change the calculation direction.  
*)
let rev lst = 
  let rec inner acc = function
    | [] -> acc 
    | h :: t -> inner (h :: acc) t 
  in  inner [] lst


(* 6. Find out whether a list is a palindrome. *)
(*
  `=` stands for structural equality while `==` stands for physical equality.
*)
let is_palindrome lst = lst = rev lst


(* 7. Flatten a nested list structure. *)
type 'a node =
  | One of 'a 
  | Many of 'a node list

let rec flatten = function
  | One x -> [x]
  | Many [] -> []
  | Many ((One x) :: t) -> x :: (flatten (Many t))
  | Many ((Many l) :: t) -> (flatten (Many l)) @ (flatten (Many t))

(* 8. Eliminate consecutive duplicates of list elements. *)


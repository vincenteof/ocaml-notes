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
let rec compress = function
  | [] -> []
  | [x] ->[x]
  | h1 :: h2 :: t -> 
      let l = h2 :: t  in 
        if h1 = h2 
          then compress l 
          else h1 :: compress l

(* 9. Pack consecutive duplicates of list elements into sublists. *)
let pack lst = 
  let rec inner cur acc = function
    | [] -> acc
    | h :: t -> 
      match cur with
        | [] -> inner [h] acc t
        | cur_h :: cur_t -> if h = cur_h then inner (cur_h :: cur) acc cur_t else inner [cur_h] (cur :: acc) cur_t
  in (inner [] [] lst) |> rev

(* 10. Run-length encoding of a list.  *)
let encode lst = lst
  |> pack
  |> List.map (fun grp -> (length grp, List.hd grp)) 

(* 11. Modified run-length encoding. *)
type 'a rle = 
  | One of 'a
  | Many of int * 'a

let encode_to_rle lst = lst
  |> pack
  |> 
    let f = function
      | [x] -> One x
      | lst -> Many (length lst, List.hd lst) 
    in List.map f

(* 12. Decode a run-length encoded list. *)
let rec decode = function
  | [] -> []
  | One x :: t -> x :: decode t
  | Many (num, x) :: t ->  
    let rest = if num = 2 then One x :: t else Many (num - 1 , x) :: t 
    in x :: decode rest

(* 13. Run-length encoding of a list (direct solution). *)
(* It seems the same as 11? *)

(* 14. Duplicate the elements of a list. *)
  let duplicate lst = 
    let rec inner = function
      | [] -> lst 
      | h :: t -> h :: inner t
    in inner lst 
  
(* 15. Replicate the elements of a list a given number of times. *)
let replicate lst n = 
  let rec replicate_inner acc cur_l m = 
    match (cur_l, m) with
    | ([], 0) -> acc
    | ([], inner_m) -> replicate_inner acc lst (inner_m - 1)
    | (h :: t, inner_m) -> replicate_inner (h :: acc) t inner_m
  in rev (replicate_inner [] lst n)
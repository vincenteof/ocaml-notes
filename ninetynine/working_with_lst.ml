(* 1. Write a function last : 'a list -> 'a option that returns the last element of a list. *)
let rec last = function [] -> None | [ h ] -> Some h | _ :: t -> last t

(* 2. Find the last but one (last and penultimate) elements of a list. *)
let rec last_two = function
  | [] | [ _ ] -> None
  | [ x; y ] -> Some (x, y)
  | _ :: t -> last_two t

(* 3. Find the K'th element of a list. *)
let rec at k = function
  | [] -> None
  | h :: t -> if k = 1 then Some h else at (k - 1) t

(* 4. Find the number of elements of a list. *)
let rec length = function [] -> 0 | _ :: t -> length t + 1

(* 5. Reverse a list. *)
(* 
  simple recursive implementation requires `append` operation,
  so we need change the calculation direction.  
*)
let rev lst =
  let rec inner acc = function [] -> acc | h :: t -> inner (h :: acc) t in
  inner [] lst

(* 6. Find out whether a list is a palindrome. *)
(*
  `=` stands for structural equality while `==` stands for physical equality.
*)
let is_palindrome lst = lst = rev lst

(* 7. Flatten a nested list structure. *)
type 'a node = One of 'a | Many of 'a node list

let rec flatten = function
  | One x -> [ x ]
  | Many [] -> []
  | Many (One x :: t) -> x :: flatten (Many t)
  | Many (Many l :: t) -> flatten (Many l) @ flatten (Many t)

(* 8. Eliminate consecutive duplicates of list elements. *)
let rec compress = function
  | [] -> []
  | [ x ] -> [ x ]
  | h1 :: h2 :: t ->
      let l = h2 :: t in
      if h1 = h2 then compress l else h1 :: compress l

(* 9. Pack consecutive duplicates of list elements into sublists. *)
let pack lst =
  let rec inner cur acc = function
    | [] -> acc
    | h :: t -> (
        match cur with
        | [] -> inner [ h ] acc t
        | cur_h :: cur_t ->
            if h = cur_h then inner (cur_h :: cur) acc cur_t
            else inner [ cur_h ] (cur :: acc) cur_t)
  in
  inner [] [] lst |> rev

(* 10. Run-length encoding of a list.  *)
let encode lst = lst |> pack |> List.map (fun grp -> (length grp, List.hd grp))

(* 11. Modified run-length encoding. *)
type 'a rle = One of 'a | Many of int * 'a

let encode_to_rle lst =
  lst |> pack
  |>
  let f = function [ x ] -> One x | lst -> Many (length lst, List.hd lst) in
  List.map f

(* 12. Decode a run-length encoded list. *)
let rec decode = function
  | [] -> []
  | One x :: t -> x :: decode t
  | Many (num, x) :: t ->
      let rest = if num = 2 then One x :: t else Many (num - 1, x) :: t in
      x :: decode rest

(* 13. Run-length encoding of a list (direct solution). *)
(* It seems the same as 11? *)

(* 14. Duplicate the elements of a list. *)
let duplicate lst =
  let rec inner = function [] -> lst | h :: t -> h :: inner t in
  inner lst

(* 15. Replicate the elements of a list a given number of times. *)
let replicate lst n =
  let rec replicate_inner acc cur_l m =
    match (cur_l, m) with
    | [], 0 -> acc
    | [], inner_m -> replicate_inner acc lst (inner_m - 1)
    | h :: t, inner_m -> replicate_inner (h :: acc) t inner_m
  in
  rev (replicate_inner [] lst n)

(* 16. Drop every N'th element from a list. *)
let drop lst n =
  let rec drop_inner c acc = function
    | [] -> acc
    | h :: t ->
        if c = 1 then drop_inner n acc t else drop_inner (c - 1) (h :: acc) t
  in
  drop_inner n [] lst

(* 17. Split a list into two parts; the length of the first part is given.  *)
let split lst n =
  let rec split_inner c acc = function
    | [] -> (rev acc, [])
    | h :: t as l ->
        if c = 0 then (rev acc, l) else split_inner (c - 1) (h :: acc) t
  in
  split_inner n [] lst

(* 18. Extract a slice from a list. *)
let slice lst l r =
  let rec slice_inner p acc = function
    | [] -> rev acc
    | h :: t as cur_l ->
        if p < l then slice_inner (p + 1) acc cur_l
        else if p >= r then rev acc
        else slice_inner (p + 1) (h :: acc) t
  in
  slice_inner 0 [] lst

(* 19. Rotate a list N places to the left. *)
let rotate lst poses =
  let parts =
    let lst_len = length lst in
    let split_len =
      if poses > 0 then poses mod lst_len else -poses mod lst_len
    in
    split lst split_len
  in
  match parts with l1, l2 -> l2 @ l1

(* 20. Remove the K'th element from a list. *)
let rec remove_at pos = function
  | [] -> []
  | h :: t -> if pos = 0 then t else h :: remove_at (pos - 1) t

(* 21. Insert an element at a given position into a list. *)
let rec insert_at e pos = function
  | [] -> []
  | h :: t as l -> if pos = 0 then e :: l else h :: insert_at e (pos - 1) t

(* 22. Create a list containing all integers within a given range. *)
let rec range l r =
  if l = r then [ l ]
  else if l > r then l :: range (l - 1) r
  else l :: range (l + 1) r

open Ninetynine

let test_last () =
  match Working_with_lst.last [ "something"; "with"; "last" ] with
  | None -> Alcotest.fail "Unexcepted `None` result"
  | Some ret -> Alcotest.(check string) "last with string list" "last" ret

let () =
  let open Alcotest in
  run "working_with_lst" [ ("test_last", [ test_case "simple" `Quick test_last ]) ]

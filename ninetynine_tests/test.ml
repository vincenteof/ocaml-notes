let test () = Alcotest.(check string) "yes" "result" ((fun x -> x) "result")

let () =
  let open Alcotest in
  run "Yes" [ ("some case", [ test_case "simple" `Quick test ]) ]

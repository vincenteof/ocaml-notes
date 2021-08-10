### add tests
### how to print an object
There seems no way to print any type in ocaml. Something like haskell deriving exists in third party lib.

### how to format ocaml code
### how to combine `last to head merging` with iteration or vice versa?
Recursion or iteration determines the order of how to merge the result. (**99** 14 or 15)
When using tail recursion, we usually need using `rev`. 

### how to use match multiple function params without using tuple?
I want something like 
```ocaml
let rec f = function
  | param1, param2 -> ...
```
It seems an syntax error.
### add tests
### how to print an object
There seems no way to print any type in ocaml. Something like haskell deriving exists in third party lib.

### how to format ocaml code
I install `OCaml Formatter` in vscode markets, which uses `ocamlformat` internally.
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

### how to do imperative style programming? Like `do` in lisp?

### how to config sandbox?

### how to work with ocaml module? interface and implementation?

### In many cases, recursion is almost the same as math definition, and it is good. Bur in real problems, we also need to use tail-recursion to replace simple recursion, and it is a bit annoying. How to avoid it?

### how to do testing?
I found 2 testing frameworks which seem easy to use, `alcotest` and `ounit`. `alcotest` seems more modern. These two libraries can both be integrated with some property testing framework.

### how does `dune` works? I want to add some testing with testing frameworks dependency.


# Currying #
[See this explanation of currying](https://ocaml.org/learn/tutorials/functional_programming.html#Partialfunctionapplicationsandcurrying)

# One of many effects this has #
when writing a type signature in OCaml, `->`{.ocaml} is [_right associative_](http://stackoverflow.com/a/930505/1066911). This means that these two type signatures are the same:

```ocaml
val f1 : 'a -> 'b -> 'c
val f2 : 'a -> ('b -> 'c)
```

This has the effect of being able to write the same function multiple ways:

```ocaml
val f1 : 'a -> 'b -> 'c
let f1 x y = ("do something to get a 'c");;

val f2 : 'a -> ('b -> 'c)
let f2 x =
  let returnedFunction y = ("do something to get a 'c")
  in
    returnedFunction;;
```

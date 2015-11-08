(***** printing stuff *****)

let print_list print_elem l =
  let rec aux = function
    | [] -> ()
    | [x] -> print_elem x;
    | x::xs -> print_elem x; print_string ", "; aux xs
  in
    print_char '['; aux l; print_char ']'
;;
let print_int_list = print_list print_int;;
let nl             = print_newline;;
let print_bool b   = print_string (string_of_bool b);;

(***** set stuff *****)

(* remove duplicates *)
let set_of_list l =
  let rec aux acc = function
    | [] -> acc
    | x::xs -> if List.mem x acc then aux acc xs else aux (x::acc) xs
  in
    aux [] l
;;

(* all elements in a are in b *)
let rec subsetEq a b = match a with
  | [] -> true
  | x::xs -> List.mem x b && subsetEq xs b
;;

(* a trick similar to: numbersEq a b = a <= b && b <= a *)
let setsEq a b = subsetEq a b && subsetEq b a;;


(***** graph stuff *****)

(* outgoing neighbours. Includes duplicates *)
let rec getNeighbours v g = match g with
  | [] -> []
  | (s, e)::xs -> let rest = getNeighbours v xs in
                  if v = s then e :: rest
                           else rest
;;

(* List.split takes a ('a * 'b) list and gives ('a list, 'b list) *)
let getAllNodes g = let (ss, es) = List.split g in
                    set_of_list (ss @ es);;



let rec quietFollowLoop start current visited graph =
  let ns = getNeighbours current graph in
  match ns with
    | []  -> false   (* no outgoing edges *)
    | [e] ->         (* one outgoing edge to e *)
             let visited' = e::visited in 
             if List.mem e visited (* note: not visited' but visited *)
                then (* visited before: back to start? If so, have all nodes been visited? *)
                    e = start && setsEq visited' (getAllNodes graph)
                else (* still more nodes to visit *)
                    quietFollowLoop start e visited' graph
    | _   -> false   (* fork (multiple outgoing edges) *)
;;


(* functionally exactly the same as quietFollowLoop but with debugging messages *)
let rec noisyFollowLoop start current visited graph =
  print_string "visiting node: "; print_int current; nl ();
  let ns = set_of_list (getNeighbours current graph) in
  print_string "neighours: "; print_int_list ns; nl ();
  match ns with
    | [] -> print_string "no outgoing edges"; nl (); false (* no outgoing edges *)
    | [e] -> (* one outgoing edge to e *)
             let visited' = e::visited in 
             if List.mem e visited (* note: not visited' but visited *)
                then (* visited before: back to start? If so, have all nodes been visited? *)
                    (print_string "maybe end of loop:"; nl ();
                     print_string "> edge from current to start? "; print_bool (e = start); nl ();
                     print_string "> all nodes visited? "; print_bool (setsEq visited' (getAllNodes graph)); nl ();
                    e = start && setsEq visited' (getAllNodes graph))
                else (* still more nodes to visit *)
                    noisyFollowLoop start e visited' graph
    | _ -> print_string "fork"; nl (); false (* fork (multiple outgoing edges) *)
;;


(* cannot use the noisy version with the test bench because
   print_int forces the nodes to be ints, but loop must take
   graphs of ('a * 'a)
*)
let followLoop = noisyFollowLoop;; (* can be set to quietFollowLoop *)


let loop = function
  | []             -> false                (* empty graph *)
  | [(s, e)]       -> s = e                (* single edge eg 0 --> 0 (a loop) or 0 --> 1 (not a loop) *)
  | (s, e)::_ as g -> followLoop s s [s] g (* a graph with >1 edge *)
;;


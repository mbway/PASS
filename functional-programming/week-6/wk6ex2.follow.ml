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


let rec followLoop start current visited graph =
  let ns = getNeighbours current graph in
  match ns with
    | []  -> false   (* no outgoing edges *)
    | [e] ->         (* one outgoing edge to e *)
             let visited' = e::visited in 
             if List.mem e visited (* note: not visited' but visited *)
                then (* visited before: back to start? If so, have all nodes been visited? *)
                    e = start && setsEq visited' (getAllNodes graph)
                else (* still more nodes to visit *)
                    followLoop start e visited' graph
    | _   -> false   (* fork (multiple outgoing edges) *)
;;

let loop = function
  | []             -> false                (* empty graph *)
  | [(s, e)]       -> s = e                (* single edge eg 0 --> 0 (a loop) or 0 --> 1 (not a loop) *)
  | (s, e)::_ as g -> followLoop s s [s] g (* a graph with >1 edge *)
;;

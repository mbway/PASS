(*
This solution passes the test bench.
This solution is based on the method used by the model solutions.
See how this compares to them (there are slight differences).
*)

(* includes duplicates, removes edges between v and its neighbours *)
let rec getAndRemoveNeighbours v g = match g with
  | [] -> ([], g)
  | (s, e)::xs -> let (ns, g') = getAndRemoveNeighbours v xs in
                  if v = s then (e :: ns,          g')
                           else (     ns,  (s, e)::g')
;;

let rec loop = function
  | []        -> false (* empty graph *)
  | [(s, e)]  -> s = e (* single edge eg 0 --> 0 (a loop) or 0 --> 1 (not a loop) *)
  | (s, e)::g ->       (* a graph with >1 edge *)
                 let (ns_of_e, g') = getAndRemoveNeighbours e g in
                 match ns_of_e with
                   | []  -> false             (* dead end *)
                   | [x] -> loop ((s, x)::g') (* collapse s -> e -> x    to   s -> x *)
                   | _   -> false             (* more than one: fork
                                                 eg 0 --> 1 and 0 --> 2 cannot be part of a loop *)
;;


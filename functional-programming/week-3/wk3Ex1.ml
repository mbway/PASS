
let sort2 (a, b) = if a < b then (a, b) else (b, a);;

let singleBubble (a, b, c, d, e) = 
	let (a2, b2) = sort2(a,  b) in
	let (b3, c2) = sort2(b2, c) in
	let (c3, d2) = sort2(c2, d) in
	let (d3, e2) = sort2(d2, e) in
	(a2, b3, c3, d3, e2);;


let sort5 t = t |> singleBubble |> singleBubble |> singleBubble |> singleBubble;;


module List = struct
  include List
  let is_empty lst = List.length lst = 0
end

type literal = int

type cnf = literal list list

type result = Sat of cnf | Unsat of cnf

let assign (f : cnf) (v : literal) : cnf =
  f
  |> List.filter (List.for_all ((<>) v))
  |> List.map (List.filter ((<>) (-v)))

let rec apply_unit_rule (f : cnf) =
  match f |> List.find_opt (fun cl -> List.length cl = 1) with
  | Some v -> assign f (List.hd v) |> apply_unit_rule
  | None -> f

let is_pure (f : cnf) (v : literal) =
  if v < 0 then false
  else
    List.map (List.find_opt (fun e -> e = (-v))) f
    |> List.for_all (fun e -> e = None)

let rec apply_pure_literal_rule (f : cnf) (v : literal) =
  if v < 0 then None
  else begin
    if is_pure f v then Some (f |> List.filter (List.mem v))
    else None
  end

let rec dpll (f : cnf) =
  match f |> apply_unit_rule with
  | [] -> true
  | new_f when List.exists List.is_empty new_f -> false
  | new_f ->
    let v = new_f |> List.hd |> List.hd in
    match apply_pure_literal_rule new_f v with
    | Some new_f' ->
      let v' = new_f' |> List.hd |> List.hd in
      dpll (assign new_f' v') || dpll (assign new_f' (-v'))
    | None ->
      dpll (assign new_f v) || dpll (assign new_f (-v))

let solve (f : cnf) =
  if dpll f then Sat f
  else Unsat f

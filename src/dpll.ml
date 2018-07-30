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

let rec dpll (f : cnf) =
  match f |> apply_unit_rule with
  | [] -> true
  | new_f when List.exists List.is_empty new_f -> false
  | new_f ->
    let v = new_f |> List.hd |> List.hd in
    dpll (assign new_f v) || dpll (assign new_f (-v))

let print_cnf cnf =
  print_string "[";
  List.iter begin fun cls ->
    print_string "[";
    print_string (String.concat "; " (List.map string_of_int cls));
    print_string "];";
  end cnf;
  print_string "]"

let solve (f : cnf) =
  if dpll f then Sat f
  else Unsat f

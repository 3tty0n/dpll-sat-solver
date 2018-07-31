open Syntax

let print_cnf cnf =
  print_string "[";
  List.iter begin fun cls ->
    print_string "[";
    print_string (String.concat "; " (List.map string_of_int cls));
    print_string "];";
  end cnf;
  print_string "]"

let rec literal_of_lists' acc = function
  | [] -> []
  | EOL :: tl -> (List.rev acc) :: literal_of_lists' [] tl
  | (Literal (i)) :: tl -> literal_of_lists' (i :: acc) tl

let literal_of_lists lits =
  literal_of_lists' [] lits

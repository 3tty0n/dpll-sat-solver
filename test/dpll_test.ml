open Dpll
open Syntax
open Solver

let f1 = [
  [-1; 2];
  [1; -2];
]

let f2 = [
  [-1; 2; 3];
  [1; 2; 3];
  [-1; -2; 3];
  [-1; -2; -3]
]

let f4 = [
  [1; -2;];
  [-1; 2];
  [2; -3];
  [-3; -4];
]

let f5 = [
  [1; 2; -3];
  [1; -2];
  [-1];
  [3];
  [4]
]

let () =
  let cnfs = [f1; f2; f4; f5] in
  List.iter (fun cnf -> (match solve cnf with
      | Sat _ -> print_string "SAT: "
      | Unsat _ -> print_string "UNSAT: ");
      Cnf.print_cnf cnf; print_newline ()
    ) cnfs


let () =
  assert (
    Cnf.literal_of_lists
      [Literal (1); Literal (2); EOL; Literal (-1); Literal (2); EOL]
    = [[1; 2]; [-1; 2]])

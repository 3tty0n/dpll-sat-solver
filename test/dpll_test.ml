open OUnit2
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

let cnf_test1 _ =
  assert_equal (solve f1) (Sat f1);
  assert_equal (solve f2) (Sat f2);
  assert_equal (solve f4) (Sat f4);
  assert_equal (solve f5) (Unsat f5)

let cnf_test2 _ =
  assert_equal
    (Cnf.literal_of_lists
       [Literal (1); Literal (2); EOL; Literal (-1); Literal (2); EOL])
    [[1; 2]; [-1; 2]]

let suite =
  "suite" >:::
  ["test1" >:: cnf_test1;
   "test2" >:: cnf_test2;]

let () =
  run_test_tt_main suite

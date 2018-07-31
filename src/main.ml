open Dpll

let () =
  let ic = open_in (Sys.argv.(1)) in
  let start = Unix.gettimeofday () in
  try
    (match
      Lexing.from_channel ic
      |> Parser.program Lexer.token
      |> Cnf.literal_of_lists
      |> Solver.solve
     with
     | Solver.Sat _ ->
       print_string "Result: SAT "
     | Solver.Unsat _ -> print_string "Result: UNSAT ");
    let stop = Unix.gettimeofday () in
    Printf.printf "Execution time: %fs\n%!" (stop -. start);
    close_in ic;
  with _ -> close_in ic;

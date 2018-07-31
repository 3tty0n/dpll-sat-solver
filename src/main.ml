open Dpll

let () =
  let ic = open_in (Sys.argv.(1)) in
  try
    (match
      Lexing.from_channel ic
      |> Parser.program Lexer.token
      |> Cnf.literal_of_lists
      |> Solver.solve
     with
     | Solver.Sat _ -> print_endline "SAT"
     | Solver.Unsat _ -> print_endline "UNSAT");
    close_in ic;
  with _ -> close_in ic;

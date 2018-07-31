type literal =
  | Literal of int
  | EOL

let string_of_literal = function
  | Literal i -> Printf.sprintf "Literal (%d)" i
  | EOL -> "\n"

{
  (* This part is inserted into the head of the generated file. *)
}

let space = ['\t' '\n' '\r' ' ']
let literal_num = ['-' '1'-'9']

rule token = parse
| space+ { token lexbuf (* use recursion to ignore *) }
| literal_num+ as lexeme { Parser.LITERAL (int_of_string lexeme) }
| '0' { Parser.EOL }
| 'p' { line_comment lexbuf; token lexbuf }
| eof { Parser.EOF }

and line_comment = parse
| ('\n' | eof) { () }
| _ { line_comment lexbuf }

{
  (* This part is inserted into the end of the generated file. *)
}

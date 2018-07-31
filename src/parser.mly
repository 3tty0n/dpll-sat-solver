%{

%}

%token <int> LITERAL
%token EOL
%token COMMENT
%token EOF
%type <Syntax.literal list> program
%start program

%%

program:
| literal* EOF { $1 }

literal:
| LITERAL { Syntax.Literal ($1) }
| EOL { Syntax.EOL }

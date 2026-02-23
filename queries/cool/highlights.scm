; Identifiers

(identifier) @variable

(type_identifier) @type
(primitive_type) @type.builtin
(field_identifier) @property

; Constructors

(new_expression
  type: (type_identifier) @constructor)

; Method Definitions

(method_declaration
  name: (identifier) @function.method)

;; Method calls

(dispatch_expression
  method: (identifier) @function.method.call)
(dispatch_expression
  value: (identifier)
  method: (identifier) @function)

[
  "(" 
  ")" 
  "{" 
  "}" 
] @punctuation.bracket

[
  ":" 
  "." 
  "," 
  ";" 
] @punctuation.delimiter

(parameter (identifier) @variable.parameter)

; Keywords

[
  "class"
  "inherits"
  "let"
  "in"
  "if"
  "then"
  "else"
  "fi"
  "while"
  "loop"
  "pool"
  "case"
  "of"
  "esac"
  "new"
] @keyword

[
  "if"
  "then"
  "else"
  "fi"
] @conditional

[
  "while"
  "loop"
  "pool"
] @repeat

; Operators

[
  "=>"
  "="
  "<"
  "<="
  "*"
  "-"
  "+"
  "/"
  "@"
  "~"
  "<-"
] @operator

[
  "not"
  "isvoid"
] @keyword.operator

; Literals

(self) @variable.builtin

(boolean_literal) @boolean
(integer_literal) @number
(string_literal) @string

(escape_sequence) @escape

; Comments

[
  (inline_comment)
  (block_comment)
] @comment

; @indent.begin        indent children when matching this node
; @indent.end          marks the end of indented block
; @indent.align        behaves like python aligned/hanging indent
; @indent.dedent       dedent children when matching this node
; @indent.branch       dedent itself when matching this node
; @indent.ignore       do not indent in this node
; @indent.auto         behaves like 'autoindent' buffer option
; @indent.zero         sets this node at position 0 (no indent)


[
  (class_item)
  (method_declaration)
  (dispatch_expression)
  (assignment_expression)
  (let_expression)
  (while_expression)
  (case_expression)
  (case_arm)
  (block)
] @indent

[
  "("
  ")"
  "{"
  "}"
] @branch

[
  (inline_comment)
] @ignore

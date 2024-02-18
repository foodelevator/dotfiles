; extends
((
  [ (raw_string_literal)
    (interpreted_string_literal)
  ] @injection.content)
 (#match? @injection.content "[`\"]--sql\n")
 (#offset! @injection.content 0 6 0 -1)
 (#set! injection.language "sql"))

((
  [ (raw_string_literal)
    (interpreted_string_literal)
  ] @injection.content)
 (#match? @injection.content "[`\"]/\\*sql\\*/")
 (#offset! @injection.content 0 8 0 -1)
 (#set! injection.language "sql"))

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local function get_visual(_, parent)
  local sel = parent.snippet.env.LS_SELECT_DEDENT
  if sel and #sel > 0 then
    return sn(nil, t(sel))
  end
  return sn(nil, i(1))
end

return {
  s("if", fmt([[
if ({}) {{
  {}
}}]], { i(1, "cond"), d(2, get_visual) })),

  s("for", fmt([[
for ({}) {{
  {}
}}]], { i(1, "let i = 0; i < n; i++"), d(2, get_visual) })),

  s("while", fmt([[
while ({}) {{
  {}
}}]], { i(1, "cond"), d(2, get_visual) })),

  s("try", fmt([[
try {{
  {}
}} catch ({}) {{
  {}
}}]], { d(1, get_visual), i(2, "err"), i(3, "// handle") })),

  s("fn", fmt([[
function {}({}) {{
  {}
}}]], { i(1, "name"), i(2, "args"), d(3, get_visual) })),
}

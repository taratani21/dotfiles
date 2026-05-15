local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

-- Insert the stored visual selection (dedented), or fall back to a plain insert node.
local function get_visual(_, parent)
  local sel = parent.snippet.env.LS_SELECT_DEDENT
  if sel and #sel > 0 then
    return sn(nil, t(sel))
  end
  return sn(nil, i(1))
end

return {
  s("wb", fmt("{{ {} }}", { d(1, get_visual) })),
  s("wp", fmt("({})",     { d(1, get_visual) })),
  s("wB", fmt("[{}]",     { d(1, get_visual) })),
}

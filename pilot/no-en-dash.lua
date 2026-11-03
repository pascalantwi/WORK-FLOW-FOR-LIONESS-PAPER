-- Run citeproc here, then replace en and em dashes with hyphens, so that the
-- page ranges of the reference list follow the workflow's no-dash rule.
-- The document sets `citeproc: false`, so citeproc runs only in this filter.
local function nodash(el)
  local s = el.text:gsub("\u{2013}", "-"):gsub("\u{2014}", "-")
  if s ~= el.text then return pandoc.Str(s) end
end

function Pandoc(doc)
  doc = pandoc.utils.citeproc(doc)
  return doc:walk({ Str = nodash })
end

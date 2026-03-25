-- Detect actual bibliography citations and set has-citations metadata.
-- Excludes Quarto cross-references (fig-, tbl-, lst-, sec-, eq-, thm-, etc.)

local crossref_prefixes = {
  "fig-", "tbl-", "lst-", "sec-", "eq-", "thm-", "lem-", "cor-", "prp-",
  "cnj-", "def-", "exm-", "exr-", "sol-", "rem-", "vid-",
}

local function is_crossref(id)
  for _, prefix in ipairs(crossref_prefixes) do
    if id:sub(1, #prefix) == prefix then
      return true
    end
  end
  return false
end

function Pandoc(doc)
  local found = false
  doc:walk({
    Cite = function(el)
      for _, c in ipairs(el.citations) do
        if not is_crossref(c.id) then
          found = true
        end
      end
    end
  })
  if not found then
    doc.meta["has-citations"] = nil
  else
    doc.meta["has-citations"] = true
  end
  return doc
end

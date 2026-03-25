-- Populate git-version metadata from the repository.
-- Uses `git describe --tags --always` relative to the document's directory.
-- Runs on every document; use {{< meta git-version >}} to reference the value.

function Meta(meta)
  local dir = "."
  if quarto and quarto.doc and quarto.doc.input_file then
    dir = quarto.doc.input_file:match("^(.*)/[^/]*$") or "."
  end
  local safe_dir = dir:gsub("'", "'\\''")
  local handle = io.popen("git -C '" .. safe_dir .. "' describe --tags --always 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  result = result:gsub("%s+$", "")
  meta["git-version"] = result ~= "" and result or "unknown"
  return meta
end

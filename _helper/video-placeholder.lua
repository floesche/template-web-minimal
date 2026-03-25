-- Replace video files with a placeholder in typst output
local video_extensions = {
  [".mp4"] = true,
  [".mov"] = true,
  [".avi"] = true,
  [".webm"] = true,
  [".mkv"] = true,
  [".ogv"] = true,
}

local function is_video(src)
  local ext = src:match("(%.[^%.]+)$")
  return ext and video_extensions[ext:lower()]
end

function Image(el)
  if not quarto.doc.is_format("typst") then
    return nil
  end
  if is_video(el.src) then
    local caption = pandoc.utils.stringify(el.caption)
    if caption == "" then
      caption = "Video (see HTML version)"
    else
      caption = caption .. " (see HTML version)"
    end
    return pandoc.Str(caption)
  end
end

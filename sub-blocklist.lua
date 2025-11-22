-- Blacklist subtitles by matching words in their title (case-insensitive, partial match)
-- Example: to block subtitles with "Song", "SoNgS" or "Signs & Songs" in the title, just add "song" to the blacklist

local blacklist = { "sign", "song", "dub" }

mp.register_event("file-loaded", function()
    for _, t in ipairs(mp.get_property_native("track-list")) do
        if t.type == "sub" then
            local name = (t.title or ""):lower()
            for _, w in ipairs(blacklist) do if name:match(w) then name=nil break end end
            if name then mp.set_property("sid", t.id); return end
        end
    end
end)

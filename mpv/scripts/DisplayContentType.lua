
local function get_content_type()
    local track_list = mp.get_property_native("track-list")
    local file_type = ""
    for _, track in ipairs(track_list) do        
        if track.type == "audio" then file_type = "audio"
        elseif not track.albumart and (track["demux-fps"] or 2) > 1 then
            file_type = "video" 
        elseif track.type == "video" and not track.albumart and track["demux-fps"] == 1 then
            file_type = "picture"
        end
    end
    return file_type
end

function print_file_name()
    print("Media type: " .. get_content_type())
end
mp.register_event("file-loaded", print_file_name)

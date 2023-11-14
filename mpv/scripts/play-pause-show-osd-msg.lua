local ov = mp.create_osd_overlay('ass-events')
ov.data = "{\\an9}{\\b1}" .. "Paused"

mp.observe_property('pause', 'bool', function(_, paused)
    mp.add_timeout(0.1, function()
        if paused then ov:update()
        else ov:remove() end
    end)
end)

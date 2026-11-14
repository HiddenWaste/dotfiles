-- 1. Primary Displays: Built-in laptop panels (eDP) & DisplayPort (DP)
-- Anchors to 0x0 so it is always on the left, and claims Workspace 1
for i = 1, 4 do
    for _, prefix in ipairs({ "eDP-", "DP-" }) do
        local port = prefix .. i

        hl.monitor({
            output   = port,
            mode     = "preferred",
            position = "0x0",
            scale    = "auto",
        })

        hl.workspace_rule({
            workspace = "1",
            monitor   = port,
            default   = true,
        })
    end
end

-- 2. Secondary Displays: HDMI monitors / TVs
-- "auto-right" dynamically places this to the right of 0x0 regardless of primary resolution
for i = 1, 4 do
    hl.monitor({
        output   = "HDMI-A-" .. i,
        mode     = "preferred",
        position = "auto-right",
        scale    = "auto",
    })
end

-- 3. Fallback Rule: Any other dock, USB-C, or virtual display goes to the right
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto-right",
    scale    = "auto",
})

-- 4. Force initial mouse cursor & focus onto Workspace 1 (your primary display) on login
hl.on("hyprland.start", function()
    hl.dispatch(hl.dsp.focus({ workspace = 1 }))
end)

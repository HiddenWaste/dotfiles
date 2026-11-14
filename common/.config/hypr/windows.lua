-- Windows And Workspaces!!

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like th
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name = "keep-pip-opaque",
    match = {
        title = "^(Picture-in-Picture|Picture in Picture)$",
    },
    -- matches both standard title formats (hyphens or spaces)
    opaque = true
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- Universal rule for all TUI pop-up applets
hl.window_rule({
    name = "tui-applets-base",
    match = {
        class = "^tui-.*",
    },
    float = true,
    center = true,
    size = { 850, 550 },
    dim_around = true,        -- Dims the background slightly like a modal applet
    stay_focused = true,      -- Keeps focus locked until you quit the TUI
    animation = "popin 80%",
})

-- Optional: Larger size override specifically for btop
hl.window_rule({
    name = "tui-btop-size",
    match = {
        class = "^tui-monitor$",
    },
    size = { 1200, 750 },
})

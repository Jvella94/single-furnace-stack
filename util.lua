function make_layered_icon(primary_icon, secondary_icon)
    return {{
        icon = primary_icon
    }, {
        icon = secondary_icon,
        scale = 0.25,
        shift = {-8, -8}
    }}
end

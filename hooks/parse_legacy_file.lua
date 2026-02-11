local util = require("util")

function PLUGIN:ParseLegacyFile(ctx)
    local file = io.open(ctx.filepath, "r")
    if not file then
        return {}
    end

    local content = file:read("*a")
    file:close()

    content = content:gsub("^%s+", ""):gsub("%s+$", "")
    if content == "" then
        return {}
    end

    local version = content:match("leanprover/lean4:v(.+)")
        or content:match("leanprover/lean4:(.+)")
        or content:match("^v(.+)")
        or content

    return {
        version = version,
    }
end

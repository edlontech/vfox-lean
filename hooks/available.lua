local http = require("http")
local json = require("json")
local util = require("util")

function PLUGIN:Available(ctx)
    local resp, err = http.get({
        url = util.ReleaseIndexURL,
    })
    if err ~= nil or resp.status_code ~= 200 then
        error("Failed to fetch Lean releases: " .. (err or ("HTTP " .. resp.status_code)))
    end

    local releases = json.decode(resp.body)
    local result = {}

    for _, entry in ipairs(releases.stable or {}) do
        table.insert(result, {
            version = util.strip_v_prefix(entry.name),
            note = "stable",
        })
    end

    for _, entry in ipairs(releases.beta or {}) do
        table.insert(result, {
            version = util.strip_v_prefix(entry.name),
            note = "rc",
        })
    end

    return result
end

local http = require("http")
local json = require("json")
local util = require("util")

function PLUGIN:PreInstall(ctx)
    local version = util.strip_v_prefix(ctx.version)
    local platform = util.get_platform()

    local resp, err = http.get({
        url = util.ReleaseIndexURL,
    })
    if err ~= nil or resp.status_code ~= 200 then
        error("Failed to fetch Lean releases: " .. (err or ("HTTP " .. resp.status_code)))
    end

    local releases = json.decode(resp.body)
    local all_releases = {}
    for _, entry in ipairs(releases.stable or {}) do
        table.insert(all_releases, entry)
    end
    for _, entry in ipairs(releases.beta or {}) do
        table.insert(all_releases, entry)
    end

    if version == "latest" then
        if #(releases.stable or {}) > 0 then
            version = util.strip_v_prefix(releases.stable[1].name)
        else
            error("No stable Lean releases found")
        end
    end

    local expected_asset = util.get_asset_name(version, platform)

    for _, entry in ipairs(all_releases) do
        local entry_version = util.strip_v_prefix(entry.name)
        if entry_version == version then
            for _, asset in ipairs(entry.assets or {}) do
                if asset.name == expected_asset then
                    return {
                        version = version,
                        url = asset.browser_download_url,
                    }
                end
            end
            error("No .zip asset found for platform " .. platform .. " in version " .. version)
        end
    end

    error("Version " .. version .. " not found in Lean releases")
end

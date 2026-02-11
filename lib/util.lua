local util = {}

util.ReleaseIndexURL = "https://release.lean-lang.org"

local platform_map = {
    darwin_amd64 = "darwin",
    darwin_arm64 = "darwin_aarch64",
    linux_amd64 = "linux",
    linux_arm64 = "linux_aarch64",
    windows_amd64 = "windows",
}

function util.get_platform()
    local key = RUNTIME.osType .. "_" .. RUNTIME.archType
    local platform = platform_map[key]
    if not platform then
        error("Unsupported platform: " .. RUNTIME.osType .. "/" .. RUNTIME.archType)
    end
    return platform
end

function util.get_asset_name(version, platform)
    return "lean-" .. version .. "-" .. platform .. ".zip"
end

function util.strip_v_prefix(version)
    if version:sub(1, 1) == "v" then
        return version:sub(2)
    end
    return version
end

return util

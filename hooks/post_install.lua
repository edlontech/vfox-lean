local util = require("util")

function PLUGIN:PostInstall(ctx)
    local sdkInfo = ctx.sdkInfo["lean"]
    local path = sdkInfo.path
    local version = sdkInfo.version
    local platform = util.get_platform()
    local subdir = path .. "/lean-" .. version .. "-" .. platform

    if RUNTIME.osType == "windows" then
        os.execute('xcopy "' .. subdir .. '\\*" "' .. path .. '" /E /Y /Q >nul 2>&1')
        os.execute('rmdir "' .. subdir .. '" /S /Q >nul 2>&1')
    else
        os.execute("mv " .. subdir .. "/* " .. path .. "/ 2>/dev/null")
        os.execute("mv " .. subdir .. "/.* " .. path .. "/ 2>/dev/null")
        os.execute("rm -rf '" .. subdir .. "'")
    end
end

local util = require("util")

local LEAN_BINS = { "lean", "lake", "leanc", "leanmake" }

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

    create_shims(path)
end

function create_shims(path)
    local shimDir = path .. "/shims"

    if RUNTIME.osType == "windows" then
        os.execute('mkdir "' .. shimDir .. '" >nul 2>&1')
        for _, bin in ipairs(LEAN_BINS) do
            local src = path .. "\\bin\\" .. bin .. ".exe"
            local dst = shimDir .. "\\" .. bin .. ".exe"
            os.execute('if exist "' .. src .. '" mklink /H "' .. dst .. '" "' .. src .. '" >nul 2>&1')
        end
    else
        os.execute("mkdir -p '" .. shimDir .. "'")
        for _, bin in ipairs(LEAN_BINS) do
            local src = path .. "/bin/" .. bin
            local dst = shimDir .. "/" .. bin
            os.execute("test -f '" .. src .. "' && ln -sf '" .. src .. "' '" .. dst .. "'")
        end
    end
end

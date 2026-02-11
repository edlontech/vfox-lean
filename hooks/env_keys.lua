function PLUGIN:EnvKeys(ctx)
    local mainPath = ctx.path
    return {
        {
            key = "PATH",
            value = mainPath .. "/shims",
        },
        {
            key = "LEAN_HOME",
            value = mainPath,
        },
    }
end

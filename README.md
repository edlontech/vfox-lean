# vfox-lean

[vfox](https://github.com/version-fox/vfox) plugin for [Lean 4](https://lean-lang.org/) theorem prover and programming language.

## Install

### Using mise

[mise](https://mise.jdx.dev/) supports vfox plugins as a [backend](https://mise.jdx.dev/dev-tools/backends/vfox.html).

Install the latest version globally:

```bash
mise use -g vfox:edlontech/vfox-lean
```

Install a specific version in the current project:

```bash
mise use vfox:edlontech/vfox-lean@4.27.0
```

This records the version in your `mise.toml`:

```toml
[tools]
"vfox:edlontech/vfox-lean" = "4.27.0"
```

### Using vfox directly

```bash
vfox add lean
vfox install lean@4.27.0
vfox use lean@4.27.0
```

## Legacy file support

This plugin reads `lean-toolchain` files, the same format used by [elan](https://github.com/leanprover/elan). All of these formats are supported:

```
leanprover/lean4:v4.27.0
leanprover/lean4:4.27.0
v4.27.0
4.27.0
```

With mise, place a `lean-toolchain` file in your project and it will be picked up automatically.

## Environment variables

The plugin sets the following environment variables:

| Variable | Value |
|----------|-------|
| `PATH` | `<install-dir>/shims` is prepended |
| `LEAN_HOME` | Set to the installation directory |

## Platform support

| OS | x86_64 | aarch64 |
|----|--------|---------|
| Linux | yes | yes |
| macOS | yes | yes |
| Windows | yes | no |

## License

Apache-2.0

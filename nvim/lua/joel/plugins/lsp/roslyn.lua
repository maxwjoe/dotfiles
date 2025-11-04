-- File : roslyn.lua
-- Description : Modern C# LSP (Not supported in Mason by default)

return {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
        filewatching = "roslyn"
    }
}

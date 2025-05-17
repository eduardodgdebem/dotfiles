return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "templ",
        "zig",
        "c_sharp",
        "angular",
        "scss",
        "java",
        "go",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  -- Import Java configuration
  { import = "plugins.lsp.java" },
}

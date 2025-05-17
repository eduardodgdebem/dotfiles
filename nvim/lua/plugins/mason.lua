return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "java-debug-adapter", "java-test", "tailwindcss-language-server" } },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {},
  },
}

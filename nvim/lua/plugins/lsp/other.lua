return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers = vim.tbl_deep_extend("force", opts.servers, {
        zls = {},
        omnisharp = {
          cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
          enable_editorconfig_support = true,
          enable_ms_build_load_projects_on_demand = false,
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
          sdk_include_prereleases = true,
          analyze_open_documents_only = true,
        },
        angularls = {},
        tsserver = {
          enabled = false,
        },
        ts_ls = {
          enabled = false,
        },
        jdtls = {},
      })
      opts.setup = opts.setup or {}
      opts.setup = vim.tbl_deep_extend("force", opts.setup, {
        angularls = function()
          LazyVim.lsp.on_attach(function(client)
            client.server_capabilities.renameProvider = false
          end, "angularls")
        end,
        tsserver = function()
          return true
        end,
        ts_ls = function()
          return true
        end,
        jdtls = function()
          return true -- avoid duplicate servers
        end,
      })
    end,
  },
} 
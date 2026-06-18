-- lua/plugins/lsp.lua
return {
  -- LSP base
  {
    "neovim/nvim-lspconfig",
    -- starts the lsp for new or already existing files
    event = {"BufReadPre", "BufNewFile"},
    config = function()

      -- Capacidades para integrar com nvim-cmp (se instalado)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then capabilities = cmp_lsp.default_capabilities(capabilities) end

      -- clangd
     -- vim.api.nvim_create_autocmd("BufWritePre", {
      --    buffer = bufnr,
       --   callback = function()
        --    vim.lsp.buf.format({ async = false })
         -- end,
       -- })
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",
              extraPaths = {
                    "/home/ielson/docker/conda/.local/share/mamba/envs/deploy19-env/lib/python3.10/site-packages",
                    "/home/ielson/code/ros2/ws/install/controller_manager_msgs/lib/python3.12/site-packages",
                  },
            },
          },
        },
      })
      vim.lsp.enable("basedpyright")

      vim.lsp.config("clangd", {
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        -- Se seu compile_commands.json fica em build/:
        -- cmd = { "clangd", "--background-index", "--clang-tidy", "--compile-commands-dir=build" },
      })
      vim.lsp.enable("clangd")

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {globals = {"vim"}}, 
            workspace = {checkThirdParty = false},
          },
        },
      })
    vim.lsp.enable("lua_ls")

    vim.lsp.config("omnisharp", {
     capabilities= capabilities,
     -- cmd = {},
    })
    vim.lsp.enable("omnisharp")


    vim.lsp.config("solargraph", {
  capabilities = capabilities,

  cmd = { "solargraph", "stdio" },

  filetypes = { "ruby", "eruby" },

  root_markers = {
    "Gemfile",
    ".solargraph.yml",
    ".git",
    ".autoproj",
  },

  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
    },
  },
})

vim.lsp.enable("solargraph")
    end,
  }
}

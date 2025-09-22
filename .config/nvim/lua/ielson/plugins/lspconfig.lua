-- lua/plugins/lsp.lua
return {
  -- LSP base
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
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
            -- a PASTA onde ficam os envs do mamba/conda:
            venvPath = "/home/ielson/docker/conda/.local/share/mamba/envs",
            -- o NOME do env:
            venv = "deploy19-env",
            pythonVersion = "3.10",
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",
              extraPaths = {
                    "/home/ielson/docker/conda/.local/share/mamba/envs/deploy19-env/lib/python3.10/site-packages",
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
    end,
  }
}

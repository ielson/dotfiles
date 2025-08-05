-- lua/plugins/lsp.lua
return {
  -- LSP base
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = function()
      local lspconfig = require("lspconfig")

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

      lspconfig.clangd.setup{
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        -- Se seu compile_commands.json fica em build/:
        -- cmd = { "clangd", "--background-index", "--clang-tidy", "--compile-commands-dir=build" },
      }
    end,
  }
}

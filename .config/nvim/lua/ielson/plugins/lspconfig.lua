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

      -- Keymaps LSP básicos
      local map = vim.keymap.set
      map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
      map("n", "K",  vim.lsp.buf.hover,      { desc = "LSP: Hover" })
      map("n", "gr", vim.lsp.buf.references, { desc = "LSP: References" })
      map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })

      -- clangd
      lspconfig.clangd.setup{
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        -- Se seu compile_commands.json fica em build/:
        -- cmd = { "clangd", "--background-index", "--clang-tidy", "--compile-commands-dir=build" },
      }
    end,
  }
}

-- leader usado para comandos globais
vim.g.mapleader = " "

-- keymaps, seguem o seguinte: modo, atalho, ação, tabela de opções
local map = vim.keymap.set

-- mostrar diagnóstico em float
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Mostrar erro/warning" })

-- ir para próximo/previo
-- map("n", "]d", vim.diagnostic.goto_next,   { desc = "Próximo diagnóstico" })
-- map("n", "[d", vim.diagnostic.goto_prev,   { desc = "Diagnóstico anterior" })
-- enviar para loclist e abrir

map("n", "<leader>E", function()
  vim.diagnostic.setloclist()
  vim.cmd("lopen")
end, { desc = "Lista de diagnósticos" })

-- os <CMD> representam a gente ter apertado : para entrar na linha de comando
-- só salva se o arquivo tiver alteração, ao contrário do :w
map("n", "<leader>w", "<CMD>update<CR>")

-- quit
map("n", "<leader>q", "<CMD>q<CR>")

-- clangd
-- Atalho manual para formatar com o clang-format
map("n", "<leader>F", function()
  vim.lsp.buf.format({ async = true, buffer = true})
end, { desc = "LSP: Format buffer" })


-- nao funcionando, preciso arrumar
vim.keymap.set("v", "<leader>f", function()
  -- pega linha e coluna de início e fim da seleção visual
  local start_line = vim.fn.line("'<") + 1
  local start_col  = vim.fn.col("'<")  + 1
  local end_line   = vim.fn.line("'>") + 1
  local end_col    = vim.fn.col("'>")  + 1

  vim.lsp.buf.format({
    range = {
      start = { start_line, start_col },
      ["end"] = { end_line,   end_col   },
    },
  })
end, { desc = "LSP: format selection" })

map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
map("n", "K",  vim.lsp.buf.hover,      { desc = "LSP: Hover" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP: References" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code Action" })


-- mapeamentos para comandos FZF
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>l', ':Lines<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>L', ':BLines<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>h', ':History<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>c', ':Commits<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>C', ':BCommits<CR>', opts)


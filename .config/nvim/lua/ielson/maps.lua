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

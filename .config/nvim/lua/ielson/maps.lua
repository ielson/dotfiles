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

-- map("n", "<leader>E", function()
--   vim.diagnostic.setloclist()
--   vim.cmd("lopen")
-- end, { desc = "Lista de diagnósticos" })

-- os <CMD> representam a gente ter apertado : para entrar na linha de comando
-- só salva se o arquivo tiver alteração, ao contrário do :w
map("n", "<leader>w", "<CMD>update<CR>")

-- quit
map("n", "<leader>q", "<CMD>q<CR>")

-- clangd
-- atalho manual para formatar com o clang-format
-- map("n", "<leader>f", function()
--   vim.lsp.buf.format({ async = true, buffer = true})
-- end, { desc = "lsp: format buffer" })


-- nao funcionando, preciso arrumar
-- vim.keymap.set("v", "<leader>f", function()
--   -- pega linha e coluna de início e fim da seleção visual
--   local start_line = vim.fn.line("'<") + 1
--   local start_col  = vim.fn.col("'<")  + 1
--   local end_line   = vim.fn.line("'>") + 1
--   local end_col    = vim.fn.col("'>")  + 1
--
--   vim.lsp.buf.format({
--     range = {
--       start = { start_line, start_col },
--       ["end"] = { end_line,   end_col   },
--     },
--   })
-- end, { desc = "lsp: format selection" })

map("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Go to Definition" })
map("n", "K",  vim.lsp.buf.hover,      { desc = "LSP: Hover" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP: References" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: Rename" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: code Action" })


-- mapeamentos para comandos fzf
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rg', ':Rg<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>l', ':Lines<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>L', ':BLines<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>h', ':History<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>c', ':Commits<CR>', opts)
--vim.api.nvim_set_keymap('n', '<leader>C', ':BCommits<CR>', opts)


-- mapeamentos para o gitsigns
-- se estiver no modo de diff, usa o padrao do vim, se nao, chama git singgs
-- c vem de change
map('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal({']c', bang = true})
  else
    require('gitsigns').nav_hunk('next')
  end
end)

map('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal({'[c', bang = true})
  else
    require('gitsigns').nav_hunk('prev')
  end
end)

-- actions
map('n', '<leader>hs', function() require('gitsigns').stage_hunk() end)
map('n', '<leader>hr', function() require('gitsigns').reset_hunk() end)
map('n', '<leader>hp', function() require('gitsigns').preview_hunk_inline() end)

-- diffview toggle
local function toggle_diffview(cmd)
  local ok, lib = pcall(require, "diffview.lib")

  if ok and lib.get_current_view() then
    vim.cmd("DiffviewClose")
  else
    vim.cmd(cmd or "DiffviewOpen")
  end
end

map("n", "<leader>dl", function()
  toggle_diffview("DiffviewOpen")
end, { desc = "Toggle Diffview" })

map("n", "<leader>dc", function()
  toggle_diffview("DiffviewOpen HEAD^!")
end, { desc = "Toggle PR/current commit diff" })

map("n", "<leader>db", function()
  local base = vim.fn.input("Base branch: ", "master")
  if base ~= "" then
    toggle_diffview("DiffviewOpen " .. base .. "...HEAD")
  end
end, { desc = "Toggle branch diff" })

-- toggleterm 
local map = vim.keymap.set

map("n", "<leader>tt", "<cmd>1ToggleTerm direction=float<CR>", {
  desc = "terminal",
})

map("n", "<leader>th", "<cmd>1ToggleTerm size=15 direction=horizontal<CR>", {
  desc = "terminal horizontal",
})

map("n", "<leader>tv", "<cmd>1ToggleTerm size=80 direction=vertical<CR>", {
  desc = "terminal vertical",
})

-- map("n", "<leader>tg", [[<cmd>2termexec cmd="lazygit" direction=float<cr>]], {
--   desc = "lazygit",
-- })

map("n", "<leader>tgn", [[<cmd>3TermExec cmd="gemini" direction=float<CR>]], {
  desc = "gemini",
})

map("n", "<leader>tgr", [[<cmd>3TermExec cmd="gemini --resume latest" direction=float<CR>]], {
  desc = "gemini resume latest",
})

map("t", "<Esc><Esc>", [[<C-\><C-n><cmd>ToggleTerm<CR>]], {
  desc = "toggle terminal",
})

-- ruby/rubocop linter functions
local function rubocop_current_file(args)
  local file = vim.fn.expand("%:p")

  if file == "" then
    vim.notify("No file to run RuboCop on", vim.log.levels.WARN)
    return
  end

  if vim.bo.filetype ~= "ruby" and vim.bo.filetype ~= "eruby" then
    vim.notify("Current file is not a Ruby file", vim.log.levels.WARN)
    return
  end

  -- Salva antes de rodar o RuboCop
  vim.cmd("write")

  local escaped_file = vim.fn.shellescape(file)

  -- Usa o RuboCop do projeto, se houver Bundler/Gemfile
  local command = "bundle exec rubocop " .. args .. " " .. escaped_file

  vim.cmd("!" .. command)
end

map("n", "<leader>rl", function()
  rubocop_current_file("")
end, { desc = "Ruby: lint current file with RuboCop" })

map("n", "<leader>ra", function()
  rubocop_current_file("-a")
  vim.cmd("edit")
end, { desc = "Ruby: autocorrect current file with RuboCop" })

-- octo.nvim commands (github review)
map("n", "<leader>oi", "<cmd>Octo issue list<cr>", {
    desc = "List GitHub issues", 
})

map("n", "<leader>op", "<cmd>Octo pr list<cr>", {
    desc = "List GitHub issues", 
})

map("n", "<leader>od", "<cmd>Octo discussion list<cr>", {
    desc = "List GitHub issues", 
})

map("n", "<leader>os", function()
  require("octo.utils").create_base_search_command({
    include_current_repo = true,
  })
end, {
  desc = "Search GitHub",
})

map("n", "<leader>on", "<cmd>Octo notification list<cr>", {
  desc = "List GitHub Notifications",
})

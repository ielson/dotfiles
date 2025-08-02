local global = vim.g
local o = vim.opt

-- Editor options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
-- Habilita suporte a cores verdadeiras no terminal
vim.opt.termguicolors = true
-- Converte TABs em espaços
vim.opt.expandtab = true
-- Define quantos espaços o Vim usa ao “shiftar” (>> ou autoindent)
vim.opt.shiftwidth = 2
-- Define quantos espaços um caractere de tab equivale
vim.opt.tabstop = 2
-- ignora maiúsculas/minúsculas por padrão
vim.opt.ignorecase = true   
-- MAS se houver maiúscula no padrão, faz busca case-sensitive
vim.opt.smartcase = true    
-- mostra o resultado da busca conforme você digita
vim.opt.incsearch = true   
vim.opt.cursorline = true

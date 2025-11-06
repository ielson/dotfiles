return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<F5>',  function() require('dap').continue() end,    desc = 'DAP: Iniciar/Continuar' },
    },
    config = function()
      local dap = require('dap')
      -- Adapter para codelldb (deve estar no PATH ou instalado pelo usuário)
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = { command = 'codelldb', args = {'--port', '${port}'} },
      }
      -- Configuração de lançamento para C/C++
      dap.configurations.cpp = {
        {
          name = 'Debug executable',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to exe: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        }
      }
      dap.configurations.c = dap.configurations.cpp
    end,
  },
}

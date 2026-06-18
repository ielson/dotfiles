return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      picker = "fzf-lua",
      enable_builtin = true,

      default_remote = {
        "tidewise.seabots",
        "autobuild",
        "upstream",
        "origin",
      },

      ssh_aliases = {
        ["github%.com:"] = "github.com",
      },

      mappings = {
        notification = {
          read = { lhs = "<C-r>", desc = "mark notification as read" },
          done = { lhs = "<C-d>", desc = "mark notification as done" },
          unsubscribe = { lhs = "<C-u>", desc = "unsubscribe from notifications" },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
    },
  },
}

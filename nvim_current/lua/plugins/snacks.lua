return {
  {
    "folke/snacks.nvim",
    opts = {
      -- This is the crucial part for the explorer
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = {
                position = "right", -- This line moves the explorer to the right
              },
            },
            -- You can add other explorer options here if needed,
            -- such as follow_file, tree, focus, jump, etc.
            -- For example:
            -- follow_file = true,
            -- tree = true,
            -- focus = "list",
            -- jump = { close = false },
          },
        },
      },
      -- Other snacks configurations can go here
      -- explorer = {
      --   replace_netrw = true,
      -- },
    },
  },
}

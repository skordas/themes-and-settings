-- https://github.com/nvim-zh/colorful-winsep.nvim
return {
  {
    "nvim-zh/colorful-winsep.nvim",
    event = { "WinLeave" },
    config = function()
      -- This function runs when the plugin is loaded
      require("colorful-winsep").setup({
        -- highlight for Window separator
        -- hi = {
        --   bg = "#1A1D23",
        --   fg = "#B0B394",
        -- },
        symbols = { "─", "│", "╭", "╮", "╰", "╯" },
        -- Smooth moving switch
        smooth = true,
        exponential_smoothing = true,
      })
    end,
  },
}

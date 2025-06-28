return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", "/home/skordas/.config/nvim/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}

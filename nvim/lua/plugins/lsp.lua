return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportUnusedExpression = "none",
                },
              },
            },
          },
        },
      },
    },
  },
}

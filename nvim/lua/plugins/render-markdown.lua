return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "Avante" },
  opts = {
    latex = {
      -- Disabled: shows both original and rendered (use nabla.nvim instead for math)
      enabled = false,
    },
    heading = {
      enabled = true,
      sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    code = {
      enabled = true,
      sign = true,
      style = "full",
      width = "full",
      left_pad = 2,
      right_pad = 2,
    },
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
    },
    -- Ensure conceallevel is set properly
    win_options = {
      conceallevel = { rendered = 2 },
      concealcursor = { rendered = "nc" },
    },
  },
  keys = {
    {
      "<leader>mr",
      function()
        require("render-markdown").toggle()
      end,
      desc = "Toggle render-markdown",
    },
  },
}

return {
  "jbyuki/nabla.nvim",
  ft = { "markdown", "tex", "latex" },
  keys = {
    {
      "<leader>lp",
      function()
        require("nabla").popup()
      end,
      desc = "Preview LaTeX equation",
    },
    {
      "<leader>lt",
      function()
        local nabla = require("nabla")
        if nabla.is_virt_enabled() then
          nabla.disable_virt()
          -- Workaround for Issue #83: manually restore wrap
          vim.wo.wrap = true
          vim.notify("LaTeX virtual text disabled", vim.log.levels.INFO)
        else
          nabla.enable_virt({
            autogen = true, -- Auto-regenerate on insert mode exit
            silent = true, -- Suppress error messages
          })
          vim.notify("LaTeX virtual text enabled (use $ $ not $$ $$)", vim.log.levels.INFO)
        end
      end,
      desc = "Toggle LaTeX virtual text",
    },
    {
      "<leader>le",
      function()
        require("nabla").enable_virt({
          autogen = true,
          silent = true,
        })
        vim.notify("LaTeX virtual text enabled", vim.log.levels.INFO)
      end,
      desc = "Enable LaTeX virtual text",
    },
    {
      "<leader>ld",
      function()
        require("nabla").disable_virt()
        vim.wo.wrap = true -- Restore wrap
        vim.notify("LaTeX virtual text disabled", vim.log.levels.INFO)
      end,
      desc = "Disable LaTeX virtual text",
    },
  },
  config = function()
    -- Note: Only inline syntax $ .. $ works with enable_virt()
    -- Display mode $$ .. $$ will cause errors - use popup instead
  end,
}

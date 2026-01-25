return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    lazy = false,
    dependencies = {
      "3rd/image.nvim",
      "chrisgrieser/nvim-various-textobjs",
    },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_auto_init_behavior = "init"
      vim.g.molten_enter_output_behavior = "open_and_enter"
      vim.g.molten_auto_image_popup = false
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_crop_border = false
      vim.g.molten_output_virt_lines = true
      vim.g.molten_output_win_max_height = 50
      vim.g.molten_output_win_style = "minimal"
      vim.g.molten_output_win_hide_on_leave = false
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_max_lines = 10000
      vim.g.molten_cover_empty_lines = false
      vim.g.molten_copy_output = true
      vim.g.molten_output_show_exec_time = false

      -- Helper: jump to next non-empty line
      local function jump_to_next_code_line(start_line)
        local last = vim.fn.line("$")
        local next_line = start_line + 1

        while next_line <= last do
          local line_content = vim.fn.getline(next_line)
          if line_content:match("%S") then -- has non-whitespace character
            break
          end
          next_line = next_line + 1
        end

        if next_line <= last then
          vim.api.nvim_win_set_cursor(0, { next_line, 0 })
        end
      end

      -- Store helper in global for use in keys table
      _G.MoltenJumpToNextCode = jump_to_next_code_line
    end,
    keys = {
      -- Kernel management
      { "<leader>ji", "<cmd>MoltenInit<CR>", desc = "Init kernel" },
      { "<leader>jx", "<cmd>MoltenInterrupt<CR>", desc = "Interrupt kernel" },
      { "<leader>jd", "<cmd>MoltenDelete<CR>", desc = "Delete cell" },
      { "<leader>jI", "<cmd>MoltenInfo<CR>", desc = "Molten info" },

      -- Execution (with jump to next non-empty line)
      {
        "<leader>jj",
        function()
          local current_line = vim.fn.line(".")
          vim.cmd("MoltenEvaluateLine")
          vim.schedule(function()
            _G.MoltenJumpToNextCode(current_line)
          end)
        end,
        desc = "Evaluate line and move to next code",
      },
      {
        "<leader>jj",
        function()
          local end_line = vim.fn.line("'>")
          vim.cmd("MoltenEvaluateVisual")
          vim.schedule(function()
            _G.MoltenJumpToNextCode(end_line)
          end)
        end,
        mode = "x",
        desc = "Evaluate selection and move to next code",
      },
      { "<leader>jr", "<cmd>MoltenReevaluateAll<CR>", desc = "Re-evaluate all" },
      {
        "<leader>jb",
        function()
          local ft = vim.bo.filetype
          if ft == "markdown" then
            require("various-textobjs").mdFencedCodeBlock("inner")
            vim.cmd("MoltenEvaluateOperator")
          else
            require("various-textobjs").indentation("outer", "outer")
            vim.cmd("MoltenEvaluateOperator")
          end
        end,
        desc = "Evaluate block",
      },

      -- Navigation
      { "<leader>jn", "<cmd>MoltenNext<CR>", desc = "Next cell" },
      { "<leader>jp", "<cmd>MoltenPrev<CR>", desc = "Prev cell" },

      -- Output
      { "<leader>jo", "<cmd>noautocmd MoltenEnterOutput<CR>", desc = "Open/enter output" },
      { "<leader>jh", "<cmd>MoltenHideOutput<CR>", desc = "Hide output" },
    },
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = { useDefaultKeymaps = true },
  },
}

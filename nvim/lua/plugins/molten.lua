return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    lazy = false, -- remote plugins must be loaded eagerly
    dependencies = {
      "3rd/image.nvim",
    },
    build = ":UpdateRemotePlugins",
    init = function()
      -- Configure molten options
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    keys = {
      { "<leader>jj", function()
          -- Get paragraph boundaries
          local start_line = vim.fn.search('^\\s*$', 'bnW') + 1
          local end_line = vim.fn.search('^\\s*$', 'nW') - 1
          if end_line < start_line then
            end_line = vim.fn.line('$')
          end
          -- Run the paragraph
          vim.fn.MoltenEvaluateRange(start_line, end_line)
          -- Jump to next paragraph first line
          vim.cmd("normal! }j")
        end, desc = "Run Paragraph & Next" },
      { "<leader>ji", ":MoltenInit<CR>", desc = "Init Kernel" },
      { "<leader>je", ":MoltenEvaluateOperator<CR>", desc = "Evaluate Operator" },
      { "<leader>jl", ":MoltenEvaluateLine<CR>", desc = "Evaluate Line" },
      { "<leader>jr", ":MoltenReevaluateCell<CR>", desc = "Re-evaluate Cell" },
      { "<leader>jv", ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v", desc = "Evaluate Visual" },
      { "<leader>jd", ":MoltenDelete<CR>", desc = "Delete Cell" },
      { "<leader>jh", ":MoltenHideOutput<CR>", desc = "Hide Output" },
      { "<leader>jo", ":noautocmd MoltenEnterOutput<CR>", desc = "Enter Output" },
      { "<leader>jx", ":MoltenInterrupt<CR>", desc = "Interrupt Kernel" },
      { "<leader>jn", ":MoltenNext<CR>", desc = "Next Cell" },
      { "<leader>jp", ":MoltenPrev<CR>", desc = "Prev Cell" },
      { "<leader>jI", ":MoltenInfo<CR>", desc = "Molten Info" },
    },
  },
}

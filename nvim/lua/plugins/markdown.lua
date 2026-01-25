return {
  -- Live browser preview with full LaTeX/KaTeX support (like Obsidian)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npx --yes yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_theme = "dark"
    end,
    keys = {
      { "<leader>mv", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
    },
  },

  {
    "rafamadriz/friendly-snippets",
    dependencies = { "L3MON4D3/LuaSnip" },
    config = function()
      require("luasnip").config.setup({ enable_autosnippets = true })
      require("luasnip.loaders.from_vscode").lazy_load({ include = { "markdown" } })
    end,
  },

  {
    "plasticboy/vim-markdown",
    ft = { "markdown" },
    config = function()
      vim.g.vim_markdown_conceal = 1
      vim.g.vim_markdown_conceal_code_blocks = 1
      vim.g.vim_markdown_conceal_math = 1
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = "n"
        end,
      })
      -- Toggle continuous asynchronous Pandoc compilation on save
      local M = {}
      local augroup = vim.api.nvim_create_augroup("MdAutoCompile", { clear = false })
      local enabled = false

      local function compile_markdown_to_pdf(bufnr)
        local src = vim.api.nvim_buf_get_name(bufnr)
        if src == "" then
          vim.notify("No filename for buffer, skipping pandoc", vim.log.levels.WARN)
          return
        end
        local dest = src:gsub("%.md$", ".pdf")
        local cmd = { "pandoc", src, "-o", dest, "--pdf-engine=xelatex" }
        vim.fn.jobstart(cmd, {
          stdout_buffered = true,
          stderr_buffered = true,
          on_stdout = function(_, data)
            if data and #data > 0 then
              vim.notify(table.concat(data, "\n"), vim.log.levels.INFO, { title = "pandoc stdout" })
            end
          end,
          on_stderr = function(_, data)
            if data and #data > 0 then
              vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR, { title = "pandoc stderr" })
            end
          end,
          on_exit = function(_, code)
            if code == 0 then
              vim.notify("Pandoc: PDF updated: " .. dest, vim.log.levels.INFO)
            else
              vim.notify("Pandoc exited with code " .. tostring(code), vim.log.levels.ERROR)
            end
          end,
        })
      end

      function M.start()
        if enabled then
          vim.notify("Markdown auto-compile already enabled", vim.log.levels.INFO)
          return
        end
        vim.api.nvim_create_autocmd("BufWritePost", {
          group = augroup,
          pattern = "*.md",
          callback = function(args)
            compile_markdown_to_pdf(args.buf)
          end,
        })
        enabled = true
        vim.notify("Markdown auto-compile enabled", vim.log.levels.INFO)
      end

      function M.stop()
        if not enabled then
          vim.notify("Markdown auto-compile not enabled", vim.log.levels.INFO)
          return
        end
        vim.api.nvim_clear_autocmds({ group = augroup })
        enabled = false
        vim.notify("Markdown auto-compile disabled", vim.log.levels.INFO)
      end

      -- Toggle keymap: <leader>mp toggles markdown auto-compile
      vim.keymap.set("n", "<leader>mp", function()
        if enabled then
          M.stop()
        else
          M.start()
        end
      end, { desc = "Toggle markdown auto-compile (pandoc)" })

    end,
  },
}

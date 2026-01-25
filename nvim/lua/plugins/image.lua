return {
  "3rd/image.nvim",
  build = false, -- disable build, luarocks.nvim handles it
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    {
      "vhyrro/luarocks.nvim",
      priority = 1001,
      opts = {
        rocks = { "magick" },
      },
    },
  },
  ft = { "markdown", "norg", "org" },
  opts = {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" },
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    editor_only_render_when_focused = false,
    tmux_show_only_in_active_window = true,
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
  },
  keys = {
    {
      "<leader>mi",
      function()
        require("image").clear()
        vim.notify("Images cleared", vim.log.levels.INFO)
      end,
      desc = "Clear images",
    },
  },
}

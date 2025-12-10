return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      local luasnip = require("luasnip")

      -- Load UltiSnips format snippets (like your LaTeX file)
      require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/snippets" } })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load({ paths = { "~/.config/nvim/UltiSnips" } })

      -- Optional: enable autosnippets and friendly settings
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })
    end,
  },
}

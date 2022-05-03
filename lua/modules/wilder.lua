local ok, wilder = pcall(require, "wilder")
if not ok then
  return
end
local accent_color = "#4aa5f0"
wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option("use_python_remote_plugin", 0) -- Disable Python remote plugin
wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
      fuzzy_filter = wilder.lua_fzy_filter(),
    }),
    wilder.vim_search_pipeline()
  ),
})
wilder.set_option(
  "renderer",
  wilder.popupmenu_renderer({
    highlighter = wilder.lua_fzy_highlighter(),
    highlights = {
      accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = accent_color } }),
    },
    left = { " ", wilder.popupmenu_devicons() },
    right = { " ", wilder.popupmenu_scrollbar() },
    pumblend = 0,
    max_height = "50%", -- max height of the palette
    min_height = 0, -- set to the same as "max_height" for a fixed height window
    prompt_position = "top", -- "top" or "bottom" to set the location of the prompt
    reverse = 0, -- set to 1 to reverse the order of the list, use in combination with "prompt_position"
  })
)

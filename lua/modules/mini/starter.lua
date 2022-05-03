local header = string.format([[
     .-.      _______                             .  '  *   .  . '
    {}``; |==|_______D                                  . *  -+-  .
    / ('        /|\                                 . '   * .    '  *
(  /  |        / | \                                    * .  ' .  .-+-
 \(_)_%s      /  |  \                                *   *  .   .      ]], "]]")
local footer =
"<?> to toggle help                                           draxel.io"
local default_footer =
([[Type query to filter items
<BS> deletes latest character from query
<Esc> resets current query
<Down>/<Up> and <M-j>/<M-k> move current item
<CR> executes action of current item
<C-c> closes this buffer
<?> to toggle help]])


local function footer_help(content)
  vim.keymap.set('n', "?", function()
    if MiniStarter.config.footer == default_footer then
      MiniStarter.config.footer = footer
    else
      MiniStarter.config.footer = default_footer
    end
    MiniStarter.refresh()
  end)
  return content
end

local items = function()
  return function()
    return {
      { action = 'Telescope file_browser', name = 'Browser', section = 'Telescope' },
      { action = 'Telescope command_history', name = 'Command history', section = 'Telescope' },
      { action = 'Telescope find_files', name = 'Files', section = 'Telescope' },
      { action = 'Telescope help_tags', name = 'Help tags', section = 'Telescope' },
      { action = 'Telescope live_grep', name = 'Live grep', section = 'Telescope' },
      { action = 'Telescope oldfiles', name = 'Old files', section = 'Telescope' },
    }
  end
end

local default_header = function()
  local hour = tonumber(vim.fn.strftime('%H'))
  -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
  local part_id = math.floor((hour + 4) / 8) + 1
  local day_part = ({ 'evening', 'morning', 'afternoon', 'evening' })[part_id]
  local username = vim.loop.os_get_passwd()['username'] or 'USERNAME'

  return ('Good %s, %s'):format(day_part, username)
end

local ok, starter = pcall(require, "mini.starter")
if not ok then
  return
end
-- starter.on_vimenter()
starter.setup({
  -- Whether to open starter buffer on VimEnter. Not opened if Neovim was
  -- started with intent to show something else.
  autoopen = true,
  -- Whether to evaluate action of single active item
  evaluate_single = false,
  header = "     ",
  footer = footer,
  -- Items to be displayed. Should be an array with the following elements:
  -- - Item: table with <action>, <name>, and <section> keys.
  -- - Function: should return one of these three categories.
  -- - Array: elements of these three types (i.e. item, array, function).
  -- If `nil` (default), default items will be used (see |mini.starter|).
  content = "fdfd ",
  items = {
    { name = "Edit new buffer", action = "enew", section = "Actions" },
    { name = "Update Plugins", action = "PackerSync", section = "Actions" },
    { name = "Config", action = "e " .. api.fs.join(vim.fn.stdpath('config') .. "/init.lua"), section = "Actions" },
    { name = "StartupTime", action = "StartupTime", section = "Actions" },
    { name = "Quit Neovim", action = "qall", section = "Actions" },
    items(),
    -- { action = 'Telescope file_browser', name = 'Browser', section = 'Telescope' },
    -- { action = 'Telescope command_history', name = 'Command history', section = 'Telescope' },
    -- { action = 'Telescope find_files', name = 'Files', section = 'Telescope' },
    -- { action = 'Telescope help_tags', name = 'Help tags', section = 'Telescope' },
    -- { action = 'Telescope live_grep', name = 'Live grep', section = 'Telescope' },
    -- { action = 'Telescope oldfiles', name = 'Old files', section = 'Telescope' },
    -- starter.sections.recent_files(3, true),
    -- starter.sections.recent_files(5, false),
    starter.sections.sessions(3, true) -- Use this if you set up "mini.sessions"
    },
  -- Array  of functions to be applied consecutively to initial content.
  -- Each function should take and return content for "Starter" buffer (see
  -- |mini.starter| and |MiniStarter.content| for more details).
  content_hooks = {
    footer_help,
    -- starter.gen_hook.adding_bullet("> ", true), -- 
    -- {horizontal} (string) One of "left", "center", "right". Default: "left".
    -- {vertical} (string) One of "top", "center", "bottom". Default: "top".
    starter.gen_hook.aligning("left", "top"),
    starter.gen_hook.padding(3, 2),
    starter.gen_hook.indexing("all", { "Actions" }),
  },
  -- Characters to update query. Each character will have special buffer
  -- mapping overriding your global ones. Be careful to not add `:` as it
  -- allows you to go into command mode.
  query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.]],
})

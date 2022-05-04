local lvim = lvim

lvim.builtin.alpha.dashboard.section.header = {
  val = {
    [[ ___                                                                 ]],
    [[/\_ \                                              __                ]],
    [[\//\ \    __  __    ___      __     _ __   __  __ /\_\    ___ ___    ]],
    [[  \ \ \  /\ \/\ \ /' _ `\  /'__`\  /\`'__\/\ \/\ \\/\ \ /' __` __`\  ]],
    [[   \_\ \_\ \ \_\ \/\ \/\ \/\ \L\.\_\ \ \/ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[   /\____\\ \____/\ \_\ \_\ \__/.\_\\ \_\  \ \___/  \ \_\ \_\ \_\ \_\]],
    [[   \/____/ \/___/  \/_/\/_/\/__/\/_/ \/_/   \/__/    \/_/\/_/\/_/\/_/]],
  },
  opts = {
    position = "center",
    hl = "SpecialKey",
  },
}

lvim.builtin.alpha.dashboard.section.buttons = {
  entries = {
    { "SPC f", "  Find File", "<CMD>Telescope find_files<CR>" },
    { "SPC n", "  New File", "<CMD>ene!<CR>" },
    { "SPC P", "  Recent Projects ", "<CMD>Telescope projects<CR>" },
    { "SPC s r", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
    { "SPC s t", "  Find Word", "<CMD>Telescope live_grep<CR>" },
    {
      "SPC L c",
      "  Configuration",
      "<CMD>edit " .. require("lvim.config").get_user_config_path() .. " <CR>",
    },
  }
}

local text = require "lvim.interface.text"
local git_utils = require "lvim.utils.git"

local current_branch = git_utils.get_lvim_branch()
local plugins_count = vim.fn.len(vim.fn.globpath(vim.fn.stdpath "data" .. "/site/pack/packer/start", "*", 0, 1))

local lvim_version
if current_branch ~= "HEAD" or "" then
  lvim_version = current_branch .. "-" .. git_utils.get_lvim_current_sha()
else
  lvim_version = "v" .. git_utils.get_lvim_tag()
end

lvim.builtin.alpha.dashboard.section.footer = {
  type = "text",
  val = text.align_center({ width = 0 }, {
    "",
    "lunarvim.org",
    lvim_version,
    "loaded " .. plugins_count .. " plugins",
  }, 0.5),
  opts = {
    position = "center",
    hl = "Number",
  },
}

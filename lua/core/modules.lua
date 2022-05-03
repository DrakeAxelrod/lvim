local lvim = lvim

-- Additional Plugins
lvim.plugins = {
  { "yamatsum/nvim-nonicons" },
  { "NTBBloodbath/doom-one.nvim", config = [[require("modules.doom-one")]] },
  { "echasnovski/mini.nvim", config = [[require("modules.mini")]]},
  { "nathom/filetype.nvim" },
  { "wakatime/vim-wakatime" },
  { "tpope/vim-repeat" },
  { "p00f/nvim-ts-rainbow" },
  {
    "phaazon/hop.nvim",
    branch = "v1",
    event = { "BufRead", "BufReadPre" },
    cmd = { "HopWord", "HopLine", "HopChar1" },
    config = function()
      require("hop").setup({
        keys = "etovxqpdygfblzhckisuran",
      })
    end
  }, -- jump around text
  { "zbirenbaum/copilot.lua" },
  {
    "zbirenbaum/copilot-cmp",
    -- event = { "BufRead", "BufReadPre", "InsertEnter" },
    after = { "nvim-cmp" },
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    event = { "BufRead", "BufReadPre", "InsertEnter" },
    after = { "nvim-cmp" },
  },
  { "gelguy/wilder.nvim",
    requires = { "romgrk/fzy-lua-native" },
    config = [[require("modules.wilder")]]
  },
  { "j-hui/fidget.nvim",
    event = { "BufWinEnter", "BufRead", "BufReadPre" },
    after = { "nvim-lsp-installer", "nvim-lspconfig", "plenary.nvim" },
    config = [[require("modules.fidget")]]
  },
  { "mrjones2014/legendary.nvim", config = [[require("modules.legendary")]] },
  { "sudormrfbin/cheatsheet.nvim" },
  { "nvim-telescope/telescope-fzy-native.nvim", run = "make", event = "BufRead" },
  { "nvim-telescope/telescope-packer.nvim" }, -- packer
  { "nvim-telescope/telescope-file-browser.nvim" }, -- file browser
  { "nvim-telescope/telescope-frecency.nvim",requires = { "tami5/sqlite.lua" } }, -- frequently used
  { "LinArcX/telescope-command-palette.nvim", after = { "sqlite.lua" } },
  { "nvim-telescope/telescope-github.nvim", after = { "plenary.nvim" } },
  {
    "nvim-telescope/telescope-smart-history.nvim",
    requires = { { "tami5/sqlite.lua", rocks = { "sqlite", "luv" } } },
  }, -- better history
  { "MunifTanjim/nui.nvim", after = { "nvim-web-devicons" } },
  { "stevearc/dressing.nvim", after = { "nui.nvim" } },
}


require("modules.telescope.config")

lvim.builtin.cmp.formatting.source_names.copilot = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, { name = "copilot", priority = 10 })
table.insert(lvim.builtin.cmp.sources, { name = "nvim_lsp_signature_help" })

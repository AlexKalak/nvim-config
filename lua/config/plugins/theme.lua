local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "transparent" and "mocha" or "macchiato",
      transparent_background = true,
      styles = {
        keywords = { "bold" },
        functions = { "italic" },
      },
      integrations = {
        alpha = false,
        neogit = false,
        nvimtree = false,
        treesitter_context = false,
        rainbow_delimiters = false,
        mini = { enabled = false },
        dropbar = { enabled = false },
        illuminate = { enabled = false },
        mason = true,
        noice = true,
        snacks = {
          enabled = true,
          indent_scope_color = "overlay2",
        },
        neotest = true,
        blink_cmp = true,
        which_key = true,
        nvim_surround = true,
        telescope = { style = "transparent" and nil or "nvchad" },
      },
      custom_highlights = function(colors)
        return {
          -- custom
          PanelHeading = {
            fg = colors.lavender,
            bg = "transparent" and colors.none or colors.crust,
            style = { "bold", "italic" },
          },

          -- lazy.nvim
          LazyH1 = {
            bg = "transparent" and colors.none or colors.peach,
            fg = "transparent" and colors.lavender or colors.base,
            style = { "bold" },
          },
          LazyButton = {
            bg = colors.none,
            fg = "transparent" and colors.overlay0 or colors.subtext0,
          },
          LazyButtonActive = {
            bg = "transparent" and colors.none or colors.overlay1,
            fg = "transparent" and colors.lavender or colors.base,
            style = { "bold" },
          },
          LazySpecial = { fg = colors.green },

          FloatBorder = {
            fg = "transparent" and colors.blue or colors.mantle,
            bg = "transparent" and colors.none or colors.mantle,
          },

          FloatTitle = {
            fg = "transparent" and colors.lavender or colors.base,
            bg = "transparent" and colors.none or colors.lavender,
          },
        }
      end,
    })
    vim.cmd.colorscheme("catppuccin")
    local palette = require("catppuccin.palettes").get_palette()
  end,
}

return {
  {
    {
      "olimorris/onedarkpro.nvim",
      enabled = false,
      priority = 1000, -- Ensure it loads first
      config = function()
        vim.cmd("colorscheme onedark")
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      end
    },
    M
  }
}

local map = vim.api.nvim_set_keymap
local builtin = require('telescope.builtin')

require('telescope').setup{
  defaults = {
    prompt_prefix = " >",
 }
}


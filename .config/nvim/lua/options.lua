local wo = vim.wo

vim.cmd[[colorscheme nord]] -- Everforest is setting Gruvbox instead of itelf unless another theme is being set first, hence this Nord call
vim.cmd[[colorscheme everforest]]

wo.number = true


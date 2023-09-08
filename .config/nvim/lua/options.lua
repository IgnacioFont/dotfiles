vim.cmd[[colorscheme gruvbox-material]]
vim.g.mapleader = " "

local opts = {
  number = true,
  relativenumber = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  wrap = false,
  swapfile = false,
  backup = false,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,
  hlsearch = false,
  incsearch = true,
  termguicolors = true,
  scrolloff = 8,
  updatetime = 50,
  colorcolumn = "80"
}

for k, v in pairs(opts) do
  vim.o[k] = v
end

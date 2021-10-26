{
  set = toMap {
    tabstop = "2",
    shiftwidth = "2",
    expandtab = "",
    softtabstop = "2", 
    smarttab = "",
    nu = "",
    autoindent = "",
    ruler = "",
    encoding = "UTF-8",
    noshowmode = "",
    mouse = "a",
  },

  binding = toMap {
    nnoremap = toMap {
      `<leader>nt` = ":NERDTreeTogle<cr>",
      `<leader>tb` = ":TagbarTogle<cr>",
      `<leader>//` = ":let @/ = \"\"<cr>",
      `<leader>ff` = ":FZF <cr>",
      `<leader>ag` = ":Ag<cr>",
      `<F1>`       = "gg+yG",
    },
    xmap = toMap {
      ga = "<Plug>(EasyAlign)"
    },
    nmap = toMap {
      ga = "<Plug>(EasyAlign)"
    }
  },

  raw = ''
let mapleader=" "

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mesonbuild/meson', { 'rtp': 'data/syntax-highlighting/vim' }
call plug#end()
  ''
}
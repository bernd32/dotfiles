return {
  "vimwiki/vimwiki",
  keys = { "<Leader>ww" },
  init = function()
    vim.g.vimwiki_list = {
      {
        path = "/home/bernd/MEGA/googledrive/textDB/vim-wiki/",
        syntax = "markdown",
        ext = ".md",
      },
    }
  end,
}

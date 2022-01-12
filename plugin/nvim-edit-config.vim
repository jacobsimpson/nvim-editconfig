
map <silent> ,lc :lua require('telescope.builtin').find_files( { cwd = '~/dotfiles/nvim' })<CR>

augroup editconfig
    autocmd!

    autocmd BufEnter */plugins.vim map <buffer> <silent> gf :lua require('editconfig').go_file()<CR>
    autocmd BufLeave */plugins.vim unmap <buffer> gf

    autocmd BufEnter */plugins.vim map <buffer> <silent> ,ac :lua require('editconfig').add_plugin()<CR>
    autocmd BufLeave */plugins.vim unmap <buffer> ,ac
augroup END

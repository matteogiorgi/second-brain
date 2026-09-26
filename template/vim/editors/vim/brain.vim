" Vim adapter for the second brain.
" Usage: in your vimrc, after exporting BRAIN,
"   execute 'source' $BRAIN . '/editors/vim/brain.vim'

" Reload files changed by an agent while they are open. 'autoread'
" alone reloads a file only when Vim checks it; :checktime forces the
" check when Vim regains focus (FocusGained, which inside tmux needs
" 'set -g focus-events on'), when switching buffers (BufEnter) and
" after 'updatetime' milliseconds without typing (CursorHold).
set autoread
augroup brain
    " clear the group first, so sourcing this file twice does not
    " register every autocommand twice
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold * silent! checktime
    " Wrap at 72 columns, only in the archive's notes: the pattern is
    " built from $BRAIN, so execute turns the string into a command.
    " Without BRAIN the pattern would be '/*.md', every Markdown file.
    if !empty($BRAIN)
        execute 'autocmd BufRead,BufNewFile ' . $BRAIN . '/*.md setlocal textwidth=72'
    endif
augroup END

" gf follows relative links with no configuration: 'path' already
" contains '.', the current file's folder, and links include '.md'.

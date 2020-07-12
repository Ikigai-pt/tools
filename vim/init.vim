let mapleader=','
" ============================================================================ "
" === PLUGINS === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/vim-emoji'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

" Plug 'ap/vim-css-color'
Plug 'kyoz/purify', { 'rtp': 'vim' }

Plug 'AndrewRadev/vim-eco'

Plug 'AndrewRadev/switch.vim'
let g:switch_mapping = "-"

Plug 'AndrewRadev/splitjoin.vim'
let g:splitjoin_html_attributes_bracket_on_new_line=1

Plug 'dense-analysis/ale'
let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'javascript.jsx': ['eslint'],
      \ 'ruby': ['rubocop'],
      \ }
let g:ale_fix_on_save = 1
" Plug 'benekastah/neomake'
" Plug 'benjie/neomake-local-eslint.vim'
" let g:neomake_javascript_eslint_marker = {
"       \ 'args': ['--fix']
"       \ }
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_json_enabled_makers = ['jsonlint']
let g:neomake_css_enabled_makers = ['csslint']
let g:neomake_error_sign = {
      \ 'texthl': 'ErrorMsg',
      \ }
" let g:neomake_ft_jsx_enabled_makers = ['eslint']
" let g:neomake_open_list=2
" let g:neomake_list_height=1
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Chiel92/vim-autoformat'
Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" Plug 'haya14busa/vim-auto-programming', { 'branch': 'neovim' }
Plug 'blueyed/vim-auto-programming', { 'branch': 'neovim' }
" Plug 'easymotion/vim-easymotion'
" nmap s <Plug>(easymotion-s)

Plug 'justinmk/vim-sneak'

""""""""""""""""""""""""
" coc start
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" if hidden not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add diagnostic info for https://github.com/itchyny/lightline.vim
" let g:lightline = {
"       \ 'colorscheme': 'wombat',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'cocstatus': 'coc#status'
"       \ },
"       \ }

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p :<C-u>CocListResume<CR>

" coc end
""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'janko-m/vim-test'
nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#strategy = "neoterm"
let test#ruby#bundle_exec = 1

Plug 'machakann/vim-highlightedyank'
highlight HighlightedyankRegion ctermbg=white ctermfg=black guibg=white guifg=black
" Plug '907th/vim-auto-save'
" let g:auto_save = 1
" let g:auto_save_in_insert_mode = 0
" Plug 'malept/vim-flog'
" silent exe "g:flog_enable"
" map <leader>f :call FlogToggle()<cr>
" Plug 'skammer/vim-ruby-complexity'

Plug 'szw/vim-tags'
let g:vim_tags_auto_generate = 0
" let g:vim_tags_use_vim_dispatch = 1
" Plug 'lukaszkorecki/CoffeeTags'

Plug 'kassio/neoterm'
let g:neoterm_size = 10
let g:neoterm_autoscroll = 1

Plug 'austintaylor/vim-indentobject'

Plug 'mattn/emmet-vim'

" Plug 'jpalardy/vim-slime'
" let g:slime_target = "tmux"

Plug 'jreybert/vimagit'

Plug 'airblade/vim-gitgutter'
let g:gitgutter_preview_win_floating = 1

Plug 'scrooloose/nerdtree'

Plug 'junegunn/gv.vim'

Plug 'low-ghost/nerdtree-fugitive'

Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'neovim/python-client'
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=red ctermbg=red
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=236

Plug 'Xuyuanp/nerdtree-git-plugin'
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    if (expand("%:t") != '')
      exe ":NERDTreeFind"
    else
      exe ":NERDTreeToggle"
    endif
  endif
endfunction
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeHijackNetrw=0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer=1
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>nf :NERDTreeFind<cr>
" nnoremap <leader>nf :call NERDTreeToggleInCurDir()<cr>
nnoremap <leader>nc :NERDTreeCWD<cr>
" Plug 'flazz/vim-colorschemes'
" Plug 'robertmeta/nofrils'
" Plug 'fxn/vim-monochrome'
" Plug 'crusoexia/vim-monokai'
" Plug 'owickstrom/vim-colors-paramount'
"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.notexists = '+'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_alt_sep=''
let g:airline_inactive_collapse=1
" let g:airline_section_a (mode, crypt, paste, spell, iminsert)
let g:airline_section_a=''
" let g:airline_section_b (hunks, branch)
" let g:airline_section_c (bufferline or filename)
" let g:airline_section_gutter (readonly, csv)
" let g:airline_section_x (tagbar, filetype, virtualenv)
" let g:airline_section_y (fileencoding, fileformat)
let g:airline_section_y=''
" let g:airline_section_z (percentage, line number, column number)
" let g:airline_section_error (ycm_error_count, syntastic-err, eclim)
" let g:airline_section_warning (ycm_warning_count, syntastic-warn, whitespace)
" Remove encoding and newline
" enable/disable showing only non-zero hunks.
let g:airline#extensions#hunks#non_zero_only=1
" because of TmuxlineSnapshot
let g:airline#extensions#tmuxline#enabled=0
let g:airline#extensions#tabline#enabled=0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#close_symbol = '✖'
" for FZF
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#default#section_truncate_width = {
  \ 'b': 120,
  \ 'x': 100,
  \ 'z': 100,
  \ 'warning': 0,
  \ 'error': 0,
  \ }

Plug 'slim-template/vim-slim'

" JAVASCRIPT
Plug 'jparise/vim-graphql'
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }"
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
Plug 'othree/yajs.vim', { 'for': 'javascript' }
" Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
" let g:javascript_enable_domhtmlcss = 1
" Plug 'gavocanov/vim-js-indent'
" Plug 'othree/es.next.syntax.vim'
" Plug 'othree/javascript-libraries-syntax.vim'
" let g:used_javascript_libs = 'jquery,underscore,backbone,react,jasmine'

Plug 'kchmck/vim-coffee-script'
Plug 'mtscout6/vim-cjsx'

Plug 'jremmen/vim-ripgrep'

Plug 'radenling/vim-dispatch-neovim'

Plug 'vim-ruby/vim-ruby'
let ruby_no_expensive = 1

Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'

Plug 'tpope/vim-ragtag'
inoremap <M-o> <Esc>o
inoremap <C-j> <Down>
let g:ragtag_global_maps = 1

Plug 'rhysd/git-messenger.vim'
nnoremap <leader>gb :GitMessenger<cr>

Plug 'tpope/vim-fugitive'
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gr :Gread<cr>
" https://vi.stackexchange.com/questions/13433/how-to-load-list-of-files-in-commit-into-quickfix
command! -nargs=? -bar Gload call setqflist(map(systemlist("git show --pretty='' --name-only <args>"), '{"filename": v:val, "lnum": 1}'))

" Plug 'tpope/vim-rsi'
Plug 'tpope/vim-unimpaired'
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gr :Gread<cr>

" Mutliple cursors
Plug 'terryma/vim-multiple-cursors'

Plug 'wellle/targets.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! InsertTabWrapper()
" let col = col('.') - 1
" if !col || getline('.')[col - 1] !~ '\k'
" return "\<tab>"
" else
" return "\<c-n>"
" endif
" endfunction
" inoremap <expr> <tab> InsertTabWrapper()
" inoremap <s-tab> <c-p>

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
nnoremap <silent> <c-p> :FZF -m<CR>

nnoremap <silent> <Leader>s :call fzf#run({ 'tmux_height': winheight('.') / 2, 'sink': 'botright split' })<CR>
nnoremap <silent> <Leader>v :call fzf#run({ 'tmux_width': winwidth('.') / 2, 'sink': 'vertical botright split' })<CR>

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
      \   'source': reverse(<sid>buflist()),
      \   'sink': function('<sid>bufopen'),
      \   'options': '+m',
      \   'down': len(<sid>buflist()) + 2
      \ })<CR>
call plug#end()

" set t_Co=256
"
" Enable term 24 bit colour in latest neovim
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
" if (has('termguicolors'))
" set termguicolors
" endif

if (has("termguicolors"))
 set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set mouse=a
" set background=dark
syntax enable
" colorscheme Tomorrow-Night
" colorscheme preto
" colorscheme monochrome
" colorscheme nofrils
" colorscheme monokai
colorscheme purify

hi Constant ctermfg=white
set number
" set relativenumber
set nowrap
set ruler
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set hidden
set noswapfile
set undodir=~/.vim/undo " where to save undo histories
set undofile " Save undo's after file closes
set undolevels=1000 " How many undos
set undoreload=10000 " number of lines to save for undo
set nobackup
set nowritebackup
call matchadd('ColorColumn', '\%' . &textwidth . 'v', 81)
set nospell
set ignorecase
set smartcase
set synmaxcol=160
set complete=.,w,b,u,U,i,d,t
set completeopt=menu,longest
set completefunc=autoprogramming#complete
set conceallevel=0
set noshowmode
set shortmess+=c
set showmatch
set noshowcmd
set cursorline
set inccommand=nosplit

set splitbelow
set splitright

" set wildmenu wildmode=longest:full
set wildoptions=tagfile
set wildignorecase

" Ignore a lot of stuff.
set wildignore+=*.swp,*.pyc,*.bak,*.class,*.orig
set wildignore+=.git,.hg,.bzr,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.svg
set wildignore+=build/*,tmp/*,vendor/cache/*,bin/*
set wildignore+=.sass-cache/*

set spelllang=en_us
set spellsuggest=best,3

" White spacing and Characters
" A problem that plagued me for months, having visual cues for white spacing
" solves formatting problems a lot quicker. Also, we're using modern shells
" (right?) so using UTF-8 characters for symbols should be a given.
set fillchars+=diff:⣿
set fillchars+=vert:│
set fillchars+=fold:-

" A visual cue for line-wrapping.
set showbreak=↪
" Visual cues when in 'list' model.
set list
" set listchars+=eol:¬
set listchars=
set listchars+=extends:❯
set listchars+=precedes:❮
set listchars+=trail:⋅
set listchars+=nbsp:⋅
set listchars+=tab:·\ "

set pastetoggle=<F2>
noremap <silent> <F2> setlocal paste!<cr>

" nnoremap <silent> <bs> :setlocal hlsearch!<cr>

nnoremap <silent> <up> <nop>
nnoremap <silent> <down> <nop>
nnoremap <silent> <left> <nop>
nnoremap <silent> <right> <nop>
nnoremap Q <nop>
nnoremap <F1> <ESC>
inoremap <F1> <ESC>
nnoremap <c-g> 1<c-g>

" Easy move between windows
func! s:mapMoveToWindowInDirection(direction)
  func! s:moveToDirection(direction)
    stopinsert
    execute "wincmd" a:direction
  endfunc
  execute "tnoremap" "<silent>" "<C-" . a:direction . ">"
        \ "<C-\\><C-n>"
        \ ":call <SID>moveToDirection(\"" . a:direction . "\")<CR>"
  execute "nnoremap" "<silent>" "<C-" . a:direction . ">"
        \ ":call <SID>moveToDirection(\"" . a:direction . "\")<CR>"
endfunc

for dir in ["h", "j", "l", "k"]
  call s:mapMoveToWindowInDirection(dir)
endfor

augroup files
  au!
  " au BufEnter * if &buftype == 'terminal' | highlight TermCursor ctermfg=red guifg=red | :startinsert | endif
  au BufEnter * if &buftype == 'terminal' | highlight TermCursor ctermfg=red guifg=red | endif
  au BufEnter * hi MatchParen ctermfg=yellow ctermbg=black
  au FileType fzf tnoremap <nowait><buffer> <esc> <c-g>
  " au BufWritePost * Neomake
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END
au! BufWritePost init.vim source %

autocmd BufWritePre *.md :%s//\r/ge
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * :silent! g/^\_$\n\_^$/d

set background=dark
hi Normal ctermbg=Black

map <silent> j gj
map <silent> k gk

set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
" Yank
" Yank till the end of line
nnoremap Y y$
" Quickly select text you just pasted:
noremap gV `[v`]

" nnoremap <cr> O<esc>

""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
" System clipboard
set clipboard=unnamed
nmap <leader>yy "*yy
nmap <leader>dd "*dd
vmap <leader>y "*y
vmap <leader>Y "*y$
vmap <leader>d "*d
nmap <leader>p "*p
nmap <leader>P "*P

nmap <leader>[p "*[p
nmap <leader>]p "*]p

" Indentation
vmap > >gv
vmap < <gv
" noremap <Tab> mm^==`m<esc>
noremap <Tab> ^==<esc>

" auto center
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
nnoremap <silent> <C-o> <C-o>zz
nnoremap <silent> <C-i> <C-i>zz

" Quick reindent
nmap <leader>= mrgg=Gg`rzz
" tnoremap <leader><esc> <C-\><C-n>
tnoremap <esc><esc> <C-\><C-n>

" Expand %% to current directory
" http://vimcasts.org/e/14
cnoremap %%%<tab> <C-R>=fnameescape(expand('%:.'))<cr>
cnoremap %%<tab> <C-R>=fnameescape(expand('%:h')).'/'<cr>
cnoremap %<tab> <C-R>=fnameescape(expand('%:t'))<cr>
cnoremap w!! %!sudo tee > /dev/null %
" nnoremap <leader>w :w<cr>
" clean double whitespace and save
nnoremap <leader>w :silent! :%s/\v([^\ ])\ \ +([^\ ])/\1 \2/g<cr>:w<cr>
nnoremap q: :q
map <leader>bp f}%cSBBj:s/,/,\r/g<CR>viB==:set nohl<cr>
vmap <leader>s :sort ui<cr>
" last open files
command! Bro :enew | setl buftype=nofile | 0put =v:oldfiles | nnoremap <buffer> <CR> gf | 1
map <leader>bb :Bro<CR>
" <number><CR> to go to the line
nnoremap <expr> <cr> v:count == 0 ? "\<cr>" : "G"
" reselect pasted
nnoremap gp `[v`]
" " gitgutter
" let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
" let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
" let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
" let g:gitgutter_sign_modified_removed = emoji#for('collision')

" NetRW
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1
" augroup ProjectDrawer
" autocmd!
" autocmd VimEnter * :Vexplore
" augroup END
nnoremap <leader><leader> <C-^>
" use // to search for selected text
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'
" http://vi.stackexchange.com/questions/2816/how-to-prevent-vim-from-scrolling-buffers-when-i-open-split
nnoremap <C-W>s Hmx`` \|:split<CR>`xzt``

highlight Todo cterm=NONE

augroup suffixes
    autocmd!

    let associations = [
      \["javascript.jsx", ".js,.json"],
      \["coffee", ".coffee,.js"],
    \]

    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup END

" Auto complete setup
fun! GoYCM()
    nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
    nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
    nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>
endfun

fun! GoCoc()
    inoremap <buffer> <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()

    inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    inoremap <buffer> <silent><expr> <C-space> coc#refresh()

    " GoTo code navigation.
    nmap <buffer> <leader>gd <Plug>(coc-definition)
    nmap <buffer> <leader>gy <Plug>(coc-type-definition)
    nmap <buffer> <leader>gi <Plug>(coc-implementation)
    nmap <buffer> <leader>gr <Plug>(coc-references)
    nnoremap <buffer> <leader>cr :CocRestart
endfun
autocmd FileType typescript :call GoYCM()
autocmd FileType cpp,cxx,h,hpp,c,vue,js,css :call GoCoc()

" Navigation
nnoremap <C-f> <C-b>
nnoremap <C-b> <C-f>
" shortcut to save
nmap <leader><leader> :w<cr>
" set paste toggle
set pastetoggle=<leader>v
" switch between current and last buffer
nmap <leader>. <c-^>
inoremap jk <Esc>

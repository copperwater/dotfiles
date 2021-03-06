" Automatic commands for .tex files.
setlocal wrap
setlocal formatoptions+=t
setlocal textwidth=80
setlocal iskeyword=@,48-57,192-255,#,_
"nnoremap <buffer> gR :grep '\b<cword>\b' <CR>

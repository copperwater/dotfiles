" Syntax for des, a domain-specific language for level maps in NetHack 3.6 and
" earlier versions.

" May have maps which contain spaces at the end and are therefore significant.
" Suppress normal behavior of truncating trailing spaces at the end of lines.
" (Assumes the vimrc is configured to always delete trailing white space on save
" unless this variable is set.)
let b:no_delete_trailing_ws=1

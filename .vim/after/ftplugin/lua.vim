" Configuration for NetHack lua files, as that is the current only use case.

" NetHack lua files have maps which contain spaces at the end and are
" therefore significant.
let b:no_delete_trailing_ws=1

" NetHack lua is indented by this much
setlocal shiftwidth=3

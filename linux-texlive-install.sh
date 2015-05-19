#!/usr/bin/env bash
mpl_dest="/usr/share/texlive/texmf-dist/metapost/mpl"
[ -L "$mpl_dest" ] && sudo unlink "$mpl_dest"
sudo ln -sf $(pwd)/mpl "$mpl_dest"

dmvn_dest="/usr/share/texmf/tex/dmvn"
[ -L "$dmvn_dest" ] && sudo unlink "$dmvn_dest"
sudo ln -sf $(pwd)/dmvn "$dmvn_dest"

sudo mktexlsr

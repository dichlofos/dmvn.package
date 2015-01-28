#!/usr/bin/env bash
sudo ln -sf $(pwd)/mpl /usr/share/texlive/texmf-dist/metapost/mpl
sudo ln -sf $(pwd)/dmvn /usr/share/texmf/tex/dmvn
sudo mktexlsr

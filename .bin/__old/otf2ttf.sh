for i in *.otf; do fontforge -script ~/.local/bin/otf2ttf.ff $i; done

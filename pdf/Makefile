
all:
	nodefs ../Meltdown-Spectre.nw | sort -u > Meltdown-Spectre.defs
	noweave -indexfrom Meltdown-Spectre.defs -delay ../Meltdown-Spectre.nw > Meltdown-Spectre.tex
	xelatex -8bit Meltdown-Spectre
	makeindex Meltdown-Spectre
	makeglossaries Meltdown-Spectre
	xelatex -8bit Meltdown-Spectre
	xelatex -8bit Meltdown-Spectre
	mv Meltdown-Spectre.pdf ../

clean:
	rm -f *.acn
	rm -f *.acr
	rm -f *.alg
	rm -f *.aux
	rm -f *.defs
	rm -f *.glg
	rm -f *.glo
	rm -f *.gls
	rm -f *.glsdefs
	rm -f *.idx
	rm -f *.ilg
	rm -f *.ind
	rm -f *.ins-glg
	rm -f *.ins-glo
	rm -f *.ins-gls
	rm -f *.ist
	rm -f *.log
	rm -f *.out
	rm -f *.tex
	rm -f *.toc

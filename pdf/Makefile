
all:
	noweave -x -delay ../Meltdown-Spectre.nw > Meltdown-Spectre.tex
	xelatex -8bit Meltdown-Spectre
	makeglossaries Meltdown-Spectre
	xelatex -8bit Meltdown-Spectre
	xelatex -8bit Meltdown-Spectre
	mv Meltdown-Spectre.pdf ../

clean:
	rm *.aux
	rm *.defs
	rm *.log
	rm *.out
	rm *.tex
	rm *.toc

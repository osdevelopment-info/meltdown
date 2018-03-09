
all:
	nodefs -auto asdl ../Meltdown-Spectre.nw | sort -u > Meltdown-Spectre.defs
	noweave -indexfrom Meltdown-Spectre.defs -delay ../Meltdown-Spectre.nw > Meltdown-Spectre.tex
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

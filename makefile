all: 
#	pdflatex linear_algebra.tex
#	bibtex linear_algebra
	pdflatex exam_example.tex
	pdflatex exam_example.tex
	pdflatex quiz_example1.tex
	pdflatex quiz_example1.tex
	pdflatex quiz_example2.tex
	pdflatex quiz_example2.tex
clean: 
	rm *.aux *.log *~ *.out *.toc *.idx *.bbl *.bcf *.blg *.ptc *.xml


.PHONY: clean

weeks.tex: gencal.py
	python3 gencal.py

localisation.tex: ;

cal.pdf: calendar.cls cal.tex weeks.tex gencal.py localisation.tex
	lualatex cal.tex

halved.pdf: cal.pdf
	mutool poster -x 2 cal.pdf halved.pdf

padder-support.tex: ;

padded.pdf: halved.pdf padder.tex padder-support.tex
	pdflatex padder.tex
	mv padder.pdf padded.pdf

inclusions.tex: ;

imposition.pdf: padded.pdf imposer.tex inclusions.tex
	pdflatex imposer.tex
	mv imposer.pdf imposition.pdf

clean:
	rm -f *.aux *.log *.pdf weeks.tex inclusions.tex localisation.tex padder-support.tex

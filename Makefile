define LATEX_CODE
\\documentclass{article}
\\usepackage[top=2cm,bottom=2.5cm,left=2cm,right=2cm]{geometry}
\\usepackage[backend=biber]{biblatex}
\\addbibresource{references.bib}
\\begin{document}
\\nocite{*}
\\printbibliography
\\end{document}
endef

export LATEX_CODE


all:
	python fetch_pdfs.py references.bib html/
	python bibliogra.py -H header.tpl -F footer.tpl -f references.bib html/

pdf:
	TMP_FILE=$$(mktemp "censorbib-tmp-XXXXXXX.tex") ;\
	echo "$$LATEX_CODE" > "$$TMP_FILE" ;\
	pdflatex --interaction=batchmode "$${TMP_FILE%.tex}" ;\
	biber "$${TMP_FILE%.tex}" ;\
	rm "$${TMP_FILE%.tex}"* ;

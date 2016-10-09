OUTFILE=hackpack.pdf

TEMPLATE=./cyber.latex

FIND=./find.py

WEBSITE=../website

SOURCES=$(shell "$(FIND)" -e 'LICENSE.md' -e 'README.md' -f general -l appendix -g index.md .)

all: $(OUTFILE)

open: $(OUTFILE)
	xdg-open "$(OUTFILE)" &>/dev/null & disown

update: $(WEBSITE)/$(OUTFILE)

clean:
	rm -f "$(OUTFILE)"

$(OUTFILE): $(SOURCES)
	pandoc --template="$(TEMPLATE)" --standalone --toc --output "$(OUTFILE)" $^

$(WEBSITE)/$(OUTFILE): $(OUTFILE)
	cp $(OUTFILE) $(WEBSITE)/

	git -C "$(WEBSITE)" add "$(OUTFILE)"
	git -C "$(WEBSITE)" commit -m "update hackpack"
	git -C "$(WEBSITE)" push

.PHONY: all open update clean

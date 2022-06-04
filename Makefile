MDL := $(HOME)/bin/mdl.jar
ROMFILE := go-penguin.rom
SOURCES := $(shell find . -name "*.s")

.PHONY: all
all: $(ROMFILE)

$(ROMFILE): main.s $(SOURCES)
	java -jar $(MDL) -dialect tniasm $< -bin $@

run: $(ROMFILE)
	openmsx -carta $(ROMFILE) -romtype ASCII16

clean: $(ROMFILE)
	rm -f $(ROMFILE)

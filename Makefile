MDL := $(HOME)/bin/mdl.jar
ROMFILE := go-penguin.rom

$(ROMFILE): main.s
	java -jar $(MDL) -dialect tniasm $< -bin $@

run: $(ROMFILE)
	openmsx -carta $(ROMFILE) -romtype ASCII16

clean: $(ROMFILE)
	rm -f $(ROMFILE)

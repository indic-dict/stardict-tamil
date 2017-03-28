STARDICT_TOOLS_DIR=~/stardict/tools/src/
TABFILE=$(STARDICT_TOOLS_DIR)/tabfile
STARDICT_SANSKRIT_BIN=~/stardict-sanskrit/bin

# make all DICTS=xyz
DICTS=.*


.PHONY: all stardict tars

all:stardict tars

stardict:
	bash $(STARDICT_SANSKRIT_BIN)/tsv_to_stardict.sh 


tars:
	bash $(STARDICT_SANSKRIT_BIN)/make_tarballs.sh https://github.com/sanskrit-coders/stardict-tamil/raw/master/ta-head


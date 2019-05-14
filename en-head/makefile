STARDICT_TOOLS_DIR=~/stardict/tools/src/
TABFILE=$(STARDICT_TOOLS_DIR)/tabfile
DICT_TOOLS_BIN_BASH=~/dict-tools/bin/bash

# Let the URL not end with /.
URL=https://github.com/indic-dict/stardict-tamil/raw/master/$(shell pwd|sed -e s/.*[/]//)/tars

# make all DICTS=xyz
DICTS=.*


.PHONY: all stardict tars

all:stardict tars

stardict:
	bash $(DICT_TOOLS_BIN_BASH)/tsv_to_stardict.sh 


tars:
	bash $(DICT_TOOLS_BIN_BASH)/make_tarballs.sh  $(URL) DICTS=$(DICTS)


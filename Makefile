include MANIFEST

TARGETS=$(dotfiles:%=$(HOME)/.%)
CWD=$(shell pwd)

$(HOME)/.%: %
	@if [ -e $@ ]; then mv $@ $@.bak; fi
	@echo "Installing $<"
	@ln -sf $(CWD)/$< $@

install: $(TARGETS)
	git submodule update --init --recursive
	vim +BundleInstall +qall
	bash osx

uninstall:
	rm -f $(TARGETS)

update:
	git pull
	git submodule sync
	git submodule update --init --recursive
	vim +BundleInstall +qall
	bash osx

.PHONY: install uninstall update

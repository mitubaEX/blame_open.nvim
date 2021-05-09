.PHONY: setup test

all: setup test-themis

setup:
	git clone https://github.com/thinca/vim-themis.git
	git clone https://github.com/kana/vim-vspec.git

test-themis:
	vim-themis/bin/themis --reporter spec

test-vspec:
	./vim-vspec/bin/prove-vspec ./test

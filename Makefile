DUNE = dune

.default: build

build:
	$(DUNE) build

test:
	$(DUNE) runtest -f

clean:
	$(DUNE) clean

.PHONY: build test clean

.default: build

build:
	jbuilder build

test:
	jbuilder runtest -f

clean:
	jbuilder clean

.PHONY: build test clean

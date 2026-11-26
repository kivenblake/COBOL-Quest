# ===================================================================
# Makefile for COBOL QUEST (macOS & Linux)
# ===================================================================
PATH := /opt/homebrew/bin:/usr/local/bin:/opt/local/bin:$(PATH)
COBC ?= cobc
COBCFLAGS := -x -Wall

.PHONY: all build run install-deps examples test clean

all: build

build:
	@./scripts/build-unix.sh --build-only

run: build
	@./bin/cobol-quest

install-deps:
	@./scripts/install-gnucobol-unix.sh

examples: build
	@for exe in bin/0*; do \
		echo ""; \
		echo "============================================================"; \
		echo " RUNNING $$(basename $$exe)"; \
		echo "============================================================"; \
		(cd examples && "../$$exe"); \
	done

test:
	@./tests/smoke-test.sh

clean:
	rm -rf bin

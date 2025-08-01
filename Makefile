SHELL = /bin/bash

# Setting GOBIN makes 'go install' put the binary in the bin/ directory.
export GOBIN ?= $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/bin

STITCHMD = $(GOBIN)/stitchmd

# Keep these options in-sync with .github/workflows/ci.yml.
STITCHMD_ARGS = -o style.md -preface src/preface.txt src/SUMMARY.md

# Keep these options in-sync with .github/workflows/ci.yml.
STITCHMD_GOLANG_ARGS = -o styleguides/golang.md -preface styleguides/golang/src/preface.txt styleguides/golang/src/SUMMARY.md

# Keep these options in-sync with .github/workflows/ci.yml.
STITCHMD_TERRAFORM_ARGS = -o styleguides/terraform.md -preface styleguides/terraform/src/preface.txt styleguides/terraform/src/SUMMARY.md


.PHONY: all
all: style.md

.PHONY: lint
lint: $(STITCHMD)
	@DIFF=$$($(STITCHMD) -d $(STITCHMD_ARGS)); \
	if [[ -n "$$DIFF" ]]; then \
		echo "style.md is out of date:"; \
		echo "$$DIFF"; \
		false; \
	fi

style.md: $(STITCHMD) $(wildcard src/*)
	$(STITCHMD) $(STITCHMD_ARGS)

$(STITCHMD):
	go install go.abhg.dev/stitchmd@latest


golang.md: $(STITCHMD) $(wildcard styleguides/golang/src/*)
	$(STITCHMD) $(STITCHMD_GOLANG_ARGS)

terraform.md: $(STITCHMD) $(wildcard styleguides/terraform/src/*)
	$(STITCHMD) $(STITCHMD_TERRAFORM_ARGS)


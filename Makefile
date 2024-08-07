.PHONY: initialize setup activate install-prod install-dev install-python-3.9 tree cat format hooks

SHELL := /bin/bash
CONDA_PATH := ./.conda/bin

.PHONY:

echo:
	@echo $(PATH)

init: conda install-dev

conda:
	$(CONDA_BIN)/conda create --yes --prefix $(ENV_PREFIX) python=3.9 conda

install-dev:
	python -m pip install --upgrade pip
	$(CONDA_PATH)/conda env update --prefix $(ENV_PREFIX) -f environment.yml

setup:
	$(CONDA_PATH)/poetry lock --no-update
	$(CONDA_PATH)/poetry install --no-root

hooks:
	$(CONDA_PATH)/pre-commit install

format:
	$(CONDA_PATH)/black .

lint:
	$(CONDA_PATH)/flake8 src tests

test:
	$(CONDA_PATH)/pytest tests/

tree:
	scripts/tree.sh

cat:
	scripts/cat.sh

install:
	$(CONDA_PATH)/poetry build
	$(CONDA_PATH)/poetry install

clean:
# 	artifacts

clean-all: clean
	rm -rf .conda

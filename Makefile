.PHONY: initialize setup activate install-prod install-dev install-python-3.9 tree cat format hooks echo init conda-dev install-dev setup hooks format lint test install clean clean-all

CONDA_HOME := $(HOME)/anaconda3
CONDA_BIN := $(CONDA_HOME)/bin
CONDA_PATH := ./.conda/bin
ENV_PREFIX := $(CURDIR)/.conda

echo:
	@echo $(PATH)

init: conda-dev install-dev

conda-dev:
	$(CONDA_BIN)/conda create --yes --prefix $(ENV_PREFIX) python=3.9 conda

install-dev:
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
	# Add commands to clean artifacts here

clean-all: clean
	rm -rf .conda

.PHONY: initialize setup activate install-prod install-dev install-python-3.9 tree cat format hooks

SHELL := /bin/bash
CONDA_PATH := ./.conda/bin

.PHONY:

echo:
	@echo $(PATH)

init: install-python-3.9 conda install-dev

install-python-3.9:
	@echo "Installing Python 3.9 using pyenv"
	pyenv install --skip-existing 3.9.19
	@echo "Python 3.9 installed successfully"

conda:
	$(HOME)/anaconda3/bin/python -m conda create --yes --prefix .conda python=3.9

install-dev:
	$(CONDA_PATH)/pip install -r requirements-dev.txt
	@echo "activate conda environment by opening the project in vs code"

setup:
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

.PHONY: initialize setup activate install-prod install-dev install-python-3.9 tree cat format

SHELL := /bin/bash

.PHONY: 

init: install-python-3.9 conda install-dev setup 

install-python-3.9:
	@echo "Installing Python 3.9 using pyenv"
	pyenv install --skip-existing 3.9.19
	@echo "Python 3.9 installed successfully"

conda:
	conda create --prefix ./.conda python=3.9

install-dev:
	./.conda/bin/pip install -r requirements-dev.txt

setup:
	./.conda/bin/poetry install --no-root

format:
	prettier --write 'src/**/*.{py}'

tree:
	scripts/tree.sh

cat:
	scripts/cat.sh

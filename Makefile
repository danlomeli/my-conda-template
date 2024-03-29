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
	tree -a -I "poetry.lock|.git|__pycache__|*.pyc|*.pyo|*.pyd|.ipynb_checkpoints|profile_default|ipython_config.py|.pytest_cache|.mypy_cache|.flake8|.idea|.vscode|.DS_Store|*.csv|*.xlsx|*.json|*.txt|*.pkl|*.npy|*.npz|*.h5|*.hdf5|checkpoints|logs|*.pt|*.pth|*.ckpt|*.pb|mlruns|wandb|.env|.conda"

cat:
	@shopt -s nullglob dotglob; \
	find src/ -type f -print0 | while IFS= read -r -d '' file; do \
		echo -e "\\n***********\\nFilename: $$file\\nContent:\\n"; \
		cat "$$file"; \
	done

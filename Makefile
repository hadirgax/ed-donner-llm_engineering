PROJECT_NAME ?= default-project-name
VENV_NAME ?= venv
VENV_BIN_PATH ?= $$(conda info --base)/envs/$(VENV_NAME)/bin
VENV_PYTHON_VERSION ?= $$(grep -E '^\s*requires-python\s*=' pyproject.toml | sed -E 's/.*([0-9]+\.[0-9]+).*/\1/')

export ENVIRONMENT ?= local
export PYTHONPATH := ./
.PHONY: all


# ===== Environment =====

env-create:
	conda create -n $(VENV_NAME) -c conda-forge -y --no-default-packages

env-install:
	$(CONDA_EXE) install -n $(VENV_NAME) -c conda-forge -y python=$(VENV_PYTHON_VERSION)
	$(VENV_BIN_PATH)/pip install uv
	$(VENV_BIN_PATH)/uv pip install -r requirements.txt
	@echo "#\n# To activate this environment, use:\n#\n#\t$$ conda activate $(VENV_NAME)"
	@echo "#\n# To deactivate an active environment, use:\n#\n#\t$$ conda deactivate\n"

env-remove:
	conda remove -n $(VENV_NAME) --all -y

env-update:env-remove env-create env-install


# ===== Run =====

# ===== Test =====

# ===== Format =====

%:
	@:
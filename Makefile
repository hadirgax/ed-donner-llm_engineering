PROJECT_NAME ?= llmeng
VENV_NAME ?= $(PROJECT_NAME)
VENV_BIN_PATH ?= $$(conda info --base)/envs/$(VENV_NAME)/bin

export PYTHONPATH := ./
.PHONY: all


# ===== Environment =====

env-create:
	conda create -n $(VENV_NAME) -c conda-forge -y python=3.12 pip=24
	$(VENV_BIN_PATH)/python -m pip install uv

env-install: env-create
	$(VENV_BIN_PATH)/python -m uv pip install -r requirements.txt
	@echo "#\n# To activate this environment, use:\n#\n#\t$$ conda activate $(VENV_NAME)"
	@echo "#\n# To deactivate an active environment, use:\n#\n#\t$$ conda deactivate"

env-remove:
	conda remove -n $(VENV_NAME) --all -y

env-update:env-remove env-install


# ===== Run =====

# ===== Test =====

# ===== Format =====

%:
	@:
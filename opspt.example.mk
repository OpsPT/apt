# Example for a Github Repo, adapt as you need to. 
LATEST_RELEASE := $(shell curl -s https://api.github.com/repos/USER/REPO/releases/latest | grep "tag_name" | cut -d '"' -f 4) 
AVAILABLE_VERSION := $(shell tail -n 1 opspt.version) 

check_version:
	@if [ "$(LATEST_RELEASE)" != "$(AVAILABLE_VERSION)" ]; then \
		echo "New version available: $(LATEST_RELEASE)"; \
		sed -i 's/$(strip $(AVAILABLE_VERSION))/$(strip $(LATEST_RELEASE))/g' opspt.version; \
	fi

build_if_updated:
	@if ! git diff --name-only --exit-code opspt.version; then \
		make -f opspt.mk build; \
	fi

build:
	mkdir -p dist
	# Add your build commands here

OPSPT_FOLDER := "$(shell basename $(shell pwd))"
LATEST_RELEASE := $(shell curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep "tag_name" | cut -d '"' -f 4) 
AVAILABLE_VERSION := $(shell tail -n 1 opspt.version) 

check_version:
	@if [ "$(LATEST_RELEASE)" != "$(AVAILABLE_VERSION)" ]; then \
		echo "New version available: $(LATEST_RELEASE)"; \
		sed -i 's/$(strip $(AVAILABLE_VERSION))/$(strip $(LATEST_RELEASE))/g' opspt.version; \
	fi

build_if_updated:
	@echo "$(shell git show --oneline --name-only HEAD)"
	@if git show --oneline --name-only HEAD | grep $(OPSPT_FOLDER)/opspt.version; then \
		make -f opspt.mk build; \
	fi

build:
	mkdir -p dist
	wget https://github.com/derailed/k9s/releases/download/$(strip $(AVAILABLE_VERSION))/k9s_linux_amd64.deb  -O dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb
	wget https://github.com/derailed/k9s/releases/download/$(strip $(AVAILABLE_VERSION))/k9s_linux_arm64.deb  -O dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bullseye_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bullseye_arm64_$(strip $(AVAILABLE_VERSION)).deb

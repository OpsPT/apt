LATEST_RELEASE := $(shell curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep "tag_name" | cut -d '"' -f 4) 
AVAILABLE_VERSION := $(shell tail -n 1 opspt.version) 
COMMIT := $(shell git log -1 --pretty=format:%H -- opts.version)

check_version:
	@if [ "$(LATEST_RELEASE)" != "$(AVAILABLE_VERSION)" ]; then \
		echo "New version available: $(LATEST_RELEASE)"; \
		sed -i 's/$(strip $(AVAILABLE_VERSION))/$(strip $(LATEST_RELEASE))/g' opspt.version; \
	fi

build_if_updated:
	@if [ "$(COMMIT)" != "$(shell git rev-parse HEAD)" ]; then \
		make -f opspt.mk build; \
	fi

build:
	mkdir -p dist
	wget https://github.com/derailed/k9s/releases/download/$(strip $(AVAILABLE_VERSION))/k9s_linux_amd64.deb  -O dist/k9s_$(strip $(AVAILABLE_VERSION))

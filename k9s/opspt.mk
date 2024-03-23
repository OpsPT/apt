LATEST_RELEASE := $(shell curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep "tag_name" | cut -d '"' -f 4) 
AVAILABLE_VERSION := $(shell tail -n 1 opspt.version) 

check_version:
	@if [ "$(LATEST_RELEASE)" != "$(AVAILABLE_VERSION)" ]; then \
		echo "New version available: $(LATEST_RELEASE)"; \
		sed -i 's/$(strip $(AVAILABLE_VERSION))/$(strip $(LATEST_RELEASE))/g' opspt.version; \
		sed -i 's/BUILDED=TRUE/BUILDED=FALSE/g' opspt.version; \
	fi

build_if_updated:
	@if grep "BUILDED=FALSE" opspt.version; then \
		make -f opspt.mk build; \
	fi

build:
	sed -i 's/BUILDED=FALSE/BUILDED=TRUE/g' opspt.version; 
	mkdir -p dist
	wget https://github.com/derailed/k9s/releases/download/$(strip $(AVAILABLE_VERSION))/k9s_linux_amd64.deb  -O dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb
	wget https://github.com/derailed/k9s/releases/download/$(strip $(AVAILABLE_VERSION))/k9s_linux_arm64.deb  -O dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb
	# Debian
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bullseye_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bullseye_arm64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bookworm_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bookworm_arm64_$(strip $(AVAILABLE_VERSION)).deb
	# Ubuntu
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_jammy_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_jammy_arm64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_lunar_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_lunar_arm64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_mantic_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_mantic_arm64_$(strip $(AVAILABLE_VERSION)).deb

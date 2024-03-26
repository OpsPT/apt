LATEST_RELEASE := $(shell curl -s https://api.github.com/repos/gravitational/teleport/releases/latest | grep "tag_name" | cut -d '"' -f 4|sed 's/v//') 
AVAILABLE_VERSION := $(shell tail -n 1 opspt.version|sed 's/v//') 

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
	wget https://cdn.teleport.dev/teleport_$(strip $(AVAILABLE_VERSION))_amd64.deb  -O dist/teleport_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb
	wget https://cdn.teleport.dev/teleport_$(strip $(AVAILABLE_VERSION))_arm64.deb  -O dist/teleport_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb
	wget https://cdn.teleport.dev/teleport_$(strip $(AVAILABLE_VERSION))_i386.deb  -O dist/teleport_buster_i386_$(strip $(AVAILABLE_VERSION)).deb
	wget https://cdn.teleport.dev/teleport_$(strip $(AVAILABLE_VERSION))_arm.deb  -O dist/teleport_buster_arm_$(strip $(AVAILABLE_VERSION)).deb
	# Debian
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bullseye_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bullseye_arm64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bookworm_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bookworm_arm64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_i386_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bullseye_i386_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bullseye_arm_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_i386_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bookworm_i386_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_bookworm_arm_$(strip $(AVAILABLE_VERSION)).deb
	# Ubuntu
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_jammy_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_jammy_arm64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_lunar_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_lunar_arm64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_amd64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_mantic_amd64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm64_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_mantic_arm64_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_i386_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_jammy_i386_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_jammy_arm_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_i386_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_lunar_i386_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_lunar_arm_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_i386_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_mantic_i386_$(strip $(AVAILABLE_VERSION)).deb
	cp dist/k9s_buster_arm_$(strip $(AVAILABLE_VERSION)).deb dist/k9s_mantic_arm_$(strip $(AVAILABLE_VERSION)).deb

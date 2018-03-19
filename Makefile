PLIST := com.anonymous.fsync.plist
APP := fsync

# Verbose Option
ifeq ($(VERBOSE),1)
        Q :=
else
        Q := @
endif

.PHONY : install
install:
	@echo "[installing]     $(APP)"
	$(Q)cp $(APP) /usr/local/bin/fsync

.PHONY : start
start:
	@echo "[starting]       $(APP)"
	$(Q)sudo cp $(PLIST) ${HOME}/Library/LaunchAgents
	$(Q)launchctl load ${HOME}/Library/LaunchAgents/$(PLIST)

.PHONY : stop
stop:
	@echo "[stopping]       $(APP)"
	$(Q)launchctl unload ${HOME}/Library/LaunchAgents/$(PLIST)

.PHONY: help
help:
	@echo "make install - copies script to /usr/local/bin"
	@echo "make start   - will make our script run periodically"
	@echo "make stop    - stops our periodic script"

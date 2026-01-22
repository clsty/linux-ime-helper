# Makefile to install/uninstall the ydotoold systemd service

SERVICE_SRC=ydotoold-imehelper.service
SYSTEMD_UNIT_DIR=/etc/systemd/system

.PHONY: install uninstall help

help:
	@echo "Usage: make [install|uninstall]"

install:
	@echo "Installing ydotoold systemd service to $(SYSTEMD_UNIT_DIR)"
	sudo install -Dm644 $(SERVICE_SRC) $(SYSTEMD_UNIT_DIR)/$(SERVICE_SRC)
	sudo systemctl daemon-reload
	sudo systemctl enable --now $(SERVICE_SRC)
	@echo "$(SERVICE_SRC) installed and started. Edit the service to change UID/GID or socket path."

uninstall:
	@echo "Removing ydotoold systemd service"
	sudo systemctl disable --now $(SERVICE_SRC) || true
	sudo rm -f $(SYSTEMD_UNIT_DIR)/$(SERVICE_SRC)
	sudo systemctl daemon-reload
	@echo "$(SERVICE_SRC) removed"

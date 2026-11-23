.PHONY: default link copy status uninstall hook json

default: link

link:
	@./scripts/sync.sh link

copy:
	@./scripts/sync.sh copy

status:
	@./scripts/sync.sh status

uninstall:
	@./scripts/sync.sh uninstall

hook:
	@./scripts/sync.sh hook

json:
	@./scripts/sync.sh json

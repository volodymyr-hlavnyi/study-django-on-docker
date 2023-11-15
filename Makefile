.PHONY: init-configs
# Configuration files initialization
init-configs:
	@cp .env.dev .env && \
	cp docker-compose.override.dev.yml docker-compose.override.yml
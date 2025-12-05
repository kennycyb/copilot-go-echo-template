# Makefile for Go Echo Template
# Reference: https://makefiletutorial.com/

.PHONY: all build run test test-cover lint fmt vet clean install-tools help

# Variables
BINARY_NAME=server
CMD_PATH=./cmd/server
COVERAGE_FILE=coverage.out
COVERAGE_HTML=coverage.html

# Default target
all: lint test build

## Build
build: ## Build the application
	@echo "Building..."
	go build -v -o bin/$(BINARY_NAME) $(CMD_PATH)

run: ## Run the application
	@echo "Running..."
	go run $(CMD_PATH)

## Testing
test: ## Run tests
	@echo "Running tests..."
	go test -v ./...

test-ginkgo: ## Run tests with Ginkgo
	@echo "Running Ginkgo tests..."
	ginkgo -v ./...

test-cover: ## Run tests with coverage
	@echo "Running tests with coverage..."
	go test -v -coverprofile=$(COVERAGE_FILE) ./...
	go tool cover -func=$(COVERAGE_FILE)

test-cover-html: test-cover ## Generate HTML coverage report
	@echo "Generating coverage report..."
	go tool cover -html=$(COVERAGE_FILE) -o $(COVERAGE_HTML)
	@echo "Coverage report generated: $(COVERAGE_HTML)"

## Code Quality
lint: ## Run linter
	@echo "Running linter..."
	golangci-lint run ./...

lint-fix: ## Run linter with auto-fix
	@echo "Running linter with auto-fix..."
	golangci-lint run --fix ./...

fmt: ## Format code
	@echo "Formatting code..."
	go fmt ./...
	goimports -w .

vet: ## Run go vet
	@echo "Running go vet..."
	go vet ./...

## Dependencies
deps: ## Download dependencies
	@echo "Downloading dependencies..."
	go mod download

tidy: ## Tidy dependencies
	@echo "Tidying dependencies..."
	go mod tidy

## Development Tools
install-tools: ## Install development tools (uses @latest, consider pinning versions for team consistency)
	@echo "Installing development tools..."
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install github.com/onsi/ginkgo/v2/ginkgo@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/swaggo/swag/cmd/swag@latest

## Cleanup
clean: ## Clean build artifacts
	@echo "Cleaning..."
	rm -rf bin/
	rm -f $(COVERAGE_FILE)
	rm -f $(COVERAGE_HTML)

## Documentation
docs: ## Generate Swagger documentation
	@echo "Generating Swagger docs..."
	swag init -g $(CMD_PATH)/main.go

## Help
help: ## Show this help
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

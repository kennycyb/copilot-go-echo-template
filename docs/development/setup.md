# Development Environment Setup

This guide explains how to set up your development environment for the Go Echo template project.

## Prerequisites

### Required Software

1. **Go 1.21+**
   ```bash
   # Check Go version
   go version
   
   # Install via official installer or package manager
   # macOS: brew install go
   # Ubuntu: sudo apt install golang-go
   # Windows: Use official installer from https://golang.org/dl/
   ```

2. **Git**
   ```bash
   git --version
   ```

3. **VS Code** (recommended)
   - Download from https://code.visualstudio.com/
   - Or use any Go-compatible IDE

## Installation Steps

### 1. Clone Repository

```bash
git clone https://github.com/your-org/copilot-go-echo-template.git
cd copilot-go-echo-template
```

### 2. Install Go Dependencies

```bash
go mod download
```

### 3. Install Development Tools

```bash
# Using Makefile
make install-tools

# Or manually
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/onsi/ginkgo/v2/ginkgo@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/swaggo/swag/cmd/swag@latest
```

### 4. VS Code Setup

1. Open the project in VS Code:
   ```bash
   code .
   ```

2. Install recommended extensions when prompted (or manually from `.vscode/extensions.json`)

3. Restart VS Code after installing extensions

4. Enable GitHub Copilot Chat for agent access

## Environment Configuration

### Environment Variables

Create a `.env` file for local development:

```bash
# Server configuration
PORT=8080
ENV=development

# Database (example)
# DB_HOST=localhost
# DB_PORT=5432
# DB_NAME=myapp
# DB_USER=postgres
# DB_PASSWORD=secret

# Add other environment variables as needed
```

### VS Code Settings

The project includes preconfigured VS Code settings in `.vscode/settings.json`:

- Go language server enabled
- golangci-lint as linter
- goimports as formatter
- Coverage highlighting
- Auto-format on save

## Verification

Run these commands to verify your setup:

```bash
# Build the project
make build

# Run tests
make test

# Run linter
make lint

# Check all tools
make help
```

## Common Issues

### golangci-lint not found

```bash
# Ensure GOPATH/bin is in PATH
export PATH=$PATH:$(go env GOPATH)/bin

# Reinstall
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

### Go modules issues

```bash
# Clean module cache
go clean -modcache

# Re-download dependencies
go mod download
```

### VS Code Go extension issues

1. Open Command Palette (Ctrl+Shift+P)
2. Run "Go: Install/Update Tools"
3. Select all tools and install

## Next Steps

1. Read the [README.md](../README.md) for project overview
2. Understand the [agent workflow](../README.md#agent-workflow)
3. Review agent prompts in `.github/agents/`
4. Start with `@product` to define requirements

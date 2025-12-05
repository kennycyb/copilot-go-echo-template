# copilot-go-echo-template

A Go Echo API template project with GitHub Copilot agent-driven development workflow.

## Overview

This template provides a structured approach to Go Echo web application development using specialized GitHub Copilot agents. Each agent has a specific role in the development lifecycle, ensuring consistent quality and documentation.

## Agent Workflow

```
┌─────────────┐     ┌─────────┐     ┌─────────┐     ┌─────────┐     ┌──────────┐     ┌─────────┐
│  @product   │────▶│  @dev   │────▶│  @test  │────▶│  @lint  │────▶│  @review │────▶│  @docs  │
│ Requirements│     │  Code   │     │  Tests  │     │ Quality │     │  Review  │     │  Docs   │
└─────────────┘     └─────────┘     └─────────┘     └─────────┘     └──────────┘     └─────────┘
```

### Agents

| Agent | Purpose | Output Location |
|-------|---------|-----------------|
| **@product** | Define requirements and business logic | `docs/requirements/` |
| **@dev** | Implement Go Echo code | `cmd/`, `internal/`, `pkg/` |
| **@test** | Write tests (Ginkgo, >90% coverage) | `*_test.go`, `tests/` |
| **@lint** | Run linters and fix issues | `.golangci.yml` config |
| **@review** | Code review and quality checks | PR comments |
| **@docs** | Documentation and API specs | `docs/` |

## Project Structure

```
.
├── .github/
│   └── agents/              # Agent prompt definitions
│       ├── product.md       # @product agent
│       ├── dev.md           # @dev agent
│       ├── test.md          # @test agent
│       ├── lint.md          # @lint agent
│       ├── review.md        # @review agent
│       └── docs.md          # @docs agent
├── .vscode/                 # VS Code configuration
│   ├── settings.json        # Editor settings
│   ├── extensions.json      # Recommended extensions
│   ├── launch.json          # Debug configurations
│   └── tasks.json           # Build/test tasks
├── cmd/
│   └── server/
│       └── main.go          # Application entry point
├── internal/
│   ├── config/              # Configuration management
│   ├── handlers/            # HTTP handlers
│   ├── middleware/          # Custom middleware
│   ├── models/              # Data models
│   ├── repository/          # Data access layer
│   └── services/            # Business logic
├── pkg/                     # Reusable packages
├── docs/
│   ├── requirements/        # Requirements (@product output)
│   ├── api/                 # API documentation
│   ├── architecture/        # Architecture docs and ADRs
│   ├── development/         # Development guides
│   └── deployment/          # Deployment docs
├── tests/
│   ├── integration/         # Integration tests
│   └── e2e/                 # End-to-end tests
├── .golangci.yml            # Linter configuration
├── go.mod
├── go.sum
├── Makefile
└── README.md
```

## Getting Started

### Prerequisites

- Go 1.21 or later
- golangci-lint
- Ginkgo v2 (for BDD tests)
- VS Code with Go extension

### Installation

```bash
# Clone the repository
git clone https://github.com/your-org/copilot-go-echo-template.git
cd copilot-go-echo-template

# Install dependencies
go mod download

# Install development tools
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/onsi/ginkgo/v2/ginkgo@latest
```

### Development

```bash
# Run the server
go run ./cmd/server

# Run tests
go test -v ./...

# Run tests with Ginkgo
ginkgo -v ./...

# Run tests with coverage
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out

# Run linter
golangci-lint run ./...

# Format code
go fmt ./...
```

## Using the Agents

### 1. Define Requirements (@product)

Start by defining requirements with the @product agent:

```
@product Create requirements for a user registration endpoint
```

The agent will:
- Create a requirements document in `docs/requirements/`
- Define acceptance criteria
- Specify API contracts
- Hand off to @dev when complete

### 2. Implement Code (@dev)

The @dev agent implements the requirements:

```
@dev Implement the user registration endpoint based on docs/requirements/features/FEAT-001-user-registration.md
```

The agent will:
- Write production Go code
- Follow Echo framework patterns
- Create necessary handlers, services, and models
- Hand off to @test when complete

### 3. Write Tests (@test)

The @test agent creates comprehensive tests:

```
@test Write tests for the user registration handler
```

The agent will:
- Write Ginkgo BDD-style tests
- Ensure >90% code coverage
- Test success and error paths
- Hand off to @lint when complete

### 4. Run Linting (@lint)

The @lint agent ensures code quality:

```
@lint Check and fix code quality issues
```

The agent will:
- Run golangci-lint
- Fix auto-fixable issues
- Document justified exceptions
- Hand off to @review when complete

### 5. Code Review (@review)

The @review agent performs a thorough review:

```
@review Review the user registration implementation
```

The agent will:
- Check code quality and architecture
- Identify security concerns
- Verify test coverage
- Hand off to @docs when approved

### 6. Update Documentation (@docs)

The @docs agent maintains documentation:

```
@docs Update API documentation for the user registration endpoint
```

The agent will:
- Update API documentation
- Add code comments
- Update README if needed
- Complete the development cycle

## VS Code Integration

This template includes VS Code configurations for optimal Go development:

### Recommended Extensions

Install recommended extensions when prompted, or manually:

- **Go** - Official Go extension
- **GitHub Copilot** - AI pair programmer
- **GitHub Copilot Chat** - Chat with agents
- **GitLens** - Enhanced Git integration
- **YAML** - YAML language support
- **Docker** - Container support

### Tasks (Ctrl+Shift+B)

- `Go: Build` - Build the project
- `Go: Test` - Run all tests
- `Go: Test with Coverage` - Run tests with coverage
- `Ginkgo: Run Tests` - Run Ginkgo tests
- `Go: Lint` - Run linter

### Debug Configurations (F5)

- `Launch Server` - Start the Echo server
- `Debug Current Test File` - Debug current test
- `Debug Test Package` - Debug package tests

## Configuration

### golangci-lint

Create `.golangci.yml` based on the template in `.github/agents/lint.md`.

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Server port | `8080` |
| `ENV` | Environment (development/production) | `development` |

## Testing

This project uses Ginkgo v2 for BDD-style testing:

```bash
# Install Ginkgo
go install github.com/onsi/ginkgo/v2/ginkgo@latest

# Generate test suite
ginkgo bootstrap

# Generate test file
ginkgo generate handler

# Run tests
ginkgo -v ./...

# Run with coverage
ginkgo --cover --coverprofile=coverage.out ./...
```

### Coverage Requirements

- Overall: >90%
- Business logic: 100%
- Handlers: All response codes tested
- Services: All edge cases tested

## Contributing

1. Define requirements with @product
2. Implement with @dev
3. Test with @test
4. Lint with @lint
5. Review with @review
6. Document with @docs

## License

MIT License - see [LICENSE](LICENSE) for details
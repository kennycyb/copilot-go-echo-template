# Testing Guide

This guide covers testing practices and conventions for the Go Echo template project.

## Testing Framework

We use **Ginkgo v2** with **Gomega** for BDD-style testing:

- **Ginkgo**: BDD testing framework for Go
- **Gomega**: Matcher library with readable assertions

## Installation

```bash
go install github.com/onsi/ginkgo/v2/ginkgo@latest
go get github.com/onsi/gomega
```

## Test Structure

### Unit Tests (Next to Source)

```
internal/
├── handlers/
│   ├── user_handler.go
│   └── user_handler_test.go
├── services/
│   ├── user_service.go
│   └── user_service_test.go
```

### Integration & E2E Tests

```
tests/
├── integration/
│   └── api_test.go
└── e2e/
    └── user_flow_test.go
```

## Writing Tests

### Basic Ginkgo Test

```go
package handlers_test

import (
    "testing"
    
    . "github.com/onsi/ginkgo/v2"
    . "github.com/onsi/gomega"
)

func TestHandlers(t *testing.T) {
    RegisterFailHandler(Fail)
    RunSpecs(t, "Handlers Suite")
}

var _ = Describe("UserHandler", func() {
    Describe("GetUser", func() {
        Context("when user exists", func() {
            It("returns the user", func() {
                // Test code
                Expect(result).To(Equal(expected))
            })
        })
        
        Context("when user does not exist", func() {
            It("returns not found error", func() {
                // Test code
                Expect(err).To(HaveOccurred())
            })
        })
    })
})
```

### Testing Echo Handlers

```go
package handlers_test

import (
    "net/http"
    "net/http/httptest"
    
    "github.com/labstack/echo/v4"
    . "github.com/onsi/ginkgo/v2"
    . "github.com/onsi/gomega"
)

var _ = Describe("HealthHandler", func() {
    var (
        e   *echo.Echo
        rec *httptest.ResponseRecorder
    )
    
    BeforeEach(func() {
        e = echo.New()
        rec = httptest.NewRecorder()
    })
    
    Describe("GET /health", func() {
        It("returns 200 OK", func() {
            req := httptest.NewRequest(http.MethodGet, "/health", nil)
            c := e.NewContext(req, rec)
            
            handler := NewHealthHandler()
            err := handler.Health(c)
            
            Expect(err).NotTo(HaveOccurred())
            Expect(rec.Code).To(Equal(http.StatusOK))
        })
    })
})
```

### Mocking Dependencies

```go
// Using interfaces for testability
type UserService interface {
    GetUser(ctx context.Context, id string) (*User, error)
}

// Mock implementation
type MockUserService struct {
    GetUserFunc func(ctx context.Context, id string) (*User, error)
}

func (m *MockUserService) GetUser(ctx context.Context, id string) (*User, error) {
    return m.GetUserFunc(ctx, id)
}

// In tests
var _ = Describe("UserHandler", func() {
    var mockService *MockUserService
    
    BeforeEach(func() {
        mockService = &MockUserService{
            GetUserFunc: func(ctx context.Context, id string) (*User, error) {
                return &User{ID: id, Name: "Test"}, nil
            },
        }
    })
})
```

## Running Tests

### Basic Commands

```bash
# Run all tests
make test

# Run with Ginkgo
make test-ginkgo

# Run with coverage
make test-cover

# Generate HTML coverage report
make test-cover-html
```

### Ginkgo Commands

```bash
# Run all tests verbosely
ginkgo -v ./...

# Run specific package
ginkgo -v ./internal/handlers/...

# Watch mode
ginkgo watch -v ./...

# Run with coverage
ginkgo --cover --coverprofile=coverage.out ./...

# Skip slow tests
ginkgo --skip-package=e2e ./...
```

## Coverage Requirements

| Scope | Minimum |
|-------|---------|
| Overall | 90% |
| Business Logic | 100% |
| Handlers | All response codes |
| Services | All edge cases |

### Viewing Coverage

```bash
# Generate and open coverage report
make test-cover-html
open coverage.html  # macOS
xdg-open coverage.html  # Linux
```

## Test Categories

### Unit Tests
- Fast (<1s per test)
- Isolated (no external dependencies)
- Located next to source files
- Run frequently during development

### Integration Tests
- Test component interactions
- May use test containers
- Located in `tests/integration/`
- Run before commits

### E2E Tests
- Full user workflow tests
- Run against test server
- Located in `tests/e2e/`
- Run before releases

## Best Practices

1. **Test Behavior, Not Implementation**
   - Focus on what the code does, not how

2. **Use Descriptive Names**
   - `Describe`, `Context`, `It` should read like documentation

3. **One Assertion Per Test**
   - When practical, keeps tests focused

4. **Clean Up After Tests**
   - Use `AfterEach` for cleanup

5. **Table-Driven Tests**
   - For testing similar scenarios with different inputs

6. **Mock External Dependencies**
   - Keep tests fast and reliable

## Table-Driven Tests with Ginkgo

```go
var _ = Describe("Validator", func() {
    DescribeTable("email validation",
        func(email string, shouldBeValid bool) {
            result := ValidateEmail(email)
            Expect(result).To(Equal(shouldBeValid))
        },
        Entry("valid email", "test@example.com", true),
        Entry("missing @", "testexample.com", false),
        Entry("missing domain", "test@", false),
        Entry("missing local part", "@example.com", false),
    )
})
```

## Integration with VS Code

Use VS Code tasks for testing:

1. **Ctrl+Shift+B** → Select test task
2. Or use the Testing sidebar (beaker icon)
3. Debug tests with F5 using launch configurations

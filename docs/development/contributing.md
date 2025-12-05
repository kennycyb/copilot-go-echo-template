# Contributing Guide

Thank you for considering contributing to this project! This guide explains our development workflow using GitHub Copilot agents.

## Development Workflow

Our project uses specialized GitHub Copilot agents for different phases of development:

```
@product → @dev → @test → @lint → @review → @docs
```

### 1. Requirements Phase (@product)

Before writing any code, define requirements:

1. Use `@product` to create requirements
2. Documents are created in `docs/requirements/`
3. Include acceptance criteria and API specs
4. Get requirements reviewed before proceeding

### 2. Implementation Phase (@dev)

Implement the feature:

1. Use `@dev` to implement the code
2. Follow project structure and coding standards
3. Ensure code is testable with dependency injection
4. Self-review before handoff to testing

### 3. Testing Phase (@test)

Write comprehensive tests:

1. Use `@test` to create tests
2. Achieve >90% code coverage
3. Test all success and error paths
4. Use Ginkgo BDD-style tests

### 4. Linting Phase (@lint)

Ensure code quality:

1. Use `@lint` to check code
2. Fix all auto-fixable issues
3. Document any justified lint suppressions

### 5. Review Phase (@review)

Get code reviewed:

1. Use `@review` for code review
2. Address all critical feedback
3. Ensure architecture and security concerns are addressed

### 6. Documentation Phase (@docs)

Update documentation:

1. Use `@docs` to update documentation
2. Document new APIs and features
3. Update README if needed

## Code Standards

### Go Code Style

- Follow official Go style guide
- Use meaningful names
- Keep functions small (<50 lines)
- Document exported functions
- Handle all errors explicitly

### Project Structure

```
cmd/server/main.go          # Entry point
internal/handlers/          # HTTP handlers
internal/services/          # Business logic
internal/repository/        # Data access
internal/models/            # Data models
```

### Testing Standards

- Use Ginkgo/Gomega for tests
- Achieve >90% coverage
- Test all error paths
- Use table-driven tests for similar cases

## Pull Request Process

1. **Create Feature Branch**
   ```bash
   git checkout -b feature/your-feature
   ```

2. **Make Changes**
   - Follow the agent workflow
   - Make small, focused commits

3. **Run Quality Checks**
   ```bash
   make lint
   make test
   ```

4. **Open Pull Request**
   - Reference related issues
   - Describe changes clearly
   - Include testing notes

5. **Address Review Feedback**
   - Respond to all comments
   - Make requested changes

6. **Merge**
   - Squash and merge preferred
   - Delete feature branch after merge

## Commit Messages

Use conventional commits:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `test`: Tests
- `refactor`: Code refactoring
- `chore`: Maintenance

Examples:
```
feat(handlers): add user registration endpoint
fix(services): handle nil user in GetUser
docs(api): add authentication documentation
test(handlers): add tests for health endpoint
```

## Getting Help

- Check existing documentation in `docs/`
- Review agent prompts in `.github/agents/`
- Ask questions in issues or discussions

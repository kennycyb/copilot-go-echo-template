# Requirements Documentation

This directory contains all product requirements and specifications managed by the **@product** agent.

## Structure

```
requirements/
├── features/     # Feature specifications
├── api/          # API endpoint specifications
└── stories/      # User stories and acceptance criteria
```

## Naming Convention

- Feature specs: `FEAT-###-feature-name.md`
- API specs: `API-###-endpoint-name.md`
- User stories: `STORY-###-story-title.md`

## Template Usage

See the agent prompt at `.github/agents/product.md` for document templates and guidelines.

## Workflow

1. **@product** creates requirements documents here
2. **@dev** implements based on these requirements
3. **@test** validates against acceptance criteria
4. Documents are updated as requirements evolve

#!/bin/bash
# Create development directory documentation

echo "Creating development directory documentation..."

# Create README files to document structure
cat > ~/dev/README.md << 'EOF'
# Development Directory Structure

## Overview
This is the main development directory with organized subdirectories for different types of projects.

## Directory Structure

```
~/dev/
├── projects/          # Main development work
│   ├── personal/      # Personal projects
│   │   ├── python/    # Python projects
│   │   ├── javascript/# JavaScript projects
│   │   ├── rust/      # Rust projects
│   │   ├── go/        # Go projects
│   │   ├── java/      # Java projects
│   │   ├── cpp/       # C++ projects
│   │   └── web/       # Web projects
│   ├── work/          # Work-related projects
│   ├── learning/      # Educational projects
│   │   ├── courses/   # Online courses
│   │   ├── tutorials/ # Tutorial projects
│   │   ├── books/     # Book examples
│   │   └── challenges/# Coding challenges
│   └── experiments/   # Experimental code
├── sandbox/           # Temporary/test code
│   ├── quick-tests/   # Quick test scripts
│   ├── prototypes/    # Proof of concepts
│   └── playground/    # Learning playground
├── forks/            # Forked repositories
├── archive/          # Archived projects
├── tools/            # Development tools
│   ├── scripts/      # Utility scripts
│   ├── configs/      # Configuration files
│   └── templates/    # Project templates
└── scripts/          # Global scripts
```

## Best Practices

1. **Project Naming**: Use kebab-case (my-project-name)
2. **Version Control**: Initialize git for all projects
3. **Documentation**: Every project should have a README.md
4. **Archive**: Move inactive projects to archive/
5. **Forks**: Keep forks separate from original work

## Quick Commands

- New project: `mkproject <name>`
- Archive project: `archiveproject <name>`
- List projects: `lsp`
EOF

echo "Documentation created at ~/dev/README.md"

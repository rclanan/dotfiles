#!/bin/bash
# Development directory structure setup script

echo "Setting up development directory structure..."

# Main development directories
mkdir -p ~/dev/{projects,sandbox,forks,archive,tools,scripts}
mkdir -p ~/dev/projects/{personal,work,learning,experiments}
mkdir -p ~/dev/sandbox/{quick-tests,prototypes,playground}
mkdir -p ~/dev/tools/{scripts,configs,templates}

# Language-specific directories
mkdir -p ~/dev/projects/personal/{python,javascript,rust,go,java,cpp,web,typescript,docker}
mkdir -p ~/dev/projects/learning/{courses,tutorials,books,challenges}
mkdir -p ~/dev/projects/work/{python,rust,typescript,docker}

# Supporting directories
mkdir -p ~/Documents/{specs,designs,notes,references}
mkdir -p ~/backups/{code,configs,databases}

echo "Development directory structure created successfully!"
echo "Location: ~/dev/"
echo ""
echo "Next steps:"
echo "1. Run: ./setup/setup-dev-docs.sh  # Create documentation"
echo "2. Run: ./setup/setup-gitignore-templates.sh  # Create gitignore templates"
echo "3. Run: ./setup/setup-dev-aliases.sh  # Add helpful shell aliases"

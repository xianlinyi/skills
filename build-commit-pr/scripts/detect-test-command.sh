#!/usr/bin/env bash
set -euo pipefail

# Print a best-effort test command for common project types.
# Exit code 0 means a command was found and printed.
# Exit code 1 means no supported command could be inferred.

if [ -f package.json ]; then
  if command -v jq >/dev/null 2>&1; then
    if jq -e '.scripts.test' package.json >/dev/null 2>&1; then
      if command -v pnpm >/dev/null 2>&1; then
        printf 'pnpm test\n'
        exit 0
      fi
      if command -v yarn >/dev/null 2>&1; then
        printf 'yarn test\n'
        exit 0
      fi
      if command -v npm >/dev/null 2>&1; then
        printf 'npm test\n'
        exit 0
      fi
    fi
  else
    if grep -q '"test"[[:space:]]*:' package.json; then
      if command -v pnpm >/dev/null 2>&1; then
        printf 'pnpm test\n'
        exit 0
      fi
      if command -v yarn >/dev/null 2>&1; then
        printf 'yarn test\n'
        exit 0
      fi
      if command -v npm >/dev/null 2>&1; then
        printf 'npm test\n'
        exit 0
      fi
    fi
  fi
fi

if [ -f Makefile ] && grep -Eiq '^[[:space:]]*test:' Makefile; then
  printf 'make test\n'
  exit 0
fi

if [ -f pom.xml ] && command -v mvn >/dev/null 2>&1; then
  printf 'mvn -q test\n'
  exit 0
fi

if [ -f build.gradle ] || [ -f build.gradle.kts ]; then
  if [ -x ./gradlew ]; then
    printf './gradlew test\n'
    exit 0
  fi
  if command -v gradle >/dev/null 2>&1; then
    printf 'gradle test\n'
    exit 0
  fi
fi

if [ -f Cargo.toml ] && command -v cargo >/dev/null 2>&1; then
  printf 'cargo test\n'
  exit 0
fi

if [ -f go.mod ] && command -v go >/dev/null 2>&1; then
  printf 'go test ./...\n'
  exit 0
fi

if [ -f pyproject.toml ] || [ -f requirements.txt ] || [ -f setup.py ]; then
  if command -v pytest >/dev/null 2>&1; then
    printf 'pytest\n'
    exit 0
  fi
  if command -v python >/dev/null 2>&1; then
    printf 'python -m pytest\n'
    exit 0
  fi
fi

exit 1

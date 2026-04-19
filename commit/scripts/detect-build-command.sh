#!/usr/bin/env bash
set -euo pipefail

# Print a best-effort build command for common JS/TS projects.
# Exit code 0 means a command was found and printed.
# Exit code 1 means no supported command could be inferred.

if [ -f package.json ]; then
  if command -v jq >/dev/null 2>&1; then
    if jq -e '.scripts.build' package.json >/dev/null 2>&1; then
      if command -v pnpm >/dev/null 2>&1; then
        printf 'pnpm build\n'
        exit 0
      fi
      if command -v yarn >/dev/null 2>&1; then
        printf 'yarn build\n'
        exit 0
      fi
      if command -v npm >/dev/null 2>&1; then
        printf 'npm run build\n'
        exit 0
      fi
    fi
  else
    if grep -q '"build"[[:space:]]*:' package.json; then
      if command -v pnpm >/dev/null 2>&1; then
        printf 'pnpm build\n'
        exit 0
      fi
      if command -v yarn >/dev/null 2>&1; then
        printf 'yarn build\n'
        exit 0
      fi
      if command -v npm >/dev/null 2>&1; then
        printf 'npm run build\n'
        exit 0
      fi
    fi
  fi
fi

if [ -f Makefile ] && grep -Eiq '^[[:space:]]*build:' Makefile; then
  printf 'make build\n'
  exit 0
fi

if [ -f pom.xml ] && command -v mvn >/dev/null 2>&1; then
  printf 'mvn -q -DskipTests package\n'
  exit 0
fi

if [ -f build.gradle ] || [ -f build.gradle.kts ]; then
  if [ -x ./gradlew ]; then
    printf './gradlew build -x test\n'
    exit 0
  fi
  if command -v gradle >/dev/null 2>&1; then
    printf 'gradle build -x test\n'
    exit 0
  fi
fi

if [ -f Cargo.toml ] && command -v cargo >/dev/null 2>&1; then
  printf 'cargo build\n'
  exit 0
fi

if [ -f pyproject.toml ] && command -v python >/dev/null 2>&1; then
  printf 'python -m build\n'
  exit 0
fi

exit 1

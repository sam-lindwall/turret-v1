#!/usr/bin/env bash
# Run this from the ROOT of your Turret V1 project (where firmware/ and pi/ live).
# It initializes a local git repo, drops in README + .gitignore, and makes the first commit.

set -e

# 1. init
git init

# 2. make sure README and .gitignore are present in this dir before running
#    (copy them here first, or this script assumes they're already alongside your project)

# 3. recommended folder layout (create if missing, harmless if they exist)
mkdir -p firmware pi docs

# 4. stage everything (respecting .gitignore)
git add .

# 5. first commit
git commit -m "V1: end-to-end UART command link validated

- STM32 parses f/r/s + 0-999 power commands over USART1
- TB6612FNG direction + PWM control
- USB debug echo back to Pi over USART2
- turret_link.py sends commands and prints echo
- star-ground wiring, ~21kHz PWM"

echo ""
echo "Local repo created and first commit made."
echo ""
echo "Next: create an empty repo on GitHub named 'turret-v1' (no README/gitignore),"
echo "then connect and push:"
echo ""
echo "  git remote add origin git@github.com:<your-username>/turret-v1.git"
echo "  git branch -M main"
echo "  git push -u origin main"

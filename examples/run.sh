#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_creation_camp info
PYTHONPATH=src python -m gbt_creation_camp check --payload '{}'
PYTHONPATH=src python -m gbt_creation_camp run   --payload '{}'

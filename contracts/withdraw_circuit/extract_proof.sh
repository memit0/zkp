#!/bin/bash

# Extract proof and public inputs for withdraw circuit
# Public inputs: root, id (2 fields × 32 bytes = 64 bytes)

PROOF_FILE="./target/proof"

if [ ! -f "$PROOF_FILE" ]; then
    echo "Error: Proof file not found at $PROOF_FILE"
    exit 1
fi

echo "=== Withdraw Circuit - Proof Extraction ==="
echo ""

# Extract all public inputs (first 64 bytes)
PUBLIC_INPUTS_HEX=$(head -c 64 "$PROOF_FILE" | od -An -v -t x1 | tr -d ' \n')

# Split into individual fields (64 hex chars = 32 bytes each)
ROOT="0x${PUBLIC_INPUTS_HEX:0:64}"
ID="0x${PUBLIC_INPUTS_HEX:64:64}"

echo "Public Inputs:"
echo "  root: $ROOT"
echo "  id:   $ID"
echo ""

# Extract proof (skip first 64 bytes)
PROOF="0x$(dd if="$PROOF_FILE" bs=1 skip=64 2>/dev/null | od -An -v -t x1 | tr -d ' \n')"

echo "Proof:"
echo "  $PROOF"
echo ""

# Output for easy copying
echo "=== For Contract Call ==="
echo "Proof: $PROOF"
echo "Public Inputs Array: [$ROOT, $ID]"

#!/bin/bash

# Extract proof and public inputs for deposit circuit
# Public inputs: oldRoot, newRoot, commitment, index (4 fields × 32 bytes = 128 bytes)

PROOF_FILE="./target/proof"

if [ ! -f "$PROOF_FILE" ]; then
    echo "Error: Proof file not found at $PROOF_FILE"
    exit 1
fi

echo "=== Deposit Circuit - Proof Extraction ==="
echo ""

# Extract all public inputs (first 128 bytes)
PUBLIC_INPUTS_HEX=$(head -c 128 "$PROOF_FILE" | od -An -v -t x1 | tr -d ' \n')

# Split into individual fields (64 hex chars = 32 bytes each)
OLD_ROOT="0x${PUBLIC_INPUTS_HEX:0:64}"
NEW_ROOT="0x${PUBLIC_INPUTS_HEX:64:64}"
COMMITMENT="0x${PUBLIC_INPUTS_HEX:128:64}"
INDEX="0x${PUBLIC_INPUTS_HEX:192:64}"

echo "Public Inputs:"
echo "  oldRoot:    $OLD_ROOT"
echo "  newRoot:    $NEW_ROOT"
echo "  commitment: $COMMITMENT"
echo "  index:      $INDEX"
echo ""

# Extract proof (skip first 128 bytes)
PROOF="0x$(dd if="$PROOF_FILE" bs=1 skip=128 2>/dev/null | od -An -v -t x1 | tr -d ' \n')"

echo "Proof:"
echo "  $PROOF"
echo ""

# Output for easy copying
echo "=== For Contract Call ==="
echo "Proof: $PROOF"
echo "Public Inputs Array: [$OLD_ROOT, $NEW_ROOT, $COMMITMENT, $INDEX]"

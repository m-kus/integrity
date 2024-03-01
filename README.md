# Cairo Verifier

![Cairo Verifier](https://github.com/HerodotusDev/cairo-verifier/assets/46165861/8692dfc1-f267-4c7e-9af0-4ceaeec84207)

## Building the Verifier

To build the Cairo Verifier, follow these steps:

1. Build the project by running the following command in your terminal:

```bash
scarb build
```

2. Test the project to ensure everything works correctly:

```bash
scarb test
```

## Running the Verifier

### Local Proof Verification

For local proof verification, follow these steps:

1. Build the verifier:

```bash
scarb build
```

2. Run the verifier locally using the following command:

```bash
cargo run --release --bin runner -- target/dev/cairo_verifier.sierra.json < examples/proofs/example_proof.json
```

### Starknet Proof Verification

To verify proofs on Starknet, proceed with the following steps:

1. Prepare calldata for sncast:

```bash
cargo run --release --bin snfoundry_proof_serializer < examples/proofs/example_proof.json > examples/starknet/calldata
```

2. Call the function with calldata on the Starknet contract:

```bash
cd examples/starknet
./call_contract.sh calldata
```

## Creating a Proof

To create a proof, perform the following steps:

1. Install stone-prover (restart your shell after installation):

```bash
git clone --recurse-submodules https://github.com/Moonsong-Labs/stone-prover-sdk.git
cd stone-prover-sdk
bash scripts/install-stone.sh
```

2. Install cairo-lang:

```bash
pip install cairo-lang==0.12.0
```

3. Compile a Cairo program, for example, the Fibonacci program:

```bash
cd examples/prover
cairo-compile fibonacci.cairo --output fibonacci_compiled.json --proof_mode
```

4. Run the Cairo program:

```bash
cairo-run \
    --program=fibonacci_compiled.json \
    --layout=recursive \
    --program_input=fibonacci_input.json \
    --air_public_input=fibonacci_public_input.json \
    --air_private_input=fibonacci_private_input.json \
    --trace_file=fibonacci_trace.bin \
    --memory_file=fibonacci_memory.bin \
    --print_output \
    --proof_mode
```

5. Prove the Cairo program:

```bash
cpu_air_prover \
    --out_file=../proofs/fibonacci_proof.json \
    --private_input_file=fibonacci_private_input.json \
    --public_input_file=fibonacci_public_input.json \
    --prover_config_file=cpu_air_prover_config.json \
    --parameter_file=cpu_air_params.json \
    --generate_annotations
```

You can `verify` this the proof `locally` or on the `Starknet Cairo verifier` contract by specifying the path `examples/proofs/fibonacci_proof.json` to the newly generated proof.

## Changing the Hasher

By default, the verifier uses Pedersen for verifier-friendly layers and Keccak for unfriendly layers. To change the hasher for unfriendly layers, use the provided Python script:

### Change to Blake2s

To change the hasher for unfriendly layers to Blake2s, run the following command:

```bash
python3 change_hasher.py -t blake
```

### Change to Keccak256

To change the hasher for unfriendly layers to Keccak256, run the following command:

```bash
python3 change_hasher.py -t keccak
```

---
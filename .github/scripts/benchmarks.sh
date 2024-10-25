set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/../..
# Build all servers and capture output
./scripts/build_all.sh > build_output.txt

# Run benchmarks and capture output
./scripts/run_all.sh > test_output.txt

python $SCRIPT_DIR/update_readme.py
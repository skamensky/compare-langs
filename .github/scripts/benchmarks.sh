set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/../..
# Build all servers and capture output
BUILD_OUTPUT=$(./build_all.sh)

# Run benchmarks and capture output
TEST_OUTPUT=$(./run_all.sh)

echo "$BUILD_OUTPUT" > build_output.txt
echo "$TEST_OUTPUT" > test_output.txt

python $SCRIPT_DIR/update_readme.py
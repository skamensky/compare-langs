#!/bin/bash
set -e
set +m
server_pid=0

# for some reason a process dying and lsof -i showing the port no longer in use still causes a bind error
# sometimes, so we just use a different port for each test
CURRENT_PORT=3001
results=()
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

src=$(realpath -s --relative-to=$SCRIPT_DIR/.. src)
bin=$(realpath -s --relative-to=$SCRIPT_DIR/.. bin)
run_test(){
    working_dir=$1
    command=$2
    cwd=$(realpath .)
    run_test_script=$cwd/scripts/run_test.sh 
    cd "$working_dir"
    export HTTP_SERVER_PORT=$CURRENT_PORT
    $command &> /dev/null &
    server_pid=$!
    # write the pid to a file so we can kill it in case of an error:
    sleep 1
    start_time=$(date +%s.%N)
    $run_test_script $CURRENT_PORT
    kill -9 $server_pid > /dev/null 2>&1
    end_time=$(date +%s.%N)
    # round to two decimal places
    elapsed_time=$(echo "result=($end_time - $start_time);scale=2;result/1" | bc -l)
    cd "$cwd"
    echo $elapsed_time
}

# glob all the directories in bin
mapfile -t all_executables < <(find $bin/ -type f -name "server")

for command in "${all_executables[@]}"; do
    echo "Running $command"
    elapsed_time=$(run_test "$(dirname "$command")" "./server")
    results+=("$elapsed_time $command")
    CURRENT_PORT=$((CURRENT_PORT+1))
done

interpreted_programs=(
    "python $src/server.py"
    # relative path to the script:
    "ruby $src/server.rb"
    "perl $src/server.pl"
    "node $src/server.js"
    "php $src/server.php"
    "java -cp $bin/java Server"
)

for item in "${interpreted_programs[@]}"; do
    # Split the item into interpreter and script path
    echo "Running $item"
    working_dir=$(realpath .)
    command="$item"
    elapsed_time=$(run_test "$working_dir" "$command")
    results+=("$elapsed_time $command")
    CURRENT_PORT=$((CURRENT_PORT+1))
done


echo -e "\nElapsed times (fastest to longest):"
printf "%s\n" "${results[@]}" | sort -n | while read line; do
    elapsed_time=$(echo "$line" | awk '{print $1}')
    command=$(echo "$line" | cut -d' ' -f2-)
    echo "$command: $elapsed_time seconds"
done
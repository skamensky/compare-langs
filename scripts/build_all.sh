set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

root=$(realpath $SCRIPT_DIR/..)
src=$root/src
bin="$root/bin"
mkdir -p "$bin"

(
    mkdir -p $bin/rust
    cd $bin/rust
    cp $src/server.rs .
    rustc server.rs -o server
    rm server.rs
)

(
    mkdir -p $bin/go
    cp $src/server.go $bin/go
    cd $bin/go
    go build -o server server.go
    rm server.go
)

(
    mkdir -p $bin/cpp
    cp $src/server.cpp $bin/cpp
    cd $bin/cpp
    g++ -O3 -o server server.cpp -lstdc++
    rm server.cpp
)

(
    mkdir -p $bin/c
    cp $src/server.c $bin/c
    cd $bin/c
    gcc -O3 -o server server.c
    rm server.c
)

(
    mkdir -p $bin/haskell
    cp $src/server.hs $bin/haskell
    cd $bin/haskell
    ghc server.hs -o server > /dev/null
    rm server.hs
)

(
    mkdir -p $bin/java
    cp $src/Server.java $bin/java
    cd $bin/java
    javac Server.java
    rm Server.java
)

find $bin -name "server" -type f | xargs chmod +x
echo "File sizes:"
echo ""
du -sh $bin/*
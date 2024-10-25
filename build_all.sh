set -e
mkdir -p bin

(
    mkdir -p bin/rust
    cd ./bin/rust
    cp ../../server.rs .
    rustc server.rs -o server
    rm server.rs
)

(
    mkdir -p bin/go
    cp server.go ./bin/go
    cd ./bin/go
    go build -o server server.go
    rm server.go
)

(
    mkdir -p bin/cpp
    cp server.cpp ./bin/cpp
    cd ./bin/cpp
    g++ -O3  -o server server.cpp -lstdc++
    rm server.cpp
)

(
    mkdir -p bin/c
    cp server.c ./bin/c
    cd ./bin/c
    gcc -O3 -o server server.c
    rm server.c
)

(
    mkdir -p bin/haskell
    cp server.hs ./bin/haskell
    cd ./bin/haskell
    ghc server.hs -o server > /dev/null
    rm server.hs
)

find ./bin/ -name "server" -type f | xargs chmod +x
echo "File sizes:"
echo ""
du -sh ./bin/*
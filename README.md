# Benchmarking Simple HTTP Servers in Various Programming Languages

This repository contains simple HTTP server implementations in various programming languages. The goal is to benchmark and compare the performance of these servers under the same conditions.

In the future I'll add more languages and make the servers more realistic.

## Languages Included

- C
- C++
- Go
- Haskell
- Rust
- Python
- Ruby
- Perl
- Node.js
- PHP

## Overview

Each server listens on a specified port and responds with a simple "Hello, World!" message to incoming HTTP requests. The servers are benchmarked by sending a thousand requests in parallel and measuring the time taken to process them.

## Requirements

- [Nix package manager](https://nixos.org/download.html)

## Setup

To set up the environment and install all necessary dependencies, use Nix:

```bash
nix develop
```

This will drop you into a shell with all required tools available.

## Building the Servers

To build all compiled servers (C, C++, Go, Haskell, Rust), run:

```bash
./build_all.sh
```

This script compiles the servers and places the binaries in the `bin/` directory.

## Running the Benchmarks

To run the benchmarks and measure the performance of each server, execute:

```bash
./run_all.sh
```

This script will:

- Start each server on a different port
- Send a series of HTTP requests to each server
- Measure and record the time taken to process the requests

The results are printed to the console.

## README Dynamicism 


The GitHub Actions workflow is configured to automatically build, test, and update the README on each push to the `master` branch.

The two sections below are automatically updated with the output of the build and test scripts.

# Output of build script (updated with every build):
<!-- BUILD_SCRIPT_OUTPUT_START -->
```
File sizes:

24K	./bin/c
24K	./bin/cpp
2.7M	./bin/go
6.5M	./bin/haskell
13M	./bin/rust

```
<!-- BUILD_SCRIPT_OUTPUT_END -->

# Output of test script (updated with every build):
<!-- TEST_SCRIPT_OUTPUT_START -->
```
Running ./bin/rust/server
Running ./bin/haskell/server
Running ./bin/cpp/server
Running ./bin/go/server
Running ./bin/c/server
Running python ./server.py
Running ruby ./server.rb
Running perl ./server.pl
Running node ./server.js
Running php ./server.php

Elapsed times (fastest to longest):
perl server.pl: 1.99 seconds
./bin/go/server: 2.02 seconds
ruby server.rb: 2.02 seconds
node server.js: 2.13 seconds
php server.php: 2.52 seconds
./bin/rust/server: 2.74 seconds
./bin/cpp/server: 2.87 seconds
./bin/c/server: 3.41 seconds
./bin/haskell/server: 3.48 seconds
python server.py: 4.54 seconds

```
<!-- TEST_SCRIPT_OUTPUT_END -->
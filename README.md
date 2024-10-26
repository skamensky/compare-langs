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
- Java

TODO:
- C#
- Swift
- Kotlin
- Scala
- Lua
- R
- Shell
- Tcl


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

20K	/home/runner/work/compare-langs/compare-langs/bin/c
24K	/home/runner/work/compare-langs/compare-langs/bin/cpp
3.0M	/home/runner/work/compare-langs/compare-langs/bin/go
1.4M	/home/runner/work/compare-langs/compare-langs/bin/haskell
8.0K	/home/runner/work/compare-langs/compare-langs/bin/java
532K	/home/runner/work/compare-langs/compare-langs/bin/rust

```
<!-- BUILD_SCRIPT_OUTPUT_END -->

# Output of test script (updated with every build):
<!-- TEST_SCRIPT_OUTPUT_START -->
```
Running bin/go/server
Running bin/c/server
Running bin/haskell/server
Running bin/cpp/server
Running bin/rust/server
Running python src/server.py
Running ruby src/server.rb
Running perl src/server.pl
Running node src/server.js
Running php src/server.php
Running java -cp bin/java Server

Elapsed times (fastest to longest):
python src/server.py: 1.66 seconds
bin/rust/server: 1.67 seconds
php src/server.php: 1.67 seconds
java -cp bin/java Server: 1.68 seconds
ruby src/server.rb: 1.68 seconds
perl src/server.pl: 1.70 seconds
bin/cpp/server: 1.73 seconds
bin/go/server: 1.74 seconds
node src/server.js: 1.81 seconds
bin/haskell/server: 2.65 seconds
bin/c/server: 2.73 seconds

```
<!-- TEST_SCRIPT_OUTPUT_END -->
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

24K	/home/shmuel/repos/compare-langs/bin/c
24K	/home/shmuel/repos/compare-langs/bin/cpp
2.7M	/home/shmuel/repos/compare-langs/bin/go
6.5M	/home/shmuel/repos/compare-langs/bin/haskell
12K	/home/shmuel/repos/compare-langs/bin/java
13M	/home/shmuel/repos/compare-langs/bin/rust

```
<!-- BUILD_SCRIPT_OUTPUT_END -->

# Output of test script (updated with every build):
<!-- TEST_SCRIPT_OUTPUT_START -->
```
Running /home/shmuel/repos/compare-langs/bin/rust/server
Running /home/shmuel/repos/compare-langs/bin/haskell/server
Running /home/shmuel/repos/compare-langs/bin/cpp/server
Running /home/shmuel/repos/compare-langs/bin/go/server
Running /home/shmuel/repos/compare-langs/bin/c/server
Running python /home/shmuel/repos/compare-langs/src/server.py
Running ruby /home/shmuel/repos/compare-langs/src/server.rb
Running perl /home/shmuel/repos/compare-langs/src/server.pl
Running node /home/shmuel/repos/compare-langs/src/server.js
Running php /home/shmuel/repos/compare-langs/src/server.php
Running java -cp /home/shmuel/repos/compare-langs/bin/java Server

Elapsed times (fastest to longest):
ruby /home/shmuel/repos/compare-langs/src/server.rb: 1.95 seconds
/home/shmuel/repos/compare-langs/bin/go/server: 2.02 seconds
node /home/shmuel/repos/compare-langs/src/server.js: 2.03 seconds
perl /home/shmuel/repos/compare-langs/src/server.pl: 2.08 seconds
/home/shmuel/repos/compare-langs/bin/rust/server: 2.35 seconds
/home/shmuel/repos/compare-langs/bin/cpp/server: 2.87 seconds
java -cp /home/shmuel/repos/compare-langs/bin/java Server: 3.06 seconds
python /home/shmuel/repos/compare-langs/src/server.py: 3.22 seconds
/home/shmuel/repos/compare-langs/bin/c/server: 3.26 seconds
php /home/shmuel/repos/compare-langs/src/server.php: 3.26 seconds
/home/shmuel/repos/compare-langs/bin/haskell/server: 5.69 seconds

```
<!-- TEST_SCRIPT_OUTPUT_END -->
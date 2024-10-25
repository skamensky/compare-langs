{
  description = "Benchmarking Simple HTTP Servers in Various Programming Languages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            gcc                         # For C
            libgcc                         # For C++
            go                          # For Go
            rustc                       # For Rust
            python3                     # For Python
            ruby                        # For Ruby
            perl                        # For Perl
            nodejs                      # For Node.js
            php                         # For PHP
            bc                          # For arbitrary precision arithmetic in scripts
            curl                        # For sending HTTP requests
            (haskell.packages.ghc94.ghcWithPackages (ps: [ ps.network ]))

          ];
        };
      };
    };
}

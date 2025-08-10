{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.git
    pkgs.flatbuffers

    # keep this line if you use bash
    pkgs.bashInteractive
  ];
}

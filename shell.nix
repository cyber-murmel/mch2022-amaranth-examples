{
  # git ls-remote https://github.com/nixos/nixpkgs nixos-22.05. Last updated: 2022-07-23.
  pkgs ? import (fetchTarball("https://github.com/NixOS/nixpkgs/archive/e3583ad.tar.gz")) {}
}:

with pkgs;
let
  amaranth-boards-mch2022 = python3Packages.amaranth-boards.overrideAttrs (old: {
    pname = "amaranth";
    version = "0.1";
    realVersion = "0.1.dev210+g${lib.substring 0 7 amaranth-boards-mch2022.src.rev}";
    src = fetchFromGitHub {
      owner = "amaranth-lang";
      repo = "amaranth-boards";
      rev = "fb430ff035cfb7c44af7f1e517e2bf032529577a";
      sha256 = "072psml2mdn60xbfvd0sjnf7j7hi9myiyqx1zaxs786z7axmm0ly";
    };
    pythonImportsCheck = [ "${amaranth-boards-mch2022.pname}" ];
  });
in
mkShell {
  buildInputs = [
    (python3.withPackages (ps: with ps;[
      pyusb
      amaranth
      amaranth-boards-mch2022
    ]))
    yosys
    icestorm nextpnr
    gtkwave
    symbiyosys boolector yices
  ];
}

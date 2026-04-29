{
  description = "flake for building dwm";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "dwm";
        version = "6.8";
        src = ./.;

        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = [
          pkgs.libX11
          pkgs.libxinerama
          pkgs.libxft
        ];

        makeFlags = [
          "PREFIX=$(out)"
          "CC:=$(CC)"
        ];

      };
    };
}

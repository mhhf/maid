{
  description = "A very basic bash cli flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        packages = with pkgs; [
          coreutils
          makeWrapper
          bash
          # your packages here
          dhall
          dhall-bash
          git
          tree
          github-cli
        ]; 
      in
      {
        packages.maid = pkgs.stdenv.mkDerivation rec {
          version = "0.1.0";
          name = "maid-${version}";
          src = ./.;
          dontBuild = true;
          doCheck = true;
          checkTarget = "test";
          makeFlags = ["prefix=$(out)"];
          postInstall =
            let
              path = pkgs.lib.makeBinPath packages;
            in
              ''
                wrapProgram "$out/bin/maid" \
                  --prefix PATH : ${path}
          '';
          buildInputs = packages;
          # shellHook = ''
          # '';
        };

        defaultPackage = self.packages.x86_64-linux.maid;

        devShell = pkgs.mkShell {
          buildInputs = packages;
        };
    });
}

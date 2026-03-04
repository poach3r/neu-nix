{
  description = "";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" ];

    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (system:
        f system);

  in {

    # Expose packages normally
    packages = forAllSystems (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        wld = pkgs.callPackage ./packages/wld {};
        swc = pkgs.callPackage ./packages/swc {};
      });

    # Provide default package
    defaultPackage = forAllSystems (system:
      self.packages.${system}.swc
    );

    # Expose overlay
    overlays.default = final: prev: {
      wld = final.callPackage ./packages/wld {};
      swc = final.callPackage ./packages/swc {};
    };

  };
}

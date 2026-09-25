{
  description = "A simple NixOS flake";

  inputs = {
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, silentSDDM, ... }@inputs: {
    # Replace my-nixos with your hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        silentSDDM.nixosModules.default
        {
          programs.silentSDDM = {
            enable = true;
            theme = "rei";
            # settings = { ... }; see example in module
          };
        }
      ];
    };
  };
}

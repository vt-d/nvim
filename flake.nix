{
  description = "VT's Neovim Configuration"; # based off of IogaMaster's flake

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, ... }: utils.lib.eachDefaultSystem (system:
    let
      inherit (nixpkgs) lib;
      pkgs = nixpkgs.legacyPackages.${system};
      runtimeDeps = with pkgs; [
        gcc

        nil
        statix
        deadnix
        manix
	pyright
	ruff
	python312Packages.black
	python312Packages.isort
	sumneko-lua-language-server

	# copilot
	nodePackages_latest.nodejs
	nodePackages_latest.typescript-language-server
      ];

      nvim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped
        (pkgs.neovimUtils.makeNeovimConfig
          {
            customRC = ''
              set runtimepath^=${./.}
              source ${./.}/init.lua
            '';
          } // {
          wrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            "${lib.makeBinPath runtimeDeps}"
          ];
        });
    in
    {
      overlays = {
        neovim = _: _prev: {
          neovim = nvim;
        };
        default = self.overlays.neovim;
      };

      packages = rec {
        neovim = nvim;
        default = neovim;
      };

      devShells.default = pkgs.mkShell {
        nativeBuildInputs = [
          pkgs.stylua
        ];
      };
    }
  );
}

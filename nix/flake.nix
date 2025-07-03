{
  description = "Eduardo nix-darwin system flake";

  inputs = {
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config = { allowBroken = true; allowUnfree = true; };

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.neovim
          pkgs.tmux
          pkgs.fastfetch
          pkgs.starship
          pkgs.mkalias
          pkgs.btop
          pkgs.go
          pkgs.pnpm
          pkgs.fzf
        ];

      # fonts.packages = [
      #   pkgs.nerd-fonts.jetbrains-mono
      # ];

      homebrew = {
      	enable = true;
        brews = [
          "git-lfs"
          "nvm"
        ];
        casks = [
          "ghostty"
          "the-unarchiver"
          "font-jetbrains-mono"
          "spotify"
          "visual-studio-code"
          "google-chrome"
          "brave-browser"
          "visual-studio-code"
        ];
        onActivation.cleanup = "zap";
      };

      system.defaults = {
      	dock.autohide = true;
        dock.show-recents = false;
      };

      system.activationScripts.dockTweak.text = ''
          defaults write com.apple.dock autohide-delay -float 0
          defaults write com.apple.dock autohide-time-modifier -int 0
          killall Dock
        '';

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Eduardos-MacBook-Air
    darwinConfigurations."Eduardos-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "eduardogdebem";
            autoMigrate = true;
          };
        }
      ];
    };

    darwinPackages = self.darwinConfigurations."Eduardos-MacBook-Air".pkgs;
  };
}

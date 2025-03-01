{ pkgs, system, config, home-manager, nix-wallpaper, ... }:

{
  imports = [ home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.cameron = {
      imports = [ ./git ./nvim ];

      home.stateVersion = "22.11";

      manual.manpages.enable = false; # TODO: I want this enabled but manual build breaks right now

      home.sessionVariables = {
        EDITOR = "nvim";
        GIT_EDITOR = "nvim";
      };

      home.packages = with pkgs; [
        rust-analyzer
        tree-sitter
      ];

      dconf = {
        enable = true;
        settings = {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = [ 
              pkgs.gnomeExtensions.pop-shell.extensionUuid
            ];
          };
        };
      };

      programs.zsh = {
        enable = true;
        oh-my-zsh.enable = true;
      };

      xresources.properties = {
        "xterm*font" = "-*-fixed-*-r-normal-*-14-*-*-100-*-*-iso8859-*";
        "XTerm*background" = "black";
        "XTerm*foreground" = "white";
        "XTerm*pointerColor" = "white";
        "XTerm*pointerColorBackground" = "black";
        "XTerm*cursorColor" = "white";
        "XTerm*internalBorder" = 3;
        "XTerm*loginShell" = false;
        "XTerm*scrollBar" = true;
        "XTerm*scrollKey" = false;
        "XTerm*saveLines" = 1000;
        "XTerm*multiClickTime" = 250;
        "XTerm*selectToClipboard" = true;
      };

      home.file."monitor.sh".source = ./monitor.sh;

      home.file.".bashrc".source = ./.bashrc;
      home.file.".zshrc".source = ./.zshrc;
      home.file.".xscreensaver".source = ./.xscreensaver;
      home.file.".wallpaper/nixos.png".source = nix-wallpaper.packages.${system}.default.override
        {
          preset = "gruvbox-dark";
        } + /share/wallpapers/nixos-wallpaper.png;
    };
  };
}

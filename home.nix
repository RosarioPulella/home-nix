{ pkgs, config, ... }:
let
  editor = "kak";
  username = "rosario";

in
{
  imports = [
    ./vim
    ./gpg.nix
    ./sway.nix
    ./kakoune.nix
    ./archive.nix
    ./yubikey.nix
    ./firefox
    ./git.nix
    ./messaging.nix
  ];

  home = {
    username = username;
    homeDirectory = "/home/" + username;
    stateVersion = "20.09";

    sessionVariables = {
      EDITOR = editor;
      VISUAL = editor;
    };

    language.base = "en_US";
  };

  fonts.fontconfig.enable = true;

  xdg = {
    enable = true;

    userDirs.enable = true;

    mime.enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "x-scheme-handler/bitwarden" = [ "Bitwarden.desktop" ];
      };
    };
  };


  home.packages = with pkgs; [
    nix

    hack-font

    watchman
    inotify-tools

    hunspell
    hunspellDicts.en-us
    okular

    rnix-lsp

    # needed so that coc can work https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#requirements
    nodejs

    spotify
    bitwarden
    inkscape
    libreoffice
    exercism

    element-desktop
  ];

  programs = {
    bash.enable = true;
    bat.enable = true;
    ssh.enable = true;
    foot.enable = true;

    vscode = {
      enable = true;

      userSettings = {
        "update.channel" = "none";

        "editor.renderWhitespace" = "all";
        "[nix]"."editor.tabSize" = 2;
        
        "diffEditor.ignoreTrimWhitespace" = false;
      };
      package = pkgs.vscodium;

      haskell = {
        enable = true;
        hie.enable = false;
        # TODO: Enable hie integration
      };

      extensions = with pkgs.vscode-extensions; [ 
        jnoortheen.nix-ide 
        streetsidesoftware.code-spell-checker
      ];
    };

    chromium = {
      enable = true;
      package = pkgs.brave;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
    iconTheme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "Breeze-Dark";
      package = pkgs.LibsForQt5.breeze;
    };
  };

  dconf = {
    enable = true;
  };
}

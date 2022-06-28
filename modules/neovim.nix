{pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import (
  fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  ) { config = baseconfig; };
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };

  # Get sha256 by running nix-prefetch-url --unpack https://github.com/[owner]/[name]/archive/[rev].tar.gz
  # customVimPlugins = with unstable.vimUtils; {
  customVimPlugins = with pkgs.vimUtils; {
    impatient = buildVimPluginFrom2Nix {
      name = "impatient";
      src  = pkgs.fetchFromGitHub {
        owner  = "lewis6991";
        repo   = "impatient.nvim";
        rev    = "969f2c5c90457612c09cf2a13fee1adaa986d350";
        sha256 = "10nlz4hq1bqjsnj9pkadi3xjj74wn36f2vr66hqp7wm2z7i5zbq3";
      };
    };
    terminus = buildVimPluginFrom2Nix {
      name = "terminus";
      src  = pkgs.fetchFromGitHub {
        owner  = "wincent";
        repo   = "terminus";
        rev    = "12b07e390ea6346c91cd82edb0fa9b967164c38d";
        sha256 = "1s964165x466hjcd3ykfd38jaqh274yygnfw34a66rhgjvhmfzmi";
      };
    };
    vim-puppet-4tabs = buildVimPluginFrom2Nix {
      name = "vim-puppet";
      src = pkgs.fetchgit {
        url = "https://git.gurkan.in/gurkan/vim-puppet.git";
        rev = "f9f38eb3fb9920e93878d6757121a40cb288ce77";
        sha256 = "1sd1i6z2q864jmrcmq67g7nqdj4v9ys1px5vw8p37qd9vqs3iall";
      };
    };
  };
in {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    package = unstable.neovim-unwrapped;
    configure = {
      customRC = ''
        lua require('impatient')
        source ~/.config/nvim/nix.vim
      '';
      packages.myVimPackages = with pkgs.vimPlugins // customVimPlugins; {
        start = [
          # nvim-ts-rainbow # rainbow paranthesis - build fails / wants ctags
          LeaderF
          YouCompleteMe
          airline
          colorizer
          impatient
          indentLine
          limelight-vim
          nerdcommenter # quick comment
          nvim-web-devicons
          nur.repos.m15a.vimExtraPlugins.pretty-fold-nvim
          syntastic # syntax check
          tagbar # sidebar
          terminus # terminal integration
          vim-airline-themes
          vim-colorschemes
          vim-easytags
          vim-flake8
          vim-fugitive # git helper
          vim-go
          vim-gutentags
          vim-illuminate
          vim-markdown
          vim-nix
          vim-oscyank
          vim-puppet-4tabs
          vim-trailing-whitespace
          vimwiki
        ];
      };
    };
  };
}

{pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import (
    fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  ) { config = baseconfig; };

  # Get sha256 by running nix-prefetch-url --unpack https://github.com/[owner]/[name]/archive/[rev].tar.gz
  customVimPlugins = with pkgs.vimUtils; {
    myNeoSolarized = buildVimPluginFrom2Nix {
      name = "NeoSolarized";
      src  = pkgs.fetchFromGitHub {
        owner  = "malob";
        repo   = "NeoSolarized";
        rev    = "a8e6e52";
        sha256 = "0bxrm2vm3z1y37sm6m2hdn72g2sw31dx1xhmjvd0ng72cnp84d9k";
      };
    };
    terminus = buildVimPluginFrom2Nix {
      name = "terminus";
      src  = pkgs.fetchFromGitHub {
        owner  = "wincent";
        repo   = "terminus";
        rev    = "340ea44d";
        sha256 = "170ks4lrpyj280pvm2kjndx2q1r7ca4w8ix0zdsgvzrmq54psxad";
      };
    };
  };
in {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    package = unstable.neovim-unwrapped;
    configure = {
      customRC = ''
        source ~/.config/nvim/nix.vim
      '';
      packages.myVimPackages = with pkgs.vimPlugins // customVimPlugins; {
        start = [
          LeaderF
          YouCompleteMe
          airline
          colorizer
          indentLine
          limelight-vim
          myNeoSolarized
          nerdcommenter
          nvim-web-devicons
          syntastic
          tagbar
          terminus
          todo-txt-vim
          vim-airline-themes
          vim-easytags
          vim-flake8
          vim-fugitive
          vim-go
          vim-gutentags
          vim-illuminate
          vim-nix
          vim-oscyank
          vim-puppet
          # vim-polyglot
          vim-trailing-whitespace
          vimwiki
          zenburn
        ];
      };
    };
  };
}

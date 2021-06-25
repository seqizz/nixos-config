{pkgs, ...}:
let
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
    oscyank = buildVimPluginFrom2Nix {
      name = "oscyank";
      src  = pkgs.fetchFromGitHub {
        owner  = "ojroques";
        repo   = "vim-oscyank";
        rev    = "fdbac11";
        sha256 = "1mbs8v8k7698qnck5n38lqaz8sl07d1p31c84injb460l6jfv1s7";
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
    nvim-web-devicons = buildVimPluginFrom2Nix {
      name = "nvim-web-devicons";
      src  = pkgs.fetchFromGitHub {
        owner  = "kyazdani42";
        repo   = "nvim-web-devicons";
        rev    = "61693bf";
        sha256 = "0siifa9gxj6kz9w4fpnra6afyri6y0b34605aqkf7820krhcmckz";
      };
    };
  };
in {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    configure = {
      customRC = ''
        source ~/.config/nvim/nix.vim
      '';
      packages.myVimPackages = with pkgs.vimPlugins // customVimPlugins; {
        start = [
          airline
          colorizer
          indentLine
          # jedi-vim
          LeaderF
          limelight-vim
          myNeoSolarized
          nerdcommenter
          nvim-web-devicons
          oscyank
          syntastic
          tagbar
          terminus
          todo-txt-vim
          vim-airline-themes
          # vim-easytags
          vim-flake8
          vim-fugitive
          vim-go
          vim-gutentags
          vim-illuminate
          vim-nix
          # vim-polyglot
          vim-trailing-whitespace
          vimwiki
          YouCompleteMe
          zenburn
        ];
      };
    };
  };
}

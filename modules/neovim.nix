{pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import (
    fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  ) { config = baseconfig; };

  # Get sha256 by running nix-prefetch-url --unpack https://github.com/[owner]/[name]/archive/[rev].tar.gz
  customVimPlugins = with unstable.vimUtils; {
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
        source ~/.config/nvim/nix.vim
      '';
      packages.myVimPackages = with unstable.vimPlugins // customVimPlugins; {
        start = [
          LeaderF
          YouCompleteMe
          airline
          colorizer
          indentLine
          limelight-vim
          myNeoSolarized
          nerdcommenter # quick comment
          nvim-web-devicons
          syntastic # syntax check
          tagbar # sidebar
          terminus # terminal integration
          vim-airline-themes
          vim-easytags
          vim-flake8
          vim-fugitive # git helper
          vim-go
          vim-gutentags
          vim-illuminate
          vim-nix
          vim-oscyank
          vim-puppet-4tabs
          # vim-polyglot
          vim-trailing-whitespace
          vimwiki
          zenburn
        ];
      };
    };
  };
}

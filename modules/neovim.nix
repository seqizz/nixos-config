{pkgs, ...}:
let
  baseconfig = { allowUnfree = true; };
  unstable = import (
    fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz
  ) { config = baseconfig; };

  # Get sha256 by running nix-prefetch-url --unpack https://github.com/[owner]/[name]/archive/[rev].tar.gz
  # customVimPlugins = with unstable.vimUtils; {
  customVimPlugins = with pkgs.vimUtils; {
    impatient = buildVimPluginFrom2Nix {
      name = "impatient";
      src  = pkgs.fetchFromGitHub {
        owner  = "lewis6991";
        repo   = "impatient.nvim";
        rev    = "f4a45e4be49ce417ef2e15e34861994603e3deab";
        sha256 = "0q034irf77rlk07fd350zbg73p4daj7bakklk0q0rf3z31npwx8l";
      };
    };
    terminus = buildVimPluginFrom2Nix {
      name = "terminus";
      src  = pkgs.fetchFromGitHub {
        owner  = "wincent";
        repo   = "terminus";
        rev    = "e8bc19c8156d955762c31d0964eeb7c84889f42e";
        sha256 = "1w4wc6y72mk80ivv55hs8liwa8fnhkyvly8dnny1jhfzs3bbk8kg";
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

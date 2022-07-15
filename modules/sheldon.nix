{ pkgs, config, lib, ... }:
let
  sheldonConfig = "/etc/sheldon.toml";
in
{
  environment = {
    variables = {
      SHELDON_CONFIG_FILE = sheldonConfig;
    };
    etc."sheldon.toml".text = ''
      shell = "zsh"

      [plugins]

      [plugins.zsh-defer]
      github = "romkatv/zsh-defer"

      [templates]
      defer = { value = 'zsh-defer source "{{ file }}"', each = true }

      [plugins.zsh-term-title]
      github = 'pawel-slowik/zsh-term-title'

      [plugins.zsh-history-substring-search]
      github = 'zsh-users/zsh-history-substring-search'

      [plugins.gitstatus]
      github = 'romkatv/gitstatus'
      use = ['gitstatus.prompt.zsh']

      [plugins.zsh-syntax-highlighting]
      github = "zsh-users/zsh-syntax-highlighting"
      apply = ["defer"]

      [plugins.pass]
      remote = 'https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/pass/_pass'
      apply = ["defer"]

      [plugins.nix-zsh-completions]
      github = 'spwhitt/nix-zsh-completions'

      [plugins.zsh-manydots-magic]
      remote = 'https://raw.githubusercontent.com/knu/zsh-manydots-magic/master/manydots-magic'
      apply = ["defer"]

      [plugins.compinit]
      inline = 'autoload -Uz compinit && compinit'
    '';
  };
  system.userActivationScripts.sheldonActivate.text = "SHELDON_CONFIG_FILE=${sheldonConfig} ${pkgs.sheldon}/bin/sheldon lock --update";
}
#  vim: set ts=2 sw=2 tw=0 et :

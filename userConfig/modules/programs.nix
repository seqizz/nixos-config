{config, pkgs, ...}:
let
  secrets = import ./secrets.nix {pkgs=pkgs;};
in
{
  programs = {
    git = {
      enable = true;
      userEmail = secrets.gitUserEmail;
      userName = secrets.gitUserName;
      aliases = {
        # foksheet: Send the last change amended to last commit quickly, except on master branch
        fs = ''
          !CURBRANCH=$(git symbolic-ref --short HEAD) && if [ "''${CURBRANCH}" = "master" ]; then echo "Cant do this on master, master" && exit 1; fi  && git add -A && git commit -a --amend --no-edit && git push origin +''${CURBRANCH}
        '';

        # Checkout the master branch, update it and remove the source branch if it is already merged on upstream
        reclean = ''
          !CURBRANCH=$(git symbolic-ref --short HEAD) && if [ "''${CURBRANCH}" = "master" ]; then echo "Cant do this on master, master" && exit 1; fi && git checkout master && git pull && git branch -d ''${CURBRANCH}
        '';

        # I am just lazy
        new = "checkout -b";

        # checkout latest upstream (good for getting force-pushes)
        getlast = "!sh -c 'git fetch --all && git reset --hard origin/$(git symbolic-ref --short HEAD)'";

        # checkout to branch of given merge request (for gitlab)
        # usage: git mr <source> <MR number> (git mr origin 1010)
        mr = "!sh -c 'git fetch $1 merge-requests/$2/head:mr-$1-$2 && git checkout mr-$1-$2' -";

        # checkout to branch of given pull request (for github)
        # usage: git pr <source> <PR number> (git pr origin 1010)
        pr = "!sh -c 'git fetch $1 pull/$2/head:$2 && git checkout $2' -";
      };
      delta = {
        enable = true;
        options = {
          dark = "true";
        };
      };
      extraConfig = {
        pull = {
          ff = "only";
        };
      };
    };

    browserpass = {
      enable = true;
      browsers = [ "firefox" ];
    };

    rofi = {
      enable = true;
      package = pkgs.rofi.override {
        plugins = [
          pkgs.rofi-emoji
        ];
      };
      pass = {
        enable = true;
        extraConfig = ''
          USERNAME_field='login'
        '';
        };
      width = 40;
      lines = 20;
      font = "FiraCode Nerd Font 14";
      theme = "glue_pro_blue";
      extraConfig = {
        matching = "regex";
        max-history-size = 200;
        kb-clear-line = "Control+a";
        kb-move-front = "" ;
        kb-cancel = "Control+c,Escape,Control+g,Control+bracketleft";
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

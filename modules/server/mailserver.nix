{ config, pkgs, ... }:
let
  my_webmail = pkgs.rainloop-community.override {
    dataPath = "/shared/.mail_webmail_data";
  };
  secrets = import ../secrets.nix;
in
{
  imports = [
    (builtins.fetchTarball {
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/nixos-22.11/nixos-mailserver-nixos-22.11.tar.gz";
      sha256 = "1h1r4x2ffqwyk0ql6kjvcpg1bdiimyzhrsvn49702fsgzpx57fhd";
    })
  ];

  environment.systemPackages = with pkgs; [
    my_webmail
  ];

  mailserver = {
    enable = true;
    fqdn = "mail.gurkan.in";
    domains = [ "gurkan.in" "siktir.in" ];
    mailDirectory = "/shared/mail";
    certificateDirectory = "/shared/mail/certificates";
    dkimKeyDirectory = "/shared/.mail_dkim_keys";
    certificateScheme = 3;
    loginAccounts = secrets.mailAccount;
    #   "${secrets.mailAccount}" = {
    #     hashedPassword = secrets.mailAccountPass;
    #   };
    # };
    # extraVirtualAliases = secrets.mailVirtualAliases;
    enableImap = true;
    enablePop3 = true;
    enableImapSsl = true;
    enablePop3Ssl = true;
    enableManageSieve = true;
    virusScanning = false;
    localDnsResolver = false;
    # Just reject those spoofers of known domains, will increase the list later
    policydSPFExtraConfig = ''
      Reject_Not_Pass_Domains = live.com,aol.com,hotmail.com,gmail.com,yahoo.com
    '';
	mailboxes = {
      Trash = {
        auto = "no";
        specialUse = "Trash";
      };
      Junk = {
        auto = "subscribe";
        specialUse = "Junk";
      };
      Drafts = {
        auto = "subscribe";
        specialUse = "Drafts";
      };
      Sent = {
        auto = "subscribe";
        specialUse = "Sent";
      };
      Seen = {
        auto = "subscribe";
        specialUse = "Archive";
      };
    };
  };
}


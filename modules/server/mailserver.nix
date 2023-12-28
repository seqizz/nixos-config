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
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/nixos-23.11/nixos-mailserver-nixos-23.11.tar.gz";
      sha256 = "1czvxn0qq2s3dxphpb28f3845a9jr05k8p7znmv42mwwlqwkh1ax";
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
    certificateScheme = "acme-nginx";
    # @Bug: Ask about this, where to even declare chain.pem?
    # certificateScheme = 1;
    # certificateFile = "/var/lib/acme/git.gurkan.in/fullchain.pem";
    # keyFile = "/var/lib/acme/git.gurkan.in/key.pem";
    loginAccounts = secrets.mailAccount;
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
    rejectRecipients = secrets.mailRejectRecipients;
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


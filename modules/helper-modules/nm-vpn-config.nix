{ pkgs
, visibleName
, fileName
, remote
, ca
, cert
, key
, ta
, pass ? ""
, cipher ? "AES-256-CBC"
}:
let
  # Get a uniq id for each given network, needed by networkmanager
  uuid = (import ./get-uuid.nix {
    inherit pkgs;
    baseText = fileName;
  }).out;
in
{
  # This is my preferred template, will extend later
  vpnConfig = ''
    [connection]
    id=${visibleName}
    uuid=${builtins.readFile (uuid + "/outFile")}
    type=vpn
    autoconnect=false
    permissions=
    timestamp=1601638109

    [vpn]
    auth=SHA256
    ca=${ca}
    cert=${cert}
    cert-pass-flags=0
    cipher=${cipher}
    comp-lzo=yes
    connection-type=tls
    dev=tun
    dev-type=tun
    key=${key}
    remote=${remote}
    ta=${ta}
    ta-dir=1
    service-type=org.freedesktop.NetworkManager.openvpn
    allow-compression=yes

    [vpn-secrets]
    cert-pass=${pass}

    [ipv4]
    dns-search=
    method=auto
    never-default=true

    [ipv6]
    addr-gen-mode=stable-privacy
    dns-search=
    ip6-privacy=0
    method=auto

    [proxy]
  '';
  name = fileName;
}

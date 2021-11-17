{ stdenv, fetchFromGitHub, writeTextFile }:

let
  config_file = writeTextFile {
    name = "owl.plymouth";
    text = ''
      [Plymouth Theme]
      Name=owl
      Description=display the owl
      Comment=not much
      ModuleName=script

      [script]
      ImageDir=etc/plymouth/themes/owl
      ScriptFile=etc/plymouth/themes/owl/owl.script
    '';
  };
in stdenv.mkDerivation rec {
  name = "ibm";

  src = fetchFromGitHub {
    owner = "adi1090x";
    repo = "plymouth-themes";
    rev = "bf2f570bee8e84c5c20caac353cbe1d811a4745f";
    sha256 = "0scgba00f6by08hb14wrz26qcbcysym69mdlv913mhm3rc1szlal";
  };

  buildInputs = [ stdenv ];

  configurePhase = ''
    install_path=$out/share/plymouth/themes/
    mkdir -p $install_path
  '';

  buildPhase = ''
    substitute ${config_file} "pack_3/owl/owl.plymouth"
  '';

  installPhase = ''
    cd pack_3 && cp -r owl $install_path
  '';

  meta = with stdenv.lib; { platfotms = platforms.linux; };
}

{ config, ... }:
{
  home.sessionVariables = {
    GOPATH = "~/devel/go";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    MOZ_USE_XINPUT2 = 1;
  };
}

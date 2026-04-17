{ lib, stdenv, fetchFromGitHub }:

# Patches two missing icons in Reversal by taking them from the WhiteSur theme.
# Temporarily fixes https://github.com/yeyushengfan258/Reversal-icon-theme/issues/138
stdenv.mkDerivation rec {
  pname = "reversal-white-sur-patch";
  version = "20260416";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "WhiteSur-icon-theme";
    rev = "bab5833b5cae200bccb786a2d3d6afa2201e7806";
    hash = "sha256-5AWyuqREKpgBCXPplpkdrcInDTZfjVIm/JtTleOmaNY=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons/Reversal-purple/apps/scalable

    # mv ./src/apps/scalable/softwarecenter.svg $out/share/icons/Reversal-purple/apps/scalable/softwarecenter.svg
    # mv ./src/apps/scalable/softwarecenter.svg $out/share/icons/Reversal-purple/apps/scalable/plasmadiscover.svg
   
    mv ./src/apps/scalable/utilities-system-monitor.svg $out/share/icons/Reversal-purple/apps/scalable/utilities-system-monitor.svg

    runHook postInstall
  '';

  # Allow this to override the base Reveral package 
  meta.priority = 1;
}
{ lib, stdenv, fetchFromGitLab }:

# lotta effort to not like the way it looks :(
stdenv.mkDerivation rec {
  pname = "kde-edna-light";
  version = "20250125";

  src = fetchFromGitLab {
    owner = "jomada";
    repo = "Edna-Light";
    rev = "1ca8defe4fa53ed84257e5d8003aa15709fe2873";
    hash = "sha256-9M+s/rCuOd83jNnuL60BA+/QeUINBa4VqxPEgs+zDEw=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/aurorae/themes
    mv ./Aurorae/Edna-Light $out/share/aurorae/themes

    mkdir -p $out/share/color-schemes
    mv ./Color-schemes/*.colors $out/share/color-schemes
    
    mkdir -p $out/share/plasma/look-and-feel
    mv ./Look-and-feel/Edna-Light $out/share/plasma/look-and-feel
    runHook postInstall
  '';

  meta = {
    description = "Edna Light theme for KDE Plasma 6";
    homepage = "https://github.com/jomada/Edna-Light";
    license = lib.licenses.gpl3;
  };
}
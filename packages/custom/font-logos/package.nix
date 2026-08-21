{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation {
  pname = "font-logos-";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "Lukas-W";
    repo = "font-logos";
    rev = "d3bf5d299e54595db1b19681a0cc57ab10454857";
    hash = "sha256-X4aeIesULczRN0IDIDpMI1SugNjikvzFGZir6eL0DHo=";
  };

  buildPhase = ''
    runHook preBuild
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp -r ./vectors $out 

    runHook postInstall
  '';

  meta = {
    description = "Linux distro logos";
    homepage = "https://gitlab.com/Lukas-W/font-logos/";
    license = lib.licenses.unlicense;
  };
}
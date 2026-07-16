{ lib, stdenv, fetchFromGitLab }:

stdenv.mkDerivation rec {
  pname = "future-cyan-hyprcursor";
  version = "20260716";

  src = fetchFromGitLab {
    owner = "Pummelfisch";
    repo = "future-cyan-hyprcursor";
    rev = "cf4126d17f4520aceb688d8a60daca4a1f0b9e80";
    hash = "sha256-a7LdP2VH0UlMPwW9vbBolOuPQMJa0WNpmJfLLv3JZ4g=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons/Future-Cyan-Hyprcursor_Theme
    cp -R ./Future-Cyan-Hyprcursor_Theme $out/share/icons/
    
    runHook postInstall
  '';

  meta = {
    description = "Future Cyan Hyprcursor theme";
    homepage = "https://gitlab.com/Pummelfisch/future-cyan-hyprcursor/";
    license = lib.licenses.gpl3;
  };
}
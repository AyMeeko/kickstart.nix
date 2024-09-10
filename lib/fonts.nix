{stdenvNoCC}:
stdenvNoCC.mkDerivation rec {
  pname = "premium-fonts";
  version = "1.1.0";
  name = "${pname}-${version}";
  src = builtins.fetchGit {
    url = "git@github.com:aymeeko/fonts.git";
    rev = "00d11917888de866b6dcd2c53e551953354f09ec";
  };

  installPhase = ''
    install -Dm444 CascadiaCode/CascadiaCode-2404.23/ttf/*.ttf -t $out/share/fonts
    install -Dm444 MonoLisa/MonoLisa-custom1-2.015/ttf/*.ttf -t $out/share/fonts
    install -Dm444 OpenDyslexic/OpenDyslexicMono/*.otf -t $out/share/fonts
    install -Dm444 OpenDyslexic/OpenDyslexic3/*.ttf -t $out/share/fonts
  '';
}

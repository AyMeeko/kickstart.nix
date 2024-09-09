{stdenvNoCC}:
stdenvNoCC.mkDerivation rec {
  pname = "premium-fonts";
  version = "1.0.0";
  name = "${pname}-${version}";
  src = builtins.fetchGit {
    url = "git@github.com:aymeeko/fonts.git";
    rev = "738a81ba294490d3f1a7428f3aa743024565498e";
  };

  installPhase = ''
    install -Dm444 CascadiaCode/CascadiaCode-2404.23/ttf/*.ttf -t $out/share/fonts
    install -Dm444 MonoLisa/MonoLisa-custom1-2.015/ttf/*.ttf -t $out/share/fonts
  '';
}

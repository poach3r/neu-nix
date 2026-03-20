{
  lib,
  stdenv,
  fetchFromSourcehut,
  pkg-config,
  pixman,
  wayland,
  neuswc,
  neuwld,
  libxcb,
  libxcb-wm,
  udev,
  libdrm,
  libinput,
  libxkbcommon,
  fontconfig,
}:
stdenv.mkDerivation {
  pname = "wsxwm";
  version = "unstable-2026-03-20";
  src = fetchFromSourcehut {
    owner = "~uint";
    repo = "wsxwm";
    rev = "f5f3c1f53b77d41ab0b0aefabb64e86881b5705d";
    hash = "sha256-xXyRdFU/HYgbs9drGnqAh4mz4BgtcYfc6VJX8SvXFD4=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    pixman
    wayland
    neuswc
    neuwld
    libxcb
    libxcb-wm
    udev
    libdrm
    libinput
    libxkbcommon
    fontconfig
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp wsxwm $out/bin/wsxwm
    runHook postInstall
  '';

  meta = {
    description = "Way Sexier Window Manager";
    homepage = "https://git.sr.ht/~uint/wsxwm";
    license = lib.licenses.isc;
    mainProgram = "wsxwm";
  };
}

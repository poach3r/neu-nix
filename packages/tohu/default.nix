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
  pname = "tohu";
  version = "unstable-2026-03-20";
  src = fetchFromSourcehut {
    owner = "~shrub900";
    repo = "tohu";
    rev = "9236a46f77799ff10b7ce630f44c6cde4af8b95b";
    hash = "sha256-hOaqxzrJMtjnhbClzULWM8BhtMa5l07z6KOlNbHxaVM=";
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

  postPatch = ''
    substituteInPlace Makefile \
      --replace "-fcolor-diagnostics" ""
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp tohu $out/bin/tohu
    runHook postInstall
  '';

  meta = {
    description = "floating window manager for swc";
    homepage = "https://git.sr.ht/~shrub900/tohu";
    license = lib.licenses.isc;
    mainProgram = "tohu";
  };
}

{
  lib,
  writeText,
  stdenv,
  fetchFromSourcehut,
  bmake,
  neuwld,
  neuswc,
  libinput,
  pixman,
  pkg-config,
  fontconfig,
  wayland,
  wayland-scanner,
  wayland-protocols,
  libdrm,
  libxkbcommon,
  libxcb,
  libxcb-wm,
  udev,
  conf ? ./config.h,
}:
stdenv.mkDerivation {
  pname = "dwc";
  version = "0.0";
  src = fetchFromSourcehut {
    owner = "~corg";
    repo = "DWC";
    rev = "c6c0d3af318b319c947ca2ae43ba9b9928ec825d";
    hash = "sha256-MKHCFqey/7RzscUl4A6CDlmjmcm5D42nOgie+0KOHc8=";
  };

  nativeBuildInputs = [
    bmake
    pkg-config
    wayland-scanner
  ];

  buildInputs = [
    libdrm
    libinput
    pixman
    neuswc
    neuwld
    wayland
    wayland-protocols
    libxkbcommon
    libxcb
    libxcb-wm
    udev
    fontconfig
  ];

  makeFlags = [
    "PREFIX=$(out)"
  ];

  postPatch =
    let
      configFile =
        if lib.isDerivation conf || builtins.isPath conf then conf else writeText "config.h" conf;
    in
    lib.optionalString (conf != null) "cp ${configFile} config.h";

  meta = {
    description = "A DWM-like wayland compositor with built-in bar, built with neuswc and neuwld.";
    homepage = "https://git.sr.ht/~corg/dwc";
    license = lib.licenses.mit;
    mainProgram = "dwc";
  };
}

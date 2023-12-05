{ lib
, fetchFromGitHub
, rustPlatform
, ffmpeg
, pkg-config
, openssl
, alsa-lib
, lame
, ...
}:
let
  pname = "DownOnSpot";
  version = "28035d9a2edcc21f2098f09a4304a2254ff9bc51";
  sha256 = "sha256-7Kqo1WKk/A4qvpQ9OrIBLRWdDlBzTBN052lldzaLftA=";
  cargoHash = "";
in
rustPlatform.buildRustPackage {
  inherit pname version cargoHash;

  src = fetchFromGitHub {
    owner = "oSumAtrIX";
    repo = pname;
    rev = version;
    inherit sha256;
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "librespot-0.5.0-dev" = "sha256-bfgfKVeQCDJQwWtTdV30oRRlW8BYb7tZFVI3wC7WoYE=";
      #"librespot-audio" = "";
      #"librespot-connect" = "";
      #"librespot-core" = "";
      #"librespot-discovery" = "";
      #"librespot-metadata" = "";
      #"librespot-playback" = "";
      #"librespot-protocol" = "";

    };
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    ffmpeg
    openssl
    alsa-lib
    lame
  ];

  meta = with lib; {
    description = "AV1 re-encoding using ffmpeg, svt-av1 & vmaf";
    homepage = "https://github.com/alexheretic/ab-av1";
    license = licenses.mit;
    maintainers = [ ];
  };
}

{ lib
, fetchFromGitHub
, rustPlatform
, fuse3
, pkg-config
, openssl
, ...
}:
let
  pname = "onedrive-fuse";
  version = "v0.2.5";
  sha256 = "sha256-1cpNMHs39WNtV6nWge/1+oyC534sNQUMmIanLs5NAI0=";
  cargoHash = "sha256-pXaJGVloDsz1jUuRZq4tir/FYeCoFMvEHhO30sm7H9A=";
in
rustPlatform.buildRustPackage {
  inherit pname version cargoHash;

  src = fetchFromGitHub {
    owner = "oxalica";
    repo = pname;
    rev = version;
    inherit sha256;
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    fuse3
    openssl
  ];

  meta = with lib; {
    description = "Mount your Microsoft OneDrive storage as FUSE filesystem";
    homepage = "https://github.com/oxalica/onedrive-fuse";
    license = licenses.gpl3Only;
    maintainers = [ ];
  };
}

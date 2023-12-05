{ lib
, fetchFromGitHub
, rustPlatform
, ffmpeg
, git
, nasm
, pkg-config
, openssl
, dbus
, ...
}:
let
  pname = "rescrobbled";
  version = "v0.7.1";
  sha256 = "sha256-1E+SeKjHCah+IFn2QLAyyv7jgEcZ1gtkh8iHgiVBuz4=";
  cargoHash = "sha256-zM9PJERZhPlgrMT4nLB8XyAFO94S3yxdLQI5Zhpcyds=";
in
rustPlatform.buildRustPackage {
  inherit pname version cargoHash;

  src = fetchFromGitHub {
    owner = "InputUsername";
    repo = pname;
    rev = version;
    inherit sha256;
  };

  nativeBuildInputs = [
    pkg-config
    dbus
  ];

  buildInputs = [
    ffmpeg
    git
    openssl
    dbus
    pkg-config
  ];
  checkFlags = [
    # reason for disabling test
    "--skip=filter::tests::test_filter_script"
  ];
  meta = with lib; {
    description = "MPRIS music scrobbler daemon";
    homepage = "https://github.com/InputUsername/rescrobbled";
    #license = licenses.gnu;
    maintainers = [ ];
  };
}

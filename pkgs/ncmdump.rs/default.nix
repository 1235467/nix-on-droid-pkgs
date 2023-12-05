{ lib
, fetchFromGitHub
, rustPlatform
  #, ffmpeg
, ...
}:
let
  pname = "ncmdump.rs";
  version = "97e6c36596773d2a34f562aed9b4d5d48499a5c6";
  sha256 = "sha256-hvziKZlGMLndWd7+Ntheb/7Ru6hpM+QOx1iUmj4cLz4=";
  cargoHash = "sha256-FMbPw9Nizvm+0k+Zi4EJhISqsUYf1IWMcQnTlLZ2XDk=";
in
rustPlatform.buildRustPackage {
  inherit pname version cargoHash;

  src = fetchFromGitHub {
    owner = "iqiziqi";
    repo = pname;
    rev = version;
    inherit sha256;
  };

  nativeBuildInputs = [
    #pkg-config
  ];

  buildInputs = [
    #ffmpeg
    #git
    #libvmaf
    #svt-av1
  ];

  meta = with lib; {
    description = "netease cloud music copyright protection file dump by rust";
    homepage = "https://github.com/iqiziqi/ncmdump.rs";
    license = licenses.mit;
    maintainers = [ ];
  };
}

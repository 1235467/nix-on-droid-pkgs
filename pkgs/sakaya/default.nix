{ lib
, fetchFromGitHub
, rustPlatform
, installShellFiles
, ...
}:
let
  pname = "sakaya";
  version = "76c1e69a5ff58657172f0e262b186df635b1181c";
  sha256 = "sha256-NIN+hBfiy+ihIfwHLIJRFQrSqJU1728N2jvZt+80I9I=";
in
rustPlatform.buildRustPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "donovanglover";
    repo = pname;
    rev = version;
    inherit sha256;
  };
  cargoLock = {
        lockFile = ./Cargo.lock;
      };


  nativeBuildInputs = [
    installShellFiles
  ];

  postInstall = ''
        installManPage target/man/sakaya.1

        installShellCompletion --cmd sakaya \
          --bash <(cat target/completions/sakaya.bash) \
          --fish <(cat target/completions/sakaya.fish) \
          --zsh <(cat target/completions/_sakaya)
      '';
}

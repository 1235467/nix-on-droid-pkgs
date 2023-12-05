{ lib, fetchFromGitHub, buildGoModule }:

buildGoModule {
  pname = "swgp-go";
  version = "eabed5f55311abea5d57bd01d4be4381d24a4c7c";

  src = fetchFromGitHub {
    owner = "database64128";
    repo = "swgp-go";
    rev = "eabed5f55311abea5d57bd01d4be4381d24a4c7c";
    sha256 ="sha256-lKLaTzaO/PplB+GpNicaqLcHhPVceSdRmvmdWYlLGc4=";
  };

  vendorHash = "sha256-3CjYLzLL4q/qCGxkqhSOCjQhe9RqSpmH5d7K3p257Tw=";
  doCheck = false;
  meta = with lib; {
    description = "🐉 Simple WireGuard proxy with minimal overhead for WireGuard traffic";
    homepage = "https://github.com/database64128/swgp-go";
    #license = licenses.mit;
    #maintainers = with maintainers; [ bcdarwin ];
  };
}

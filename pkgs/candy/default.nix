# 当你使用 pkgs.callPackage 函数时，这里的参数会用 Nixpkgs 的软件包和函数自动填充（如果有对应的话）
{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, spdlog
, libconfig
, uriparser
, openssl
, poco
, git
, zlib
, boost
, pkgs
, ...
} @ args:
let
  sources = pkgs.callPackage ../../_sources/generated.nix { };
in
stdenv.mkDerivation rec {
  # 指定包名和版本
  pname = "candy";
  inherit (sources.candy) version src;
  doCheck = false;
  #patches = [ ./no_download.patch ];
  # 并行编译，大幅加快打包速度，默认是启用的。对于极少数并行编译会失败的软件包，才需要禁用。
  enableParallelBuilding = true;

  nativeBuildInputs = [
  pkg-config
  cmake
  spdlog
  libconfig
  uriparser
  git
  poco
  zlib
  boost
  openssl
 ];
  BuildInputs = [
 openssl boost ];

  #cmakeFlags = [
  #  "-DCMAKE_BUILD_TYPE=Release"
  #];

  # stdenv.mkDerivation 自动帮你完成其余的步骤
}

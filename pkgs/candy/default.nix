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
, ...
} @ args:
let
  IXWebSocket = fetchFromGitHub {
    owner  = "machinezone";
    repo   = "IXWebSocket";
    #rev    = "e03c0be8a4c5fe89e2f67b76eb9b938eee35b495";
    #sha256 = "sha256-sJmL8aAAG50u0fm8pjNuajniw1wyM+iDGsAPplDqD5w=";
    rev = "ef57e3a2b14c17b1a05aed0079f55fac2ece4996";
    sha256 = "sha256-xEH33/or7IzgivILBlnhQyGsKrm9RM4MloGwC4PPKKM=";
    fetchSubmodules = true;
  };
in
stdenv.mkDerivation rec {
  # 指定包名和版本
  pname = "candy";
  version = "5.4";

  # 从 GitHub 下载源代码
  src = fetchFromGitHub ({
    owner = "lanthora";
    repo = pname;
    # 对应的 commit 或者 tag，注意 fetchFromGitHub 不能跟随 branch！
    rev = "v${version}";
    # 下载 git submodules，绝大部分软件包没有这个
    fetchSubmodules = true;
    sha256 = "sha256-cwRpgcVTjPTG7MunpxQlribjzPkdMDLB/3+AfSA4QMo=";
  });
   preConfigure = ''
    mkdir -p build/_deps
    cp -r ${IXWebSocket} build/_deps/ixwebsocket-src
    chmod -R +w build/_deps/
  '';
  doCheck = false;
  #patches = [ ./no_download.patch ];
  # 并行编译，大幅加快打包速度，默认是启用的。对于极少数并行编译会失败的软件包，才需要禁用。
  enableParallelBuilding = true;
  # 如果基于 CMake 的软件包在打包时出现了奇怪的错误，可以尝试启用此选项
  # 此选项禁用了对 CMake 软件包的一些自动修正
  #dontFixCmake = false;
  #dontUseCmakeConfigure = true;
  #buildPhase = ''
  #  mkdir -p build
  #  cd build
  #  cmake ..
  #  make
  #'';

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

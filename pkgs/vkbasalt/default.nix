{ lib
, stdenv
, fetchFromGitHub
, glslang
, meson
, ninja
, pkg-config
, libX11
, spirv-headers
, vulkan-headers
, vkbasalt
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "vkbasalt";
  version = "44e0b7ef31c1ec9565508289e74199ea2702d6b1";

  src = fetchFromGitHub {
    owner = "DadSchoorse";
    repo = "vkBasalt";
    rev = "44e0b7ef31c1ec9565508289e74199ea2702d6b1";
    hash = "sha256-IVlZ6o+1EEEh547rFPN7z+W+EY7MrIM/yUh6+PPkNeI=";
  };

  nativeBuildInputs = [ glslang meson ninja pkg-config ];
  buildInputs = [ libX11 spirv-headers vulkan-headers ];
  mesonFlags = [ "-Dappend_libdir_vkbasalt=true" ];

  postInstall = lib.optionalString (stdenv.hostPlatform.system == "x86_64-linux") ''
    install -Dm 644 $src/config/vkBasalt.conf $out/share/vkBasalt/vkBasalt.conf
    # Include 32bit layer in 64bit build
    ln -s ${vkbasalt}/share/vulkan/implicit_layer.d/vkBasalt.json \
      "$out/share/vulkan/implicit_layer.d/vkBasalt32.json"
  '';

  # We need to give the different layers separate names or else the loader
  # might try the 32-bit one first, fail and not attempt to load the 64-bit
  # layer under the same name.
  postFixup = ''
    substituteInPlace "$out/share/vulkan/implicit_layer.d/vkBasalt.json" \
      --replace "VK_LAYER_VKBASALT_post_processing" "VK_LAYER_VKBASALT_post_processing_${toString stdenv.hostPlatform.parsed.cpu.bits}"
  '';

  meta = with lib; {
    description = "A Vulkan post processing layer for Linux";
    homepage = "https://github.com/DadSchoorse/vkBasalt";
    license = licenses.zlib;
    maintainers = with maintainers; [ kira-bruneau ];
    platforms = platforms.linux;
  };
})


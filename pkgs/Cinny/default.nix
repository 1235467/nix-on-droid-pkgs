{ lib
, fetchFromGitHub
, rustPlatform
  #, copyDesktopItems
  #, wrapGAppsHook
, pkg-config
, openssl
  #, dbus
  #, glib
  #, glib-networking
, libayatana-appindicator
, webkitgtk
#, libappindicator-gtk3
  #, makeDesktopItem
}:

rustPlatform.buildRustPackage rec {
  pname = "Cinny";
  version = "8d64eff5a95985aae3b09cfa2b362f8c48978b4f";

  src = fetchFromGitHub {
    owner = "1235467";
    repo = pname;
    rev = version;
    hash = "sha256-0FCdI0xZ/QsVjc659HiFEC9NskK9icUibkcf20IdpH8=";
  };

  sourceRoot = "${src.name}/src-tauri";

  # modififying $cargoDepsCopy requires the lock to be vendored
  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "tauri-plugin-window-state-0.1.0" = "sha256-7Qi07yRb+ww569+sEXFIwAtS8jbUNQx6LsrUnMl5YOo=";
    };
  };
  nativeBuildInputs = [
    #copyDesktopItems
    #wrapGAppsHook
    pkg-config
  ];

  buildInputs = [
    openssl
    #dbus
    #glib
    #glib-networking
    libayatana-appindicator
    webkitgtk
    #libappindicator-gtk3
  ];

  postInstall = ''
    mv $out/bin/app $out/bin/cinny
    mkdir -p $out/lib
    cp -r ${libayatana-appindicator}/lib/libayatana-appindicator3.so $out/lib/
    cp -r ${libayatana-appindicator}/lib/libayatana-appindicator3.so.1 $out/lib/
  '';
  # The prepack script runs the build script, which we'd rather do in the build phase.

  meta = with lib; {
    description = "A modern web UI for various torrent clients with a Node.js backend and React frontend";
    homepage = "https://flood.js.org";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ winter ];
  };
}


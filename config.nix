let
  # Choose Pakcage Source

  ## Pinned nixpkgs master, deterministic. Last updated: 2021-03-20.
  pkgs = import (fetchTarball("https://github.com/NixOS/nixpkgs/archive/85141b8609cae8747d29ea9ca66e58828a3a85e4.tar.gz")) {};
  
  ## Rolling updates, not deterministic.
  #pkgs = import (fetchTarball("channel:nixpkgs-unstable")) {};
  
  ## System nixpkgs, not deterministic.
  #pkgs = import <nixpkgs> {config={allowUnfree = true;};};

  # Configure Packages

  ## Visual Studio Code
  extensions = (with pkgs.vscode-extensions; [
      ms-vsliveshare.vsliveshare
    ]);
  vscode-with-extensions = pkgs.vscode-with-extensions.override {
      vscodeExtensions = extensions;
    };
in
{
  allowUnfree = true;
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        (firefox.override { extraNativeMessagingHosts = [ passff-host ]; })
        pcmanfm shared_mime_info file
        gnumake gcc gcc-arm-embedded platformio openocd clang-tools
        git-cola
        mumble zoom-us
        thunderbird
        unzip
	libreoffice
        sshfs
	vscode-with-extensions
      ];
    };
    extraOutputsToInstall = [ "man" ];
  };
  services.vsliveshare = {
    enable = true;
    enableWritableWorkaround = true;
    enableDiagnosticsWorkaround = true;
  };
}

{ nixpkgs, arch }:

let
  host = "${arch}-w64-mingw32";

  host_as_var = nixpkgs.lib.replaceChars ["-"] ["_"] (nixpkgs.lib.toUpper host);

  binutils = import ./binutils { inherit nixpkgs host; };

  mingw-w64_info = rec {
    name = "mingw-w64-${version}";
    version = "2017-04-12";
    src = nixpkgs.fetchgit {
      url = "git://git.code.sf.net/p/mingw-w64/mingw-w64";
      rev = "bc766d1c5e553640b25f51afc9b9e0d6f7fdc344";
      sha256 = "0g8yjiarq36d6mwaykxjrmr40x6y56y1hkybqh4mm33gms9kdq9h";
    };
    patches = [
      ./usb.patch
      ./guid-selectany.patch
    ];
  };

  mingw-w64_headers = nixpkgs.stdenv.mkDerivation {
    name = "${mingw-w64_info.name}-headers";
    inherit (mingw-w64_info) src patches;
    preConfigure = "cd mingw-w64-headers";
    configureFlags = "--without-crt --enable-secure-api";
  };

  gcc_stage_1 = import ./gcc {
    stage = 1;
    libc = mingw-w64_headers;
    inherit nixpkgs arch binutils;
  };

  mingw-w64_full = nixpkgs.stdenv.mkDerivation {
    name = "${mingw-w64_info.name}-${host}";
    inherit host;
    inherit (mingw-w64_info) version src patches;
    buildInputs = [ binutils gcc_stage_1 ];
    builder = ./builder.sh;
  };

  gcc = import ./gcc {
    libc = mingw-w64_full;
    inherit nixpkgs arch binutils;
  };

  cmake_toolchain = import ../cmake_toolchain {
    cmake_system_name = "Windows";
    inherit nixpkgs host;
  };

  pkg-config = import ../pkgconf { inherit nixpkgs; };

  pkg-config-cross = import ../pkg-config-cross {
    inherit nixpkgs host host_as_var;
  };

  os = "windows";

  exe_suffix = ".exe";

  gyp_os = "win";

in
{
  # Target info
  inherit host arch os exe_suffix;

  # Toolchain
  inherit gcc binutils mingw-w64_full;

  # Build tools
  inherit pkg-config pkg-config-cross;

  # nixpkgs: a wide variety of programs and build tools
  inherit nixpkgs;

  # Expressions used to bootstrap the toolchain, not normally needed.
  inherit mingw-w64_info mingw-w64_headers gcc_stage_1;

  # Support for various build tools
  inherit cmake_toolchain gyp_os;
}

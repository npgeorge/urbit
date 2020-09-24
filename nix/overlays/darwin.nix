final: prev:

let

  isDarwin = prev.stdenv.hostPlatform.isDarwin;

  optionalsNull = xs:
    prev.lib.optionals (xs != null) xs;

  overrideWhen = cond: pkg: args:
    if cond then pkg.override args else pkg;

  overrideAttrsWhen = cond: pkg: f:
    if cond then pkg.overrideAttrs f else pkg;

in {
  libiconv = overrideAttrsWhen isDarwin prev.libiconv (old: {
    nativeBuildInputs =
      optionalsNull (old.nativeBuildInputs or {}) ++ [
        prev.buildPackages.stdenv.cc
      ];
  });

}

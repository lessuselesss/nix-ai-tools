{
  lib,
  buildNpmPackage,
  fetchurl,
  nodejs_22,
}:

buildNpmPackage (finalAttrs: {
  pname = "copilot-cli";
  version = "0.0.353";

  src = fetchurl {
    url = "https://registry.npmjs.org/@github/copilot/-/copilot-${finalAttrs.version}.tgz";
    hash = "sha256-JjQ8Xh7Ct+a6MK4om+3EB4Yancxdeb4CRAdzsIbcIX4=";
  };

  # Dependencies are bundled in the tarball
  npmDepsHash = "sha256-JhXoiLrG/CDNlgwSnhUG1wgLjnVmBKgz0twMx5wVbEE=";
  forceEmptyCache = true;

  nodejs = nodejs_22;

  dontNpmBuild = true;

  postPatch = ''
    # Create minimal package-lock.json for buildNpmPackage
    cat > package-lock.json << 'EOF'
    {
      "name": "@github/copilot",
      "lockfileVersion": 3,
      "requires": true,
      "packages": {}
    }
    EOF
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/${finalAttrs.pname}
    cp -r . $out/lib/${finalAttrs.pname}

    mkdir -p $out/bin
    makeWrapper ${nodejs_22}/bin/node $out/bin/copilot \
      --add-flags "$out/lib/${finalAttrs.pname}/index.js"

    runHook postInstall
  '';

  meta = {
    description = "GitHub Copilot CLI brings the power of Copilot coding agent directly to your terminal.";
    homepage = "https://github.com/github/copilot-cli";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "copilot";
  };
})

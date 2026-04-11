{
  stdenvNoCC,
  fetchurl,
  fetchFromGitHub,
  lib,
  imagemagick,
  ffmpeg,
  gifLocal ? null,
  gifSource ? "",
  gifHash ? "",
}:

let
  plymouthDir = "$out/share/plymouth/themes/gifmouth";
  gif =
    if gifLocal == null && gifSource == "" then
      "./example.gif"
    else if gifLocal != null then
      gifLocal
    else
      fetchurl {
        url = gifSource;
        hash = gifHash;
      };
in
stdenvNoCC.mkDerivation {
  pname = "plymouth-gifmouth-theme";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "RemuSalminen";
    repo = "gifmouth-plymouth-theme";
    rev = "873201665aff1cc9a1ddc88463bbcc5826fe9340";
    hash = "sha256-0khA/mjV8qMF7hb02tx8z/OQ0BVRvMRDpH/8yzVLROU=";
  };

  nativeBuildInputs = [
    imagemagick
    ffmpeg
  ];

  buildPhase = ''
    runHook preBuild

    ./gifmouth.sh ${gif}

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p ${plymouthDir}
    mkdir ${plymouthDir}/frames
    mkdir ${plymouthDir}/scripts

    cp gifmouth.plymouth ${plymouthDir}
    cp frames/* ${plymouthDir}/frames/
    cp scripts/gifmouth.script ${plymouthDir}/scripts/

    substituteInPlace ${plymouthDir}/gifmouth.plymouth --replace-fail "/usr/" "$out/"

    runHook postInstall
  '';

  meta = {
    description = "Plymouth theme that turns any GIF/Video into an Animated theme";
    homepage = "https://github.com/RemuSalminen/gifmouth-plymouth-theme";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ mooses ];
  };
}

# https://lantian.pub/en/article/modify-computer/nixos-packaging.lantian/
# https://ryantm.github.io/nixpkgs/builders/fetchers/
# https://discourse.nixos.org/t/packaging-a-bash-script-issues/20224/3 ## Debug Building on a Flake based system

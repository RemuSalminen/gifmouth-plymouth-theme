{
	stdenvNoCC,
	fetchurl,
	lib,
	bash,
	imagemagick,
	coreutils,
	gifSource ? "",
	gifHash ? "",
}:

assert gifSource != "" || throw "GIF source not defined! package.override { gifSource = '<link>'; }";

let
	plymouthDir = "$out/share/plymouth/themes/gifmouth";
	gif = fetchurl {
		url = gifSource;
		hash = gifHash;
	};
in
stdenvNoCC.mkDerivation {
	pname = "plymouth-gifmouth-theme";
	version = "1.0.0";
	src = ./.;

	nativeBuildInputs = [
		imagemagick
		bash
		coreutils
	];

	buildPhase = ''
		runHook preBuild

		${lib.getExe bash} ./gifmouth.sh ${gif}

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

	meta = {};
}

# https://lantian.pub/en/article/modify-computer/nixos-packaging.lantian/
# https://ryantm.github.io/nixpkgs/builders/fetchers/
# https://discourse.nixos.org/t/packaging-a-bash-script-issues/20224/3 ## Debug Building on a Flake based system

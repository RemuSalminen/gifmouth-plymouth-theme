{
	stdenvNoCC,
	imagemagick,
	coreutils,
	fetchurl,
	bash,
	gifSource ? "",
	gifHash ? "",
}:

assert gifSource != "" || throw "GIF source not defined! package.override { gifSource = '<link>'; }";

let
	plymouthDir = "$out/share/plymouth/themes/customGif";
	gif = fetchurl {
		url = gifSource;
		hash = gifHash;
	};
in
stdenvNoCC.mkDerivation {
	pname = "plymouth-customGif";
	version = "1.0.0";
	src = ./.;

	buildInputs = [
		imagemagick
		coreutils
	];

	buildPhase = ''
		substituteInPlace customGif.sh --replace-fail '/usr/bin/env bash' ${bash}/bin/bash
		./customGif.sh ${gif}
	'';

	installPhase = ''
		runHook preInstall
		mkdir -p ${plymouthDir}
		cp -r ./* ${plymouthDir}
		substituteInPlace ${plymouthDir}/customGif.plymouth --replace-fail "/usr/" "$out/"
		runHook postInstall
	'';

	meta = {};
}

# https://lantian.pub/en/article/modify-computer/nixos-packaging.lantian/
# https://ryantm.github.io/nixpkgs/builders/fetchers/
# https://discourse.nixos.org/t/packaging-a-bash-script-issues/20224/3 ## Debug Building on a Flake based system

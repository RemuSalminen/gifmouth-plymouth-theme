# gifmouth: A Plymouth Theme

A Plymouth theme that can be used to dynamically generate a boot splash from any GIF you can think of!

## Installation / Usage
### NixOS (with flakes)
Include the source:
```nix
{
	inputs = {
		plymouth-gifmouth-theme = {
			url = "github:RemuSalminen/gifmouth-plymouth-theme";
			flake = false;
		};
	};
}
```
Define it as a themePackage:
```nix
{
	boot.plymouth = {
		enable = true;
		theme = "gifmouth";
		themePackages = [
			(pkgs.callPackage (inputs.plymouth-gifmouth-theme + /package.nix) {
				gifSource = "URL";
				gifHash = "HASH";
			});
		];
	};
}
```
Remember to change URL and HASH with their corresponding values.
<details>
<summary><strong>Accessing the Package from pkgs</strong></summary>

For convenience, it might be reasonable to overlay the package on top of nixpkgs instead.

```nix
nixpkgs.overlays = [
	(final: prev: {
		plymouth-gifmouth-theme = pkgs.callPackage (inputs.plymouth-gifmouth-theme + /package.nix) {
			gifSource = "URL";
			gifHash = "HASH";
		};
	})
];
```
Then, the usage changes to:
```nix
{
	boot.plymouth = {
		enable = true;
		theme = "gifmouth";
		themePackages = [
			pkgs.plymouth-gifmouth-theme
		];
	};
}
```
The URL & HASH defined when overlayed can be overridden:
```nix
{
	boot.plymouth = {
		enable = true;
		theme = "gifmouth";
		themePackages = [
			(pkgs.plymouth-gifmouth-theme.override {
				gifSource = "URL";
				gifHash = "HASH";
			});
		];
	};
}
```

</details>

### Other Linux Distros
To prepare the Theme, execute the script with the path to the GIF as an argument.
```bash
$ ./gifmouth.sh <path-to-GIF>
```
This will split the GIF to its frames (using ImageMagick) and construct the Plymouth script based on their count.

It will result in the following file structure.
```
.
├── frames
│   ├── frame-###.png
│   └── README
├── gifmouth.plymouth
├── gifmouth.sh
├── package.nix
├── README
└── scripts
    ├── gifmouth.script
    └── gifmouth.script.template
```
Now copy the `frames` folder, `gifmouth.plymouth`, and `scripts/gifmouth.script` into `/usr/share/plymouth/themes/gifmouth` whilst maintaining their folder structure. Alternatively, you can git clone this repository directly into the themes directory, allowing quicker changing of the GIF. Or Symlink the files. The method doesn't matter, as long as the files are present.

To actually change the theme, run `plymouth-set-default-theme -R gifmouth`.

If it does not work, consult your distro's documentation.

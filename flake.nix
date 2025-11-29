{
    description = "test docker shit";

    inputs.nixpkgs.url="github:NixOS/nixpkgs/nixos-25.05-small";

    outputs = { self, nixpkgs }: let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in {
        packages.${system}.rddc_image = pkgs.dockerTools.buildImage {
            name = "rddc_image-v0.1.0";
            tag = "amd64";
 
            copyToRoot = [
                pkgs.nix
                pkgs.bash
                pkgs.coreutils

                pkgs.gnumake42
                pkgs.cmake
                pkgs.gcc15

                pkgs.qt6.qtbase
            ];

            runAsRoot = ''
                ${pkgs.dockerTools.shadowSetup}

                groupadd -g 1000 sherman
                useradd -m -u 1000 -g 1000 sherman
            '';
            #    mkdir /testdir
            #    chown -R sherman:sherman /testdir
            #'';
            created="now";
            config = {
                WorkingDir="/workbench";
                User="sherman";
                Cmd=[ "/bin/bash" ];
                Volumes = {
                    "/workbench" = {};
                };
            };
        };
    };
}

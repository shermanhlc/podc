# can be run with:
# V_USER=$USER V_UID=$UID nix build .#rddc_image --impure && docker load < result

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

            runAsRoot = let
                user = builtins.getEnv "V_USER";
                uid = builtins.getEnv "V_UID";
            in ''
                ${pkgs.dockerTools.shadowSetup}

                groupadd -g ${uid} ${user}
                useradd -m -u ${uid} -g ${uid} ${user}
            '';
            #    mkdir /testdir
            #    chown -R sherman:sherman /testdir
            #'';
            created="now";
            config = {
                WorkingDir="/workbench";
                User=builtins.getEnv "V_USER";
                Cmd=[ "/bin/bash" ];
                Volumes = {
                    "/workbench" = {};
                };
            };
        };
    };
}

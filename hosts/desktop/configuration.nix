{
  config,
  username,
  pkgs,
  home-manager,
  ...
}:
{
  users = {
    users = {
      "${username}" = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        useDefaultShell = true;
      };
    };
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ amdvlk ];
  };

  containers =
    let
      hostCfg = config;
      userName = "browser-user";
      userUid = hostCfg.users.users."${username}".uid;
    in
    {
      browser = {
        ephemeral = true;
        bindMounts = {
          waylandDisplay = rec {
            hostPath = "/run/user/${toString userUid}";
            mountPoint = hostPath;
          };
        };

        specialArgs = { inherit home-manager; };
        config =
          {
            home-manager,
            pkgs,
            ...
          }:
          {
            imports = [ home-manager.nixosModules.home-manager ];

            system.stateVersion = hostCfg.system.stateVersion;

            hardware.graphics = {
              enable = true;
              extraPackages = hostCfg.hardware.graphics.extraPackages;
            };

            services.getty.autologinUser = userName;
            users = {
              mutableUsers = false;
              users = {
                root.password = "";
                "${userName}" = {
                  uid = userUid;
                  password = "";
                  isNormalUser = true;
                  home = "/home";
                };
              };
            };

            environment.sessionVariables = {
              WAYLAND_DISPLAY = "wayland-1";
              MOZ_ENABLE_WAYLAND = "1";
              XDG_RUNTIME_DIR = "/run/user/${toString userUid}";
              DISPLAY = ":0";
            };

            home-manager = {
              useGlobalPkgs = true;
              users."${userName}" = {
                home.stateVersion = hostCfg.system.stateVersion;

                programs.firefox = {
                  enable = true;
                };
              };
            };

            systemd.services.fix-run-permission = {
              script = ''
                #!${pkgs.stdenv.shell}
                set -euo pipefail

                chown ${userName} /run/user/${toString userUid}
                chmod u=rwx /run/user/${toString userUid}
              '';
              wantedBy = [ "multi-user.target" ];
              serviceConfig = {
                Type = "oneshot";
              };
            };
          };
      };
    };
}

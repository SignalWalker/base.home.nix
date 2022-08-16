{
  config,
  pkgs,
  ...
}: {
  config = {
    home.packages = with pkgs; [
      mosh
    ];
    programs.ssh = {
      enable = true;
      controlMaster = "auto";
      controlPath = "$\{XDG_RUNTIME_DIR\}/ssh/socket-%r@%h:%p";
      controlPersist = "6m";
      extraOptionOverrides = {
        Ciphers = "aes128-gcm@openssh.com,aes256-gcm@openssh.com,chacha20-poly1305@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr";
      };
      matchBlocks = {
        "github.com" = {
          user = "git";
        };
        "gitlab.com" = {
          user = "git";
        };
      };
    };
  };
}

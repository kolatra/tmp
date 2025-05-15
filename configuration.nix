# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  networking.hostName = "laptop"; # Define your hostname.

  # enable internet
  networking.networkmanager.enable = true;

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # desktop
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "tyler";

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tyler = {
    isNormalUser = true;
    description = "tyler";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEdQDJEnAKSK5MECKcpzcNFgPSs0BnHwCi53U88YTFN tyler" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     unzip
     p7zip
     git
     btop
     kitty
     fastfetch
     rofi-wayland
     waybar
     discord
     brightnessctl
     obsidian
     nemo-with-extensions
     nemo
  ];
  programs.firefox.enable = true;
  # programs.thunar.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings = {
    X11Forwarding = true;
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };
  services.openssh.openFirewall = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "24.11";

}

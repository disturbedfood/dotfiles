# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  virtualisation.virtualbox.guest.enable = true;
  boot.initrd.checkJournalingFS = false; 

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "dfood-virtual"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "no";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    bspwm
    python27Packages.python
    rxvt_unicode
    sxhkd
    dmenu
    git
    linuxPackages.virtualboxGuestAdditions
    xorg.xmodmap
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "no";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.videoDriver = "virtualbox";

  services.xserver.displayManager = {
    slim.enable = true;
    slim.defaultUser = "dfood";
    
	sessionCommands = "
	${pkgs.sxhkd}/bin/sxhkd &
	${pkgs.rxvt_unicode}/bin/urxvt &";
        
  };
  fonts = {
	enableFontDir = true;
	enableGhostscriptFonts = true;
	fonts = with pkgs; [
		fira-mono
	];
};
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.windowManager.default = "bspwm";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.dfood = {
    isNormalUser = true;
    group = "users";
    createHome = true;
    description = "Gjermund Ask";
    home = "/home/dfood";
    uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}

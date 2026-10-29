{...}: {
  # Define flake part nixosModule "hostConfiguration" and pass in arch specific pkgs
  flake.nixosModules.hostConfiguration = {pkgs, ...}: {
    # Normal nix code within module, add git to systemPackages
    environment.systemPackages = with pkgs; [

    ];

    ###
    # HARDWARE CONFIG
    ###
    # enable lenovo_ideapad specific conservation mode
    systemd.tmpfiles.rules = [
      "w /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode - - - - 1"
    ];

    services.hardware.openrgb.enable = true;
    services.udev.packages = [ pkgs.openrgb ];
    boot.kernelModules = [ "i2c-dev" "i2c-i801" "i2c-smbus" ];
    hardware.i2c.enable = true;

    hardware.opentabletdriver.enable = true;
    services.printing.enable = true;

    # Enable automatic login for the user.
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "derrix";


  };
}

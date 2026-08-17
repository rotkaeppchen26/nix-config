{pkgs, ...}:
{
# Allow execution of random binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Any missing dyn libs for unpackaged programs here, NOT in environment.systemPackagres
    libusb1
    libusbsio
    pkg-config
    glew glfw
    glibc
    zlib
    libgcc
    stdenv.cc.cc
    libGL
    libGLU
    libx11
    libxrandr
    libxcursor
    libxi
    libxinerama
    alsa-lib pulseaudio
    libudev-zero
    ffmpeg_4
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    libva
    sdl2-compat
  ];
}

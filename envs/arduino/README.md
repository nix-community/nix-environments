## buildFHSUserEnv for Arduino IDE 

Arduino will also download additional binaries into the users home.
That's why we need to use a sandbox created by:
[buildFHSUserEnv](https://nixos.org/nixpkgs/manual/#sec-fhs-environments)
to avoid the use of [patchelf](https://nixos.org/patchelf.html).

The environment was only tested with an ESP32. It might be that
other targets require additional dependencies. Just make a pull request
in this case. If that does not work, you might as well try platformio.

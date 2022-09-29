# cc2538-bsl environment (used for TI CC13xx/CC2538/CC26xx upgrades - zigbee2mqtt)
Used for: https://github.com/JelmerT/cc2538-bsl
Howto flash: https://www.zigbee2mqtt.io/guide/adapters/flashing/flashing_via_cc2538-bsl.html

```console
$ nix-shell https://github.com/nix-community/nix-environments/archive/master.tar.gz -A cc2538-bsl
[nix-shell] $ sudo python3 cc2538-bsl.py -ewv -p /dev/ttyUSB0 --bootloader-sonoff-usb ./XXXXX.hex
```

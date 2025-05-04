# NixOS Config

*Do not use that repo directly, it will cause u pain!*

It is actually my nixos config. Nothing really special here, but if u somehow found that repo useful feel free to use some concepts from it 

Basically i have two hosts:
- `nixarchy` (desktop)
- `nixtop` (laptop)

It named such because I use arch btw, but now exploring nixos

If u want to use that repo then:
1. add your own host to `./hosts/` like the `./hosts/nixarchy/` but probably u do not need `systemd` to mount your drive with my UUID ;)
2. update `./flake.nix` - add your host
3. in `./home_manager/` we can PROBABLY find some files which optionally run if we are on specific host (yes, hostname specific configs) so CAREFULLY read and validate it pls
4. anyway my suggestion is MADE IT YOURSELF by looking at my config as example (actually bad example) but be sure what everything was configured exactly how u want it to be

If you have any ideas how to make that config better - feel free to open issue, will be glad to learn

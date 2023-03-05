# dotfiles

My configuration files :^)

## To look into:
- https://www.youtube.com/watch?v=t8ydCYe9Y3M
- `nixos-rebuild build-vm`
- How do i permanently remove `192.168.1.1` from `/etc/resolv.conf`? Or maybe
  putting `1.1.1.1` before that would work?

## To not forget
```nix
boot.binfmt.emulatedSystems = [ "riscv64-linux" "mipsel-linux" ... ];
```

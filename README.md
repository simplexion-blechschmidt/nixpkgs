```bash
mkdir -p ~/repos ~/.config
git clone git@github.com:simplexion-blechschmidt/nixpkgs.git ~/repos/nixpkgs
ln -s ~/repos/nixpkgs ~/.config/nixpkgs
```

```
nix-env -irA nixos.myPackages
```

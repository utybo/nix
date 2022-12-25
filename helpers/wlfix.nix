pkgs: package:
package.overrideAttrs (old: {
  runtimeDependencies = old.runtimeDependencies ++ [ pkgs.wayland ];
})

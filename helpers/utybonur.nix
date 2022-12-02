{ pkgs, ... }:

{
  utybonur = import (builtins.fetchTarball "https://github.com/utybo/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };
}

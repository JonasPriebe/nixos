{ lib }:

let
  loadModules = dir:
    let
      entries = builtins.readDir dir;

      names = lib.filterAttrs
        (name: type:
          (type == "regular"
            && lib.hasSuffix ".nix" name
            && name != "default.nix")
          || type == "directory"
        )
        entries;
    in
    lib.mapAttrs'
      (name: type:
        let
          path = dir + "/${name}";
          key =
            if type == "directory"
            then name
            else lib.removeSuffix ".nix" name;
          value =
            if type == "directory"
            then loadModules path
            else path;
        in
        {
          name = key;
          inherit value;
        })
      names;
in
loadModules ./.

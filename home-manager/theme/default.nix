{ customLib, ... }:
{
  imports = customLib.getPaths.excludeDefaultAndDirs ./.;
}

{ customLib, ... }: with customLib; { imports = getPaths.excludeDefaultAndDirs ./.; }

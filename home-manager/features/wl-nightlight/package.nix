{ rustPlatform, fetchFromGitHub, ... }:
rustPlatform.buildRustPackage rec {
  pname = "wl-nightlight";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "PerfectionistCoder";
    repo = "wl-nightlight";
    rev = "d804ba033efbf282529815d8341e285805851972";
    hash = "sha256-nYKCN/wb7uHA4OySeBKU60KDfbp9whfx9IT1kO4sYEE=";
  };

  cargoLock.lockFile = src + "/Cargo.lock";
  doCheck = false;

  meta.mainProgram = "wl-nightlight";
}

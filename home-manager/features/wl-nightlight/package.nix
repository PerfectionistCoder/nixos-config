{ rustPlatform, fetchFromGitHub, ... }:
rustPlatform.buildRustPackage rec {
  pname = "wl-nightlight";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "PerfectionistCoder";
    repo = "wl-nightlight";
    rev = "0df38e8642869cb83cbe4ddd72bdf5d74d50d885";
    hash = "sha256-Mzfg9FX6KD6zxvCzuZb1FLnYqARG65oLWX+IDXjW294=";
  };

  cargoHash = "sha256-639GHT3l+yXi8y3N+HhExEZAwBZzvJ7xDpXW1+PQfGI=";
  doCheck = false;
}

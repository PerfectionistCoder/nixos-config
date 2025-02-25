[
  (final: prev: {
    extra-container = prev.extra-container.overrideAttrs {
      version = "0.13";
      src = prev.fetchFromGitHub {
        owner = "erikarvstedt";
        repo = "extra-container";
        rev = "fa723fb67201c1b4610fd3d608681da362f800eb";
        hash = "sha256-wnRkafo4YrIuvJeRsOmfStxIzi7ty2I0OtGMO9chwJc=";
      };
    };
  })
]

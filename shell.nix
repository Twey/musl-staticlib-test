let
  inherit (import <nixpkgs> { }) fetchFromGitHub;
  mozilla = import (fetchFromGitHub {
    owner  = "mozilla";
    repo   = "nixpkgs-mozilla";
    rev    = "b52a8b7de89b1fac49302cbaffd4caed4551515f";
    sha256 = "1np4fmcrg6kwlmairyacvhprqixrk7x9h89k813safnlgbgqwrqb";
  });
  inherit (import <nixpkgs> { overlays = [mozilla]; })
    rustChannelOf
    mkShell
  ;
  rust = (rustChannelOf {
    channel = "nightly";
    date    = "2019-09-23";
    sha256  = "1h9f5dwz7p0mbdwa9q2y1hb3fk2r1yh8sgqnchzavdjicx7kpw1g";
  }).rust.override {
    targets    = ["x86_64-unknown-linux-musl"];
    extensions = ["rust-src"];
  };
in mkShell { buildInputs = [rust]; }

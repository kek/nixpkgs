{ buildPythonPackage
, lib
, fetchgit
, requests
, distro
, makeWrapper
, extraHandlers ? []
}:

buildPythonPackage rec {
  pname = "ssh-import-id";
  version = "5.11";

  src = fetchgit {
    url = "https://git.launchpad.net/ssh-import-id";
    rev = version;
    sha256 = "sha256-tYbaJGH59qyvjp4kwo3ZFVs0EaE0Lsd2CQ6iraFkAdI=";
  };

  propagatedBuildInputs = [
    requests
    distro
  ] ++ extraHandlers;

  nativeBuildInputs = [
    makeWrapper
  ];

  # handlers require main bin, main bin requires handlers
  makeWrapperArgs = [ "--prefix" ":" "$out/bin" ];

  meta = with lib; {
    description = "Retrieves an SSH public key and installs it locally";
    license = licenses.gpl3;
    maintainers = with maintainers; [ mkg20001 ];
    platforms = platforms.unix;
  };
}

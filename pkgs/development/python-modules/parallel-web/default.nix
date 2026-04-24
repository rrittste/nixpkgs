{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,

  anyio,
  distro,
  httpx,
  pydantic,
  sniffio,
  typing-extensions,
}:

buildPythonPackage (finalAttrs: {
  pname = "parallel-web";
  version = "0.5.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "parallel-web";
    repo = "parallel-sdk-python";
    tag = "v${finalAttrs.version}";
    hash = "sha256-x/usp9kg75SNok4PFuGkuiBTYeGJMgvhOjcEsMP6L+0=";
  };

  build-system = [ setuptools ];

  dependencies = [
    anyio
    distro
    httpx
    pydantic
    sniffio
    typing-extensions
  ];

  pythonRelaxDeps = [
    "pydantic"
  ];

  doCheck = false;

  pythonImportsCheck = [ "parallel" ];

  meta = {
    description = "Official Python SDK for the Parallel API";
    homepage = "https://github.com/parallel-web/parallel-sdk-python";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
})

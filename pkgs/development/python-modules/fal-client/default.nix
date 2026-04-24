{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools-scm,

  httpx,
  httpx-sse,
  msgpack,
  websockets,
}:

buildPythonPackage (finalAttrs: {
  pname = "fal-client";
  version = "0.13.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "fal-ai";
    repo = "fal";
    tag = "fal_client_v${finalAttrs.version}";
    hash = "sha256-oUDJrsDSMY9wntIM4PKLsUf+ZU+owQWVFK/Dl9yacfM=";
  };

  sourceRoot = "${finalAttrs.src.name}/projects/fal_client";

  build-system = [
    setuptools
    setuptools-scm
  ];

  dependencies = [
    httpx
    httpx-sse
    msgpack
    websockets
  ];

  pythonRelaxDeps = [
    "httpx-sse"
  ];

  doCheck = false;

  pythonImportsCheck = [ "fal_client" ];

  meta = {
    description = "Python client for fal.ai ML model deployment platform";
    homepage = "https://github.com/fal-ai/fal";
    license = lib.licenses.asl20;
    maintainers = [ ];
  };
})

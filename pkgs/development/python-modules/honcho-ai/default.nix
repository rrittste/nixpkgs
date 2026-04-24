{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,

  httpx,
  pydantic,
  typing-extensions,
}:

buildPythonPackage (finalAttrs: {
  pname = "honcho-ai";
  version = "2.1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "plastic-labs";
    repo = "honcho";
    tag = "v${finalAttrs.version}";
    hash = "sha256-wIqsXrn8428ZBCBa9YdNiEHZDMJDmWxmMwEMDl1RBkQ=";
  };

  sourceRoot = "${finalAttrs.src.name}/sdks/python";

  build-system = [ setuptools ];

  dependencies = [
    httpx
    pydantic
    typing-extensions
  ];

  pythonRelaxDeps = [
    "pydantic"
  ];

  doCheck = false;

  pythonImportsCheck = [ "honcho_ai" ];

  meta = {
    description = "Python SDK for Honcho conversational memory platform";
    homepage = "https://github.com/plastic-labs/honcho";
    license = lib.licenses.asl20;
    maintainers = [ ];
  };
})

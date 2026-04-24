{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,

  httpx,
  httpcore,
  openai,
  pydantic,
  python-dotenv,
  requests,
  typing-extensions,
}:

buildPythonPackage (finalAttrs: {
  pname = "exa-py";
  version = "2.12.0";
  pyproject = true;

  src = fetchPypi {
    inherit (finalAttrs) pname version;
    hash = "sha256-LNX+LUfY4CIfh9yyvg8AfMCh8KZDsW38WGqxQhmY9Pw=";
  };

  build-system = [ setuptools ];

  dependencies = [
    httpx
    httpcore
    openai
    pydantic
    python-dotenv
    requests
    typing-extensions
  ];

  pythonRelaxDeps = [
    "openai"
    "pydantic"
  ];

  doCheck = false;

  pythonImportsCheck = [ "exa_py" ];

  meta = {
    description = "Official Python SDK for the Exa search API";
    homepage = "https://github.com/exa-labs/exa-py";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
})

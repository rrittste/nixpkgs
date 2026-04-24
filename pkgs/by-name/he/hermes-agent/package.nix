{
  lib,
  fetchFromGitHub,
  nix-update-script,
  python3Packages,
  ffmpeg,
  git,
  nodejs_22,
  openssh,
  ripgrep,
  tirith,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "hermes-agent";
  version = "0.10.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "NousResearch";
    repo = "hermes-agent";
    tag = "v2026.4.16";
    hash = "sha256-+Kltn1Ar0Ye4iBc6UVwvNPGI0uIgnCktl4Obh964/60=";
  };

  build-system = with python3Packages; [ setuptools ];

  pythonRelaxDeps = [
    "openai"
    "anthropic"
    "httpx"
    "rich"
    "tenacity"
    "pydantic"
    "prompt-toolkit"
    "exa-py"
    "firecrawl-py"
    "parallel-web"
    "fal-client"
    "edge-tts"
    "PyJWT"
    "python-dotenv"
    "jinja2"
    "requests"
    "fire"
  ];

  dependencies =
    with python3Packages;
    [
      openai
      anthropic
      python-dotenv
      fire
      httpx
      socksio
      rich
      tenacity
      pyyaml
      requests
      jinja2
      pydantic
      prompt-toolkit
      exa-py
      firecrawl-py
      parallel-web
      fal-client
      edge-tts
      pyjwt
      cryptography
    ]
    ++ pyjwt.optional-dependencies.crypto;

  optional-dependencies = with python3Packages; {
    messaging = [
      python-telegram-bot
      discordpy
      aiohttp
      slack-bolt
      slack-sdk
      qrcode
    ];
    cron = [ croniter ];
    cli = [ simple-term-menu ];
    tts-premium = [ elevenlabs ];
    honcho = [ honcho-ai ];
    mcp = [ mcp ];
    acp = [ agent-client-protocol ];
    voice = [
      faster-whisper
      sounddevice
      numpy
    ];
    mistral = [ mistralai ];
    bedrock = [ boto3 ];
    pty = [ ptyprocess ];
  };

  makeWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    (lib.makeBinPath [
      nodejs_22
      ripgrep
      git
      openssh
      ffmpeg
      tirith
    ])
  ];

  doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Self-improving AI agent with built-in learning loop and multi-platform messaging";
    homepage = "https://github.com/NousResearch/hermes-agent";
    changelog = "https://github.com/NousResearch/hermes-agent/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = [ ];
    mainProgram = "hermes";
    platforms = lib.platforms.unix;
  };
})

{ config, ... } : {
  nixpkgs.overlays = [
    (final: prev: {
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (
          _: python-prev: {
            rapidocr-onnxruntime = python-prev.rapidocr-onnxruntime.overridePythonAttrs (self: {
              pythonImportsCheck = if python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64 then [] else ["rapidocr_onnxruntime"];
              doCheck = !(python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64);
              meta = self.meta // { badPlatforms = []; broken = false; };
            });

            chromadb = python-prev.chromadb.overridePythonAttrs (self: {
              pythonImportsCheck = if python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64 then [] else ["chromadb"];
              doCheck = !(python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64);
              meta = self.meta // { broken = false; };
            });

            langchain-chroma = python-prev.langchain-chroma.overridePythonAttrs (_: {
              pythonImportsCheck = if python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64 then [] else ["langchain_chroma"];
              doCheck = !(python-prev.stdenv.isLinux && python-prev.stdenv.isAarch64);
            });
          }
        )
      ];
    })
  ];
	services.open-webui = {
	  enable = true;
	  port = 2855;
	  environmentFile = config.age.secrets.openwebui_env.path;
	};
}

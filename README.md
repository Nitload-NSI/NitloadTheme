# NitloadTheme

A Visual Studio 2026 color theme assembled from multiple existing theme ideas and resources.

## Overview

NitloadTheme is a custom Visual Studio 2026 theme built by combining and adjusting color choices from:

- **[NordFluentTheme](https://github.com/robin88chen/NordFluentTheme)** by robin88chen
- **[ManyShadesOfGrayTheme](https://github.com/jiripolasek/ManyShadesOfGrayTheme)** by jiripolasek

## Attribution

This repository documents that the theme was stitched together with reference to the two projects above. Full credit for the original source themes belongs to their respective authors.

| Source Theme | Author | Upstream License Status |
|---|---|---|
| [NordFluentTheme](https://github.com/robin88chen/NordFluentTheme) | robin88chen | No explicit license published in the upstream repository |
| [ManyShadesOfGrayTheme](https://github.com/jiripolasek/ManyShadesOfGrayTheme) | jiripolasek | Apache License 2.0 |

## License

This repository includes an Apache License 2.0 text in [LICENSE](LICENSE) for the parts that can be distributed under that license.

Because NordFluentTheme currently does not declare an explicit upstream license, you should treat any material derived from it as requiring upstream permission or replacement before broader redistribution.

## Build

This repository is configured to build with the Visual Studio 2026 toolchain.

Use PowerShell:

```powershell
.\build.ps1
```

The script locates MSBuild from Visual Studio 2026 only and passes `VisualStudioVersion=18.0` explicitly. If only Visual Studio 2022 is installed, the script will fail instead of silently building with the wrong toolchain.

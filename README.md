# DrakOps for Omarchy

A small Omarchy Quattro bar widget. Click the purple terminal icon to open DrakOps. It does not show devices or start an SSH session.

## Requirements

- Omarchy Quattro with its Quickshell bar and plugin support.
- [DrakOps](https://github.com/drakahari/DrakOps/releases) installed separately and available in the app launcher as `drakops.desktop`. If it is missing, the widget is dimmed and the tooltip explains why. The plugin does not install DrakOps.

## Install

```sh
omarchy plugin add https://github.com/drakahari/omarchy-drakops.git
omarchy plugin enable io.github.drakahari.drakops --section right
```

If asked to enable immediately, choose No to inspect the code first. Run the second command when ready.

## Remove

```sh
omarchy plugin remove io.github.drakahari.drakops
```

Removing the widget does not remove DrakOps or change its settings.

## What it can access

The widget looks up only the fixed DrakOps desktop entry through Quickshell and launches it on activation. It does not request elevated access, run shell commands, access DrakOps inventory or SSH keys, or make network requests. Quickshell plugins run within the shell, not as sandboxed applications.

This repository's widget is licensed under the MIT License. That license does not apply to the separately distributed DrakOps app, which is not included here.

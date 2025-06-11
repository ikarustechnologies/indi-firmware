# kstars.sh

This script automates the installation of Kstars Flatpak package and the necessary INDI firmware and udev rules for various astronomical devices. It also installs the Flatpak if not exists.

## Features

- Automatically installs Flatpak on supported Linux distributions (Debian/Ubuntu, Fedora, Arch Linux).
- Clones the `indi-firmware` repository.
- Copies udev rules to `/lib/udev/rules.d`.
- Copies firmware files to `/lib/firmware` and `/lib/firmware/qhy`.
- Reloads udev rules.
- Adds Flathub and StellarMate Hub Flatpak remotes.
- Installs KDE Platform and SDK runtimes.
- Installs the KStars Flatpak package.
- Cleans up the cloned repository.

## Supported Operating Systems for Automatic Flatpak Installation

- Debian/Ubuntu
- Fedora
- Arch Linux

For other Linux distributions, you will need to install Flatpak manually before running this script.

## Prerequisites

- A supported Linux distribution (for automatic Flatpak installation).
- `sudo` access.
- `git` installed.

## Usage

Download the script and Run

```bash
wget https://raw.githubusercontent.com/ikarustechnologies/indi-firmware/main/kstars.sh
sudo bash kstars.sh
```

The script will guide you through the installation process. You may be prompted for your password for `sudo` commands.

## Manual Flatpak Installation (for unsupported distributions or macOS)

If your operating system is not listed under "Supported Operating Systems for Automatic Flatpak Installation", you need to install Flatpak manually before running this script.

-   **For other Linux distributions:** Refer to the official Flatpak documentation for installation instructions specific to your distribution: [https://flatpak.org/setup/](https://flatpak.org/setup/)

Once Flatpak is installed, you can run the `flatpak.sh` script. The script will detect the existing Flatpak installation and proceed with the rest of the steps (cloning the repository, copying files, adding remotes, installing KStars, etc.).

## Troubleshooting

-   If you encounter errors during the script execution, carefully read the error messages.
-   Ensure you have `sudo` access and `git` installed.
-   If Flatpak installation fails on a supported distribution, try installing it manually using your system's package manager and then rerun the script.
-   If you have issues with udev rules or firmware, ensure the script was run with `sudo` and that the files were copied to the correct directories (`/lib/udev/rules.d` and `/lib/firmware`).

## Contributing

If you would like to contribute to improving this script, please feel free to submit a pull request to the repository.

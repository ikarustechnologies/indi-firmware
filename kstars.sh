#!/bin/bash

# Get KStars version from argument, default to stable if not provided
KSTARS_VERSION=${1:-stable}

# Define variables
REPO_URL="https://github.com/ikarustechnologies/indi-firmware.git"
REPO_DIR="$HOME/.indi-firmware"
UDEV_RULES_DIR="/lib/udev/rules.d"
FIRMWARE_DIR="/lib/firmware"
QHY_FIRMWARE_DIR="/lib/firmware/qhy"

# Install flatpak if not already installed based on distribution
echo "Checking for and installing flatpak..."

if ! command -v flatpak &> /dev/null; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            debian|ubuntu)
                echo "Detected Debian/Ubuntu. Installing flatpak using apt..."
                sudo apt install -y flatpak || { echo "Error: apt install flatpak failed"; exit 1; }
                ;;
            fedora)
                echo "Detected Fedora. Installing flatpak using dnf..."
                sudo dnf install -y flatpak || { echo "Error: dnf install flatpak failed"; exit 1; }
                ;;
            arch)
                echo "Detected Arch Linux. Installing flatpak using pacman..."
                sudo pacman -Syu --noconfirm flatpak || { echo "Error: pacman install flatpak failed"; exit 1; }
                ;;
            *)
                echo "Error: Unsupported distribution '$ID' for automatic Flatpak installation."
                echo "Please install flatpak manually and rerun this script."
                exit 1
                ;;
        esac
        echo "Flatpak installed."
    else
        echo "Error: Could not detect operating system for automatic Flatpak installation."
        echo "Please install flatpak manually and rerun this script."
        exit 1
    fi
else
    echo "Flatpak is already installed."
fi


# Check if the repository directory exists. If it does, pull; otherwise, clone.
if [ -d "$REPO_DIR" ]; then
  echo "Repository directory '$REPO_DIR' already exists. Pulling latest changes..."
  cd "$REPO_DIR" || { echo "Error: Could not navigate to $REPO_DIR"; exit 1; }
  # Use to potentially suppress GPG-related advice messages
  git pull || { echo "Error: Git pull failed"; exit 1; }
  cd - || { echo "Error: Could not return to previous directory"; exit 1; }
else
  echo "Cloning repository '$REPO_URL'..."
  # Use to potentially suppress GPG-related advice messages
  git clone "$REPO_URL" "$REPO_DIR" || { echo "Error: Git clone failed"; exit 1; }
fi

# Create destination directories if they don't exist
echo "Creating destination directories: $UDEV_RULES_DIR, $QHY_FIRMWARE_DIR..."
sudo mkdir -p "$UDEV_RULES_DIR" || { echo "Error: Could not create directory $UDEV_RULES_DIR"; exit 1; }
sudo mkdir -p "$QHY_FIRMWARE_DIR" || { echo "Error: Could not create directory $QHY_FIRMWARE_DIR"; exit 1; }
echo "Destination directories created."

# Copy udev rules files
echo "Copying udev rules files to $UDEV_RULES_DIR..."

sudo cp -v "$REPO_DIR"/indi/drivers/auxiliary/99-indi_auxiliary.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 99-indi_auxiliary.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi/drivers/video/80-dbk21-camera.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 80-dbk21-camera.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/indi-ffmv/99-fireflymv.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 99-fireflymv.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/indi-nightscape/99-nightscape.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 99-nightscape.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/indi-armadillo-platypus/99-armadilloplatypus.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 99-armadilloplatypus.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libpktriggercord/src/pentax.rules "$UDEV_RULES_DIR"/ || { echo "Error copying pentax.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libpktriggercord/src/samsung.rules "$UDEV_RULES_DIR"/ || { echo "Error copying samsung.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/indi-qsi/99-qsi.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 99-qsi.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/indi-sx/99-sx.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 99-sx.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libapogee/99-apogee.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 99-apogee.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/indi-dsi/99-meadedsi.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 99-meadedsi.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libfishcamp/99-fishcamp.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 99-fishcamp.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libfli/99-fli.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 99-fli.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/indi-gphoto/85-disable-dslr-automout.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 85-disable-dslr-automout.rules"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libqhy/85-qhyccd.rules "$UDEV_RULES_DIR"/ || { echo "Error copying 85-qhyccd.rules"; exit 1; }
echo "Udev rules files copied."

# Copy individual firmware files
echo "Copying individual firmware files to $FIRMWARE_DIR..."

sudo cp -v "$REPO_DIR"/indi-3rdparty/libfishcamp/gdr_usb.hex "$FIRMWARE_DIR"/ || { echo "Error copying gdr_usb.hex"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libfishcamp/Guider_mono_rev16_intel.srec "$FIRMWARE_DIR"/ || { echo "Error copying Guider_mono_rev16_intel.srec"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libsbig/sbigucam.hex "$FIRMWARE_DIR"/ || { echo "Error copying sbigucam.hex"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libsbig/sbiglcam.hex "$FIRMWARE_DIR"/ || { echo "Error copying sbiglcam.hex"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libsbig/sbigfcam.hex "$FIRMWARE_DIR"/ || { echo "Error copying sbigfcam.hex"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libsbig/sbigpcam.hex "$FIRMWARE_DIR"/ || { echo "Error copying sbigpcam.hex"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/libsbig/stfga.bin "$FIRMWARE_DIR"/ || { echo "Error copying stfga.bin"; exit 1; }
sudo cp -v "$REPO_DIR"/indi-3rdparty/indi-dsi/meade-deepskyimager.hex "$FIRMWARE_DIR"/ || { echo "Error copying meade-deepskyimager.hex"; exit 1; }
echo "Individual firmware files copied."

# Copy QHY firmware files
echo "Copying QHY firmware files to $QHY_FIRMWARE_DIR..."

sudo cp -v "$REPO_DIR"/indi-3rdparty/libqhy/firmware/* "$QHY_FIRMWARE_DIR"/ || { echo "Error copying QHY firmware files"; exit 1; }
echo "QHY firmware files copied."

# Reload udev rules after copying
echo "Reloading udev rules..."
sudo udevadm control --reload-rules || { echo "Error reloading udev rules"; exit 1; }
echo "Udev rules reloaded."

# Add Flathub remote if it doesn't exist
echo "Adding Flathub remote if it doesn't exist..."
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || { echo "Error adding Flathub remote"; exit 1; }
echo "Flathub remote added."

# Add StellarMate Hub remote with no GPG verification
echo "Adding SM Hub remote if it doesn't exist..."
flatpak remote-add --user --if-not-exists smhub https://smhub.stellarmate.com/smhub.flatpakrepo || { echo "Error adding StellarMate Hub remote"; exit 1; }
echo "SMHub remote added."

# Install KDE Platform and SDK runtimes
echo "Installing KDE Platform and SDK runtimes..."
flatpak install --user flathub org.kde.Platform//6.9 -y || { echo "Error installing KDE Platform runtime"; exit 1; }
flatpak install --user flathub org.kde.Sdk//6.9 -y || { echo "Error installing KDE SDK runtime"; exit 1; }
echo "KDE Platform and SDK runtimes installed."

# Install KStars Flatpak package from Flathub
echo "Installing KStars Flatpak package version ${KSTARS_VERSION}..."
flatpak install --user smhub org.kde.kstars//${KSTARS_VERSION} -y || { echo "Error installing KStars Flatpak ${KSTARS_VERSION}"; exit 1; }
flatpak update --user org.kde.kstars//${KSTARS_VERSION} -y || { echo "Error updating KStars Flatpak ${KSTARS_VERSION}"; exit 1; }
echo "KStars Flatpak version ${KSTARS_VERSION} installed."

echo "Script finished."
echo " "
echo "================================================================"
echo "================================================================"
echo " "
echo " "
echo "                   Installation completed "
echo "                For running the Kstars, run: "
echo "       flatpak run --user org.kde.kstars//${KSTARS_VERSION} "
echo " "
echo " "
echo "================================================================"
echo "================================================================"

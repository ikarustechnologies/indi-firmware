#!/bin/bash

# Define repository URLs
INDI_REPO_URL="https://github.com/indilib/indi.git"
INDI_3RDPARTY_REPO_URL="https://github.com/indilib/indi-3rdparty.git"
FILES_REPO_URL="https://github.com/ikarustechnologies/indi-firmware.git"

# Check and clone/pull indi repository
echo "Checking indi repository..."
if [ -d "indi" ]; then
    echo "indi directory exists, pulling latest changes..."
    cd indi || { echo "Error: Could not navigate to indi directory"; exit 1; }
    git pull
    cd ..
else
    echo "indi directory not found, cloning repository..."
    git clone "$INDI_REPO_URL" indi
fi

# Check and clone/pull indi-3rdparty repository
echo "Checking indi-3rdparty repository..."
if [ -d "indi-3rdparty" ]; then
    echo "indi-3rdparty directory exists, pulling latest changes..."
    cd indi-3rdparty || { echo "Error: Could not navigate to indi-3rdparty directory"; exit 1; }
    git pull
    cd ..
else
    echo "indi-3rdparty directory not found, cloning repository..."
    git clone "$INDI_3RDPARTY_REPO_URL" indi-3rdparty
fi

# Check and clone/pull indi-firmware repository
echo "Checking indi-firmware directory repository..."
if [ -d "indi-firmware" ]; then
    echo "indi-firmware directory exists, pulling latest changes..."
    cd indi-firmware || { echo "Error: Could not navigate to indi-firmware directory"; exit 1; }
    git pull
    cd ..
else
    echo "indi-firmware directory not found, cloning repository..."
    git clone "$FILES_REPO_URL"
fi

# Create necessary directories within indi-firmware and copy udev rules files
echo "Copying udev rules files with directory structure..."
mkdir -p indi-firmware/indi/drivers/auxiliary
cp -v indi/drivers/auxiliary/99-indi_auxiliary.rules indi-firmware/indi/drivers/auxiliary/

mkdir -p indi-firmware/indi/drivers/video
cp -v indi/drivers/video/80-dbk21-camera.rules indi-firmware/indi/drivers/video/

mkdir -p indi-firmware/indi-3rdparty/indi-ffmv
cp -v indi-3rdparty/indi-ffmv/99-fireflymv.rules indi-firmware/indi-3rdparty/indi-ffmv/

mkdir -p indi-firmware/indi-3rdparty/indi-nightscape
cp -v indi-3rdparty/indi-nightscape/99-nightscape.rules indi-firmware/indi-3rdparty/indi-nightscape/

mkdir -p indi-firmware/indi-3rdparty/indi-armadillo-platypus
cp -v indi-3rdparty/indi-armadillo-platypus/99-armadilloplatypus.rules indi-firmware/indi-3rdparty/indi-armadillo-platypus/

mkdir -p indi-firmware/indi-3rdparty/libpktriggercord/src
cp -v indi-3rdparty/libpktriggercord/src/pentax.rules indi-firmware/indi-3rdparty/libpktriggercord/src/
cp -v indi-3rdparty/libpktriggercord/src/samsung.rules indi-firmware/indi-3rdparty/libpktriggercord/src/

mkdir -p indi-firmware/indi-3rdparty/indi-qsi
cp -v indi-3rdparty/indi-qsi/99-qsi.rules indi-firmware/indi-3rdparty/indi-qsi/

mkdir -p indi-firmware/indi-3rdparty/indi-sx
cp -v indi-3rdparty/indi-sx/99-sx.rules indi-firmware/indi-3rdparty/indi-sx/

mkdir -p indi-firmware/indi-3rdparty/libapogee
cp -v indi-3rdparty/libapogee/99-apogee.rules indi-firmware/indi-3rdparty/libapogee/

mkdir -p indi-firmware/indi-3rdparty/indi-dsi
cp -v indi-3rdparty/indi-dsi/99-meadedsi.rules indi-firmware/indi-3rdparty/indi-dsi/

mkdir -p indi-firmware/indi-3rdparty/libfishcamp
cp -v indi-3rdparty/libfishcamp/99-fishcamp.rules indi-firmware/indi-3rdparty/libfishcamp/

mkdir -p indi-firmware/indi-3rdparty/libfli
cp -v indi-3rdparty/libfli/99-fli.rules indi-firmware/indi-3rdparty/libfli/

mkdir -p indi-firmware/indi-3rdparty/indi-gphoto
cp -v indi-3rdparty/indi-gphoto/85-disable-dslr-automout.rules indi-firmware/indi-3rdparty/indi-gphoto/

mkdir -p indi-firmware/indi-3rdparty/libqhy
cp -v indi-3rdparty/libqhy/85-qhyccd.rules indi-firmware/indi-3rdparty/libqhy/

mkdir -p indi-firmware/indi-3rdparty/libasi
cp -v indi-3rdparty/libasi/99-asi.rules indi-firmware/indi-3rdparty/libasi/

mkdir -p indi-firmware/indi-3rdparty/libmeadecam
cp -v indi-3rdparty/libmeadecam/99-meadecam.rules indi-firmware/indi-3rdparty/libmeadecam/

mkdir -p indi-firmware/indi-3rdparty/indi-mgen
cp -v indi-3rdparty/indi-mgen/80-LacertaMgen.rules indi-firmware/indi-3rdparty/indi-mgen/

mkdir -p indi-firmware/indi-3rdparty/indi-orion-ssg3
cp -v indi-3rdparty/indi-orion-ssg3/99-orionssg3.rules indi-firmware/indi-3rdparty/indi-orion-ssg3/

mkdir -p indi-firmware/indi-3rdparty/libricohcamerasdk
cp -v indi-3rdparty/libricohcamerasdk/99-pentax.rules indi-firmware/indi-3rdparty/libricohcamerasdk/

mkdir -p indi-firmware/indi-3rdparty/libtscam
cp -v indi-3rdparty/libtscam/99-tscam.rules indi-firmware/indi-3rdparty/libtscam/

mkdir -p indi-firmware/indi-3rdparty/libatik
cp -v indi-3rdparty/libatik/99-atik.rules indi-firmware/indi-3rdparty/libatik/

mkdir -p indi-firmware/indi-3rdparty/libastroasis
cp -v indi-3rdparty/libastroasis/99-astroasis.rules indi-firmware/indi-3rdparty/libastroasis/

mkdir -p indi-firmware/indi-3rdparty/obsolete
cp -v indi-3rdparty/obsolete/indi-ssag/95-ssag.rules indi-firmware/indi-3rdparty/obsolete/

mkdir -p indi-firmware/indi-3rdparty/libmallincam
cp -v indi-3rdparty/libmallincam/99-mallincam.rules indi-firmware/indi-3rdparty/libmallincam/

mkdir -p indi-firmware/indi-3rdparty/libstarshootg
cp -v indi-3rdparty/libstarshootg/99-starshootg.rules indi-firmware/indi-3rdparty/libstarshootg/

mkdir -p indi-firmware/indi-3rdparty/libinovasdk
cp -v indi-3rdparty/libinovasdk/99-inovaplx.rules indi-firmware/indi-3rdparty/libinovasdk/

mkdir -p indi-firmware/indi-3rdparty/libsbig
cp -v indi-3rdparty/libsbig/51-sbig-debian.rules indi-firmware/indi-3rdparty/libsbig/

mkdir -p indi-firmware/indi-3rdparty/libomegonprocam
cp -v indi-3rdparty/libomegonprocam/99-omegonprocam.rules indi-firmware/indi-3rdparty/libomegonprocam/

mkdir -p indi-firmware/indi-3rdparty/libsvbonycam
cp -v indi-3rdparty/libsvbonycam/99-svbonycam.rules indi-firmware/indi-3rdparty/libsvbonycam/

mkdir -p indi-firmware/indi-3rdparty/libaltaircam
cp -v indi-3rdparty/libaltaircam/99-altaircam.rules indi-firmware/indi-3rdparty/libaltaircam/

mkdir -p indi-firmware/indi-3rdparty/libmicam
cp -v indi-3rdparty/libmicam/99-miccd.rules indi-firmware/indi-3rdparty/libmicam/

mkdir -p indi-firmware/indi-3rdparty/libtoupcam
cp -v indi-3rdparty/libtoupcam/99-toupcam.rules indi-firmware/indi-3rdparty/libtoupcam/

mkdir -p indi-firmware/indi-3rdparty/libnncam
cp -v indi-3rdparty/libnncam/99-nncam.rules indi-firmware/indi-3rdparty/libnncam/

mkdir -p indi-firmware/indi-3rdparty/libbressercam
cp -v indi-3rdparty/libbressercam/99-bressercam.rules indi-firmware/indi-3rdparty/libbressercam/

mkdir -p indi-firmware/indi-3rdparty/libsvbony
cp -v indi-3rdparty/libsvbony/90-svbonyusb.rules indi-firmware/indi-3rdparty/libsvbony/

mkdir -p indi-firmware/indi-3rdparty/libplayerone
cp -v indi-3rdparty/libplayerone/99-player_one_astronomy.rules indi-firmware/indi-3rdparty/libplayerone/

mkdir -p indi-firmware/indi-3rdparty/libogmacam
cp -v indi-3rdparty/libogmacam/99-ogmacam.rules indi-firmware/indi-3rdparty/libogmacam/


# Create necessary directories within indi-firmware and copy firmware files
echo "Copying firmware files with directory structure..."
mkdir -p indi-firmware/indi-3rdparty/libfishcamp
cp -v indi-3rdparty/libfishcamp/gdr_usb.hex indi-firmware/indi-3rdparty/libfishcamp/
cp -v indi-3rdparty/libfishcamp/Guider_mono_rev16_intel.srec indi-firmware/indi-3rdparty/libfishcamp/

mkdir -p indi-firmware/indi-3rdparty/libsbig
cp -v indi-3rdparty/libsbig/sbigucam.hex indi-firmware/indi-3rdparty/libsbig/
cp -v indi-3rdparty/libsbig/sbiglcam.hex indi-firmware/indi-3rdparty/libsbig/
cp -v indi-3rdparty/libsbig/sbigfcam.hex indi-firmware/indi-3rdparty/libsbig/
cp -v indi-3rdparty/libsbig/sbigpcam.hex indi-firmware/indi-3rdparty/libsbig/
cp -v indi-3rdparty/libsbig/stfga.bin indi-firmware/indi-3rdparty/libsbig/

mkdir -p indi-firmware/indi-3rdparty/indi-dsi
cp -v indi-3rdparty/indi-dsi/meade-deepskyimager.hex indi-firmware/indi-3rdparty/indi-dsi/

mkdir -p indi-firmware/indi-3rdparty/libqhy/firmware
cp -v indi-3rdparty/libqhy/firmware/* indi-firmware/indi-3rdparty/libqhy/firmware/

echo "Copying complete."

# Navigate to the indi-firmware directory
echo "Navigating to indi-firmware directory..."
cd indi-firmware || { echo "Error: Could not navigate to indi-firmware directory"; exit 1; }

# Add all changes, commit, and push
echo "Adding changes to git..."
git add .

echo "Committing changes..."
git commit -m "Update udev rules and firmware files"

echo "Pushing changes..."
git push

echo "Git operations complete."

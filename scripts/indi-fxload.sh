#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'USAGE'
Usage: indi-fxload [--devnode PATH] [--busnum BUS] [--devnum DEV] [fxload options...]

Automatically selects between legacy (-D) and libusb (-p) syntax based on the
installed fxload binary. Device hints default to the udev-provided DEVNAME,
BUSNUM and DEVNUM but can be overridden with the optional flags above.
USAGE
}

FXLOAD_BIN=${FXLOAD_BIN:-/sbin/fxload}
if [[ ! -x "$FXLOAD_BIN" ]]; then
    FXLOAD_BIN=$(command -v fxload 2>/dev/null || true)
fi
if [[ -z "${FXLOAD_BIN:-}" ]]; then
    echo "indi-fxload: unable to locate fxload binary" >&2
    exit 1
fi

DEVNODE="${DEVNAME:-${INDI_FXLOAD_DEVNODE:-}}"
BUSNUM_HINT="${BUSNUM:-${INDI_FXLOAD_BUSNUM:-}}"
DEVNUM_HINT="${DEVNUM:-${INDI_FXLOAD_DEVNUM:-}}"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --devnode)
            [[ $# -ge 2 ]] || { echo "indi-fxload: --devnode requires a value" >&2; usage >&2; exit 1; }
            DEVNODE="$2"
            shift 2
            ;;
        --busnum)
            [[ $# -ge 2 ]] || { echo "indi-fxload: --busnum requires a value" >&2; usage >&2; exit 1; }
            BUSNUM_HINT="$2"
            shift 2
            ;;
        --devnum)
            [[ $# -ge 2 ]] || { echo "indi-fxload: --devnum requires a value" >&2; usage >&2; exit 1; }
            DEVNUM_HINT="$2"
            shift 2
            ;;
        --fxload)
            [[ $# -ge 2 ]] || { echo "indi-fxload: --fxload requires a path" >&2; usage >&2; exit 1; }
            FXLOAD_BIN="$2"
            shift 2
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            break
            ;;
    esac
done

if [[ $# -eq 0 ]]; then
    usage >&2
    exit 1
fi

if [[ ! -x "$FXLOAD_BIN" ]]; then
    echo "indi-fxload: fxload binary '$FXLOAD_BIN' is not executable" >&2
    exit 1
fi

VERSION_TEXT=$("$FXLOAD_BIN" -V 2>&1 || true)
MODE=""
if [[ "$VERSION_TEXT" =~ ^0\. ]]; then
    MODE="legacy"
elif [[ "$VERSION_TEXT" =~ [Ll]ibusb ]]; then
    MODE="libusb"
fi

if [[ -z "$MODE" ]]; then
    HELP_TEXT=$("$FXLOAD_BIN" -h 2>&1 || true)
    if grep -q -- ' -D ' <<<"$HELP_TEXT"; then
        MODE="legacy"
    else
        MODE="libusb"
    fi
fi

if [[ "$MODE" == "legacy" ]]; then
    if [[ -z "${DEVNODE:-}" ]]; then
        echo "indi-fxload: fxload requires a device node but DEVNAME was not supplied" >&2
        exit 1
    fi
    exec "$FXLOAD_BIN" -D "$DEVNODE" "$@"
else
    if [[ -z "${BUSNUM_HINT:-}" || -z "${DEVNUM_HINT:-}" ]]; then
        echo "indi-fxload: fxload requires BUSNUM and DEVNUM but they were not supplied" >&2
        exit 1
    fi
    exec "$FXLOAD_BIN" -p "${BUSNUM_HINT},${DEVNUM_HINT}" "$@"
fi

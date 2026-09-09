#!/usr/bin/env sh

# shellcheck disable=SC1091
ARGVUS_BOOTSTRAP="${ARGVUS_BOOTSTRAP:-${ARGVUS_SYSTEM_CONFIG:-/usr/share/argvus}/scripts/argvus/bootstrap.sh}"
. "$ARGVUS_BOOTSTRAP"

PICTURES=$(xdg-user-dir PICTURES)
VIDEOS=$(xdg-user-dir VIDEOS)

case "$LANG" in
  pt_*)
    FOLDER_IMAGES="Capturas de tela"
    FILENAME_IMAGE="Captura de tela de"
    FOLDER_VIDEOS="Gravações de tela"
    FILENAME_VIDEO="Gravação de tela de"
    MSG_RECORDING_STARTED="Gravação iniciada"
    MSG_RECORDING_PAUSED="Gravação pausada"
    MSG_RECORDING_RESUMED="Gravação retomada"
    MSG_RECORDING_STOPED="Gravação salva"
    MSG_NO_RECORDING="Sem gravação"
    MSG_RECORDING_FAILED="Não foi possível iniciar a gravação"
    ;;
  *)
    FOLDER_IMAGES="Screenshots"
    FILENAME_IMAGE="Screenshot"
    FOLDER_VIDEOS="Screen recordings"
    FILENAME_VIDEO="Screen recording"
    MSG_RECORDING_STARTED="Recording started"
    MSG_RECORDING_PAUSED="Recording paused"
    MSG_RECORDING_RESUMED="Recording resumed"
    MSG_RECORDING_STOPED="Recording saved"
    MSG_NO_RECORDING="No recording"
    MSG_RECORDING_FAILED="Could not start recording"
    ;;
esac

mkdir -p "$PICTURES/$FOLDER_IMAGES" "$VIDEOS/$FOLDER_VIDEOS"

PATH_IMAGES="$PICTURES/$FOLDER_IMAGES"
FILENAME_IMAGE_DATETIME="$FILENAME_IMAGE $(date +%Y-%m-%d_%H-%M-%S).png"
PATH_VIDEOS="$VIDEOS/$FOLDER_VIDEOS"
FILENAME_VIDEO_DATETIME="$FILENAME_VIDEO $(date +%Y-%m-%d_%H-%M-%S).mkv"
STATE_FILE="$HYPR_CACHE_DIR/gpu-screen-recorder.state"
OUTPUT_FILE="$HYPR_CACHE_DIR/gpu-screen-recorder.output"
RECORDING_UNIT="argvus-screen-recorder.service"

recording_active() {
  systemctl --user is-active --quiet "$RECORDING_UNIT" 2>/dev/null
}

recording_signal() {
  systemctl --user kill --kill-whom=main --signal="$1" "$RECORDING_UNIT" >/dev/null 2>&1
}

recording_name() {
  _recording_path=$(cat "$OUTPUT_FILE" 2>/dev/null || true)
  if [ -n "$_recording_path" ]; then
    basename "$_recording_path"
  else
    printf '%s\n' "$FILENAME_VIDEO_DATETIME"
  fi
}

for OLD_NAME in "Capturas de tela" "Screenshots"; do
  [ "$OLD_NAME" = "$FOLDER_IMAGES" ] && continue
  OLD_DIR="$PICTURES/$OLD_NAME"
  [ -d "$OLD_DIR" ] || continue
  TARGET_DIR="$PICTURES/$FOLDER_IMAGES"
  if [ ! -d "$TARGET_DIR" ]; then
    mv "$OLD_DIR" "$TARGET_DIR"
  else
    mv "$OLD_DIR"/* "$TARGET_DIR"/ 2>/dev/null
    rmdir "$OLD_DIR" 2>/dev/null
  fi
done

for OLD_NAME in "Gravações de tela" "Screen recordings"; do
  [ "$OLD_NAME" = "$FOLDER_VIDEOS" ] && continue
  OLD_DIR="$VIDEOS/$OLD_NAME"
  [ -d "$OLD_DIR" ] || continue
  TARGET_DIR="$VIDEOS/$FOLDER_VIDEOS"
  if [ ! -d "$TARGET_DIR" ]; then
    mv "$OLD_DIR" "$TARGET_DIR"
  else
    mv "$OLD_DIR"/* "$TARGET_DIR"/ 2>/dev/null
    rmdir "$OLD_DIR" 2>/dev/null
  fi
done

case "$1" in
  # Options image
  --image-region)
    hyprshot -m region -o "$PATH_IMAGES" -f "$FILENAME_IMAGE_DATETIME"
    satty --filename "$PATH_IMAGES/$FILENAME_IMAGE_DATETIME"
    ;;

  --image-full)
    hyprshot -m output -o "$PATH_IMAGES" -f "$FILENAME_IMAGE_DATETIME"
    ;;

  --image-window)
    hyprshot -m window -o "$PATH_IMAGES" -f "$FILENAME_IMAGE_DATETIME"
    ;;

  # Options video
  --video-full)
    if recording_active; then
      STATE=$(cat "$STATE_FILE" 2>/dev/null)

      # Recording paused
      if [ "$STATE" = "recording" ]; then
        recording_signal SIGUSR2
        echo paused > "$STATE_FILE"
        notify-send "$(recording_name)" "$MSG_RECORDING_PAUSED"

      # Recording resumed
      elif [ "$STATE" = "paused" ]; then
        recording_signal SIGUSR2
        echo recording > "$STATE_FILE"
        notify-send "$(recording_name)" "$MSG_RECORDING_RESUMED"
      fi

    # Recording started
    else
      CAPTURE_OUTPUT=$(hyprctl monitors -j 2>/dev/null | jq -r \
        '(map(select(.focused == true))[0].name // .[0].name // empty)')
      if [ -z "$CAPTURE_OUTPUT" ]; then
        notify-send "ARGVUS" "$MSG_RECORDING_FAILED"
        exit 1
      fi

      VIDEO_PATH="$PATH_VIDEOS/$FILENAME_VIDEO_DATETIME"
      systemctl --user reset-failed "$RECORDING_UNIT" >/dev/null 2>&1 || true
      if ! systemd-run --user --quiet --collect \
        --unit="$RECORDING_UNIT" \
        --property=Type=exec \
        -- gpu-screen-recorder \
        -w "$CAPTURE_OUTPUT" \
        -f 60 \
        -a default_output \
        -a default_input \
        -o "$VIDEO_PATH"; then
        rm -f "$STATE_FILE" "$OUTPUT_FILE"
        notify-send "ARGVUS" "$MSG_RECORDING_FAILED"
        exit 1
      fi

      echo "$VIDEO_PATH" > "$OUTPUT_FILE"
      echo recording > "$STATE_FILE"
      notify-send "$FILENAME_VIDEO_DATETIME" "$MSG_RECORDING_STARTED"
    fi
    ;;

  --video-full-stop)
    if recording_active; then
      RECORDING_NAME=$(recording_name)
      recording_signal SIGINT
      rm -f "$STATE_FILE" "$OUTPUT_FILE"
      notify-send "$RECORDING_NAME" "$MSG_RECORDING_STOPED"
    else
      rm -f "$STATE_FILE" "$OUTPUT_FILE"
      notify-send "$FILENAME_VIDEO_DATETIME" "$MSG_NO_RECORDING"
    fi
    ;;
--video-full-status)
  if recording_active; then
    STATE=$(cat "$STATE_FILE" 2>/dev/null)

    if [ "$STATE" = "paused" ]; then
      echo "{\"text\":\"\",\"tooltip\":\"$MSG_RECORDING_PAUSED\",\"class\":\"paused\"}"
    else
      echo "{\"text\":\"\",\"tooltip\":\"$MSG_RECORDING_STARTED\",\"class\":\"recording\"}"
    fi
  else
    echo "{\"text\":\"\",\"tooltip\":\"$MSG_NO_RECORDING\",\"class\":\"stopped\"}"
  fi
  ;;
esac

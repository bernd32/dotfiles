 #!/bin/bash

SINK1="alsa_output.pci-0000_00_1f.3.analog-stereo"
SINK2="alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC-00.analog-stereo-output"

CURRENT_SINK=$(pactl get-default-sink)

if [ "$CURRENT_SINK" = "$SINK1" ]; then
   pactl set-default-sink $SINK2
   NEW_SINK=$SINK2
else
   pactl set-default-sink $SINK1
   NEW_SINK=$SINK1
fi

# Move all audio streams to new sink
pactl list short sink-inputs | while read stream; do
   stream_id=$(echo $stream | cut '-d ' -f1)
   pactl move-sink-input $stream_id $NEW_SINK
done

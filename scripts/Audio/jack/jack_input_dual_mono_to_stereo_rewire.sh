#!/bin/bash

JACKDEV="system"
PADEV="PulseAudio JACK Source"

JACK_MICIN="capture_1"
JACK_INSTIN="capture_2"
PA_LEFT="front-left"
PA_RIGHT="front-right"

jack_connect "${JACKDEV}":"${JACK_MICIN}" "${PADEV}":"${PA_LEFT}"
jack_connect "${JACKDEV}":"${JACK_MICIN}" "${PADEV}":"${PA_RIGHT}"

jack_connect "${JACKDEV}":"${JACK_INSTIN}" "${PADEV}":"${PA_LEFT}"
jack_connect "${JACKDEV}":"${JACK_INSTIN}" "${PADEV}":"${PA_RIGHT}"

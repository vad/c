#!/bin/bash

# Trova il display integrato (di solito inizia con eDP)
INTERNAL_DISPLAY=$(xrandr | grep -E "^eDP[^ ]* connected" | cut -d' ' -f1)
if [ -z "$INTERNAL_DISPLAY" ]; then
  INTERNAL_DISPLAY=$(xrandr | grep -E "^LVDS[^ ]* connected" | cut -d' ' -f1)
fi

if [ -z "$INTERNAL_DISPLAY" ]; then
  echo "Display integrato non trovato"
  exit 1
fi

# Trova la risoluzione massima per il display integrato
INTERNAL_RESOLUTION=$(xrandr | grep -A 1 "^$INTERNAL_DISPLAY connected" | grep -oP '\d+x\d+' | head -n 1)
if [ -z "$INTERNAL_RESOLUTION" ]; then
  echo "Impossibile trovare la risoluzione per $INTERNAL_DISPLAY"
  exit 1
fi

# Trova il display esterno (qualsiasi display connesso che non sia quello integrato)
EXTERNAL_DISPLAY=$(xrandr | grep " connected" | grep -v "$INTERNAL_DISPLAY" | head -n 1 | cut -d' ' -f1)

if [ -z "$EXTERNAL_DISPLAY" ]; then
  echo "Nessun display esterno trovato, configurazione solo per display integrato"
  xrandr --output "$INTERNAL_DISPLAY" --mode "$INTERNAL_RESOLUTION" --pos 0x0 --rotate normal --primary
  exit 0
fi

# Trova la risoluzione massima per il display esterno
EXTERNAL_RESOLUTION=$(xrandr | grep -A 1 "^$EXTERNAL_DISPLAY connected" | grep -oP '\d+x\d+' | head -n 1)
if [ -z "$EXTERNAL_RESOLUTION" ]; then
  echo "Impossibile trovare la risoluzione per $EXTERNAL_DISPLAY"
  exit 1
fi

# Estrai l'altezza dei display per allinearli orizzontalmente
INTERNAL_HEIGHT=$(echo "$INTERNAL_RESOLUTION" | cut -d'x' -f2)
EXTERNAL_HEIGHT=$(echo "$EXTERNAL_RESOLUTION" | cut -d'x' -f2)
EXTERNAL_WIDTH=$(echo "$EXTERNAL_RESOLUTION" | cut -d'x' -f1)

# Calcola l'offset Y per centrare i display se hanno altezze diverse
Y_OFFSET=0
if [ $INTERNAL_HEIGHT -ne $EXTERNAL_HEIGHT ]; then
  if [ $INTERNAL_HEIGHT -gt $EXTERNAL_HEIGHT ]; then
    Y_OFFSET=$(( (INTERNAL_HEIGHT - EXTERNAL_HEIGHT) / 2 ))
  fi
fi

# Imposta la configurazione: esterno a sinistra (primario), integrato a destra
echo "Configurazione: $EXTERNAL_DISPLAY ($EXTERNAL_RESOLUTION) primario a sinistra, $INTERNAL_DISPLAY ($INTERNAL_RESOLUTION) a destra"

# Disattiva tutti gli output non utilizzati
ALL_OUTPUTS=$(xrandr | grep " connected" | cut -d' ' -f1 | grep -v "$INTERNAL_DISPLAY" | grep -v "$EXTERNAL_DISPLAY")

# Costruisci il comando xrandr
XRANDR_CMD="xrandr --output $EXTERNAL_DISPLAY --primary --mode $EXTERNAL_RESOLUTION --pos 0x$Y_OFFSET --rotate normal"
XRANDR_CMD="$XRANDR_CMD --output $INTERNAL_DISPLAY --mode $INTERNAL_RESOLUTION --pos ${EXTERNAL_WIDTH}x0 --rotate normal"

# Aggiungi le opzioni per disabilitare gli altri output
for OUTPUT in $ALL_OUTPUTS; do
  XRANDR_CMD="$XRANDR_CMD --output $OUTPUT --off"
done

# Esegui il comando
echo "Esecuzione: $XRANDR_CMD"
eval "$XRANDR_CMD"

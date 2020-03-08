; Auto calibration routine for large delta printer
M561                    ; clear any bed transform

; If the printer hasn't been homed, home it
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  G28

; Probe the bed and do auto calibration
G1 X0 Y80 Z10 F10000        ; go to just above the first probe point
while true
  if iterations = 5
    abort "too many auto calibration attempts"
  G30 P0 X0.00 Y80.00 Z-99999
  if result != 0
    continue
  G30 P1 X51.42 Y61.28 Z-99999
  if result != 0
    continue
  G30 P2 X78.78 Y13.89 Z-99999
  if result != 0
    continue
  G30 P3 X69.28 Y-40.00 Z-99999
  if result != 0
    continue
  G30 P4 X27.36 Y-75.18 Z-99999
  if result != 0
    continue
  G30 P5 X-27.36 Y-75.18 Z-99999
  if result != 0
    continue
  G30 P6 X-69.28 Y-40.00 Z-99999
  if result != 0
    continue
  G30 P7 X-78.78 Y13.89 Z-99999
  if result != 0
    continue
  G30 P8 X-51.42 Y61.28 Z-99999
  if result != 0
    continue
  G30 P9 X0.00 Y40.00 Z-99999
  if result != 0
    continue
  G30 P10 X34.64 Y20.00 Z-99999
  if result != 0
    continue
  G30 P11 X34.64 Y-20.00 Z-99999
  if result != 0
    continue
  G30 P12 X0.00 Y-40.00 Z-99999
  if result != 0
    continue
  G30 P13 X-34.64 Y-20.00 Z-99999
  if result != 0
    continue
  G30 P14 X-34.64 Y20.00 Z-99999
  if result != 0
    continue
  G30 P15 X0 Y0 Z-99999 S8
  if result != 0
    continue

  if move.calibration.final.deviation <= 0.03
    break
  echo "Repeating calibration because deviation is too high (" ^ move.calibration.final.deviation ^ "mm)"
; end loop
echo "Auto calibration successful, deviation", move.calibration.final.deviation ^ "mm"
G1 X0 Y0 Z150 F10000                ; get the head out of the way



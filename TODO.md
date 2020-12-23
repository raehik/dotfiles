  * shell: first entry point should be shell-specific instead
  * shell: redo completions, so we can also use dynamic command-based ones
    (kubectl etc)
  * graphical/i3: `tray_output primary` requires a primary monitor set via
    `xrandr`, or the tray literally won't show
  * graphical: for controlling external monitors, `ddcutil` works with my main
    Acer monitor (`modprobe i2c-dev`). But I don't really see it as very useful,
    `gammastep` works over all monitors and I can just set it once and be done.

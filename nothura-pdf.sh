PDF="$1"
PAGE="$2"
# Get PAGE - 1
PM=$((PAGE - 1))
PID=$(pgrep -nf "zathura -- $PDF")
# Run zathura with $PDF if it's not running
if [ -z "$PID" ]; then
    PID=$(pgrep -nf "zathura $PDF")
    if [ -z "$PID" ]; then
        zathura "$PDF" -P $PAGE&
    else
        dbus-send --type="method_call" --dest=org.pwmt.zathura.PID-$PID /org/pwmt/zathura org.pwmt.zathura.GotoPage uint32:$PM
    fi
else
    dbus-send --type="method_call" --dest=org.pwmt.zathura.PID-$PID /org/pwmt/zathura org.pwmt.zathura.GotoPage uint32:$PM
fi

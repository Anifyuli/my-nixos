{
  wantedBy = [ "timers.target" ];
  timerConfig = {
    OnBootSec = "2m";
    OnUnitActiveSec = "1d";
    Unit = "auto-shutdown.service";
  };
}

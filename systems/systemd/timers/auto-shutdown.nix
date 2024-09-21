{
  wantedBy = [ "timers.target" ];
  timerConfig = {
    OnBootSec = "2m";
    OnUnitActiveSec = "5m";
    Unit = "auto-shutdown.service";
  };
}

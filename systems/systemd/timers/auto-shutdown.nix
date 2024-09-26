{
  wantedBy = [ "timers.target" ];
  timerConfig = {
    OnBootSec = "1m";
    OnUnitActiveSec = "2m";
    Unit = "auto-shutdown.service";
  };
}

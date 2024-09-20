{
  wantedBy = [ "timers.target" ];
  timerConfig = {
    OnBootSec = "2m";
    OnUnitActiveSec = "2m";
    Unit = "auto-shutdown.service";
  };
}

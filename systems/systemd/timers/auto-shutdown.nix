{
  wantedBy = [ "timers.target" ];
  timerConfig = {
    OnBootSec = "3m";
    OnUnitActiveSec = "3m";
    Unit = "auto-shutdown.service";
  };
}

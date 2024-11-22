{
  "rkol" = "set_color -o (tr -dc 'A-Fa-f0-9' </dev/urandom | head -c 6 ; echo)";
  ":q" = "exit";
  ":q!" = "exit";
  "..." = "cd ../..";
  "keypresscode" = "xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\\n\", $5, $8 }'";
  "urldecode" = "sed \"s@+@ @g;s@%@\\\\x@g\" | xargs -0 printf \"%b\"";
}

function __fish_excuseme_print_remaining_args
    set -l tokens (commandline -opc) (commandline -ct)
    set -e tokens[1]
    # These are all the options mentioned in the man page for Todd Miller's "sudo.ws" sudo (in that order).
    # If any other implementation has different options, this should be harmless, since they shouldn't be used anyway.
    # set -l opts A/askpass b/background C/close-from= E/preserve-env='?'
    # Note that "-h" is both "--host" (which takes an option) and "--help" (which doesn't).
    # But `-h` as `--help` only counts when it's the only argument (`sudo -h`),
    # so any argument completion after that should take it as "--host".
    # set -a opts e/edit g/group= H/set-home h/host= 1-help
    # set -a opts i/login K/remove-timestamp k/reset-timestamp l/list n/non-interactive
    # set -a opts P/preserve-groups p/prompt= S/stdin s/shell U/other-user=
    # set -a opts u/user= T/command-timeout= V/version v/validate
    # argparse -s $opts -- $tokens 2>/dev/null
    # The remaining argv is the subcommand with all its options, which is what
    # we want.
    if set -q tokens[1]
      and [ $tokens[1] = 'me,' ]
      # and not string match -qr '^-' $argv[1]
      # set -e tokens[1]
      string join0 -- $tokens[2..-1]
      return 0
    else
      return 1
    end
end

function __fish_complete_excuseme_subcommand
  # set -l args (__fish_excuseme_print_remaining_args | string split0)
  if set -l args (__fish_excuseme_print_remaining_args | string split0)
    set -lx -a PATH 
    __fish_complete_subcommand --commandline $args
  else
    echo "me,"
  end
end

set -l excuse_command me,
complete -c excuse -f
complete -c excuse -x -n 'not __fish_seen_argument -s e' -a "(__fish_complete_excuseme_subcommand)"

# Complete the command we are executed under sudo
# complete -c excuse -x -n 'not __fish_seen_argument -s e' -a "(__fish_complete_sudo_subcommand)"


function __v_completions
	# Send all words up to the one before the cursor
	/nix/store/6v1fy8hk3qb97mcm2grl6hc5y8aq9fv9-vlang-0.4.4/lib/v complete fish (commandline -cop)
end
complete -f -c v -a "(__v_completions)"


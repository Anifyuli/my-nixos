complete -c anvil -n "__fish_use_subcommand" -s p -l port -d 'Port number to listen on' -r
complete -c anvil -n "__fish_use_subcommand" -s a -l accounts -d 'Number of dev accounts to generate and configure' -r
complete -c anvil -n "__fish_use_subcommand" -l balance -d 'The balance of every dev account in Ether' -r
complete -c anvil -n "__fish_use_subcommand" -l timestamp -d 'The timestamp of the genesis block' -r
complete -c anvil -n "__fish_use_subcommand" -s m -l mnemonic -d 'BIP39 mnemonic phrase used for generating accounts. Cannot be used if `mnemonic_random` or `mnemonic_seed` are used' -r
complete -c anvil -n "__fish_use_subcommand" -l mnemonic-random -d 'Automatically generates a BIP39 mnemonic phrase, and derives accounts from it. Cannot be used with other `mnemonic` options You can specify the number of words you want in the mnemonic. [default: 12]' -r
complete -c anvil -n "__fish_use_subcommand" -l mnemonic-seed-unsafe -d 'Generates a BIP39 mnemonic phrase from a given seed Cannot be used with other `mnemonic` options' -r
complete -c anvil -n "__fish_use_subcommand" -l derivation-path -d 'Sets the derivation path of the child key to be derived' -r
complete -c anvil -n "__fish_use_subcommand" -l hardfork -d 'The EVM hardfork to use' -r
complete -c anvil -n "__fish_use_subcommand" -s b -l block-time -l blockTime -d 'Block time in seconds for interval mining' -r
complete -c anvil -n "__fish_use_subcommand" -l slots-in-an-epoch -d 'Slots in an epoch' -r
complete -c anvil -n "__fish_use_subcommand" -l config-out -d 'Writes output of `anvil` as json to user-specified file' -r
complete -c anvil -n "__fish_use_subcommand" -l host -d 'The hosts the server will listen on' -r
complete -c anvil -n "__fish_use_subcommand" -l order -d 'How transactions are sorted in the mempool' -r
complete -c anvil -n "__fish_use_subcommand" -l init -d 'Initialize the genesis block with the given `genesis.json` file' -r
complete -c anvil -n "__fish_use_subcommand" -l state -d 'This is an alias for both --load-state and --dump-state' -r
complete -c anvil -n "__fish_use_subcommand" -s s -l state-interval -d 'Interval in seconds at which the state and block environment is to be dumped to disk' -r
complete -c anvil -n "__fish_use_subcommand" -l dump-state -d 'Dump the state and block environment of chain on exit to the given file' -r -F
complete -c anvil -n "__fish_use_subcommand" -l load-state -d 'Initialize the chain from a previously saved state snapshot' -r
complete -c anvil -n "__fish_use_subcommand" -l ipc -l ipcpath -d 'Launch an ipc server at the given path or default path = `/tmp/anvil.ipc`' -r
complete -c anvil -n "__fish_use_subcommand" -l prune-history -d 'Don\'t keep full chain history. If a number argument is specified, at most this number of states is kept in memory' -r
complete -c anvil -n "__fish_use_subcommand" -l transaction-block-keeper -d 'Number of blocks with transactions to keep in memory' -r
complete -c anvil -n "__fish_use_subcommand" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c anvil -n "__fish_use_subcommand" -l fork-header -d 'Headers to use for the rpc client, e.g. "User-Agent: test-agent"' -r
complete -c anvil -n "__fish_use_subcommand" -l timeout -d 'Timeout in ms for requests sent to remote JSON-RPC server in forking mode' -r
complete -c anvil -n "__fish_use_subcommand" -l retries -d 'Number of retry requests for spurious networks (timed out requests)' -r
complete -c anvil -n "__fish_use_subcommand" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c anvil -n "__fish_use_subcommand" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c anvil -n "__fish_use_subcommand" -l fork-chain-id -d 'Specify chain id to skip fetching it from remote endpoint. This enables offline-start mode' -r
complete -c anvil -n "__fish_use_subcommand" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c anvil -n "__fish_use_subcommand" -l gas-limit -d 'The block gas limit' -r
complete -c anvil -n "__fish_use_subcommand" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c anvil -n "__fish_use_subcommand" -l gas-price -d 'The gas price' -r
complete -c anvil -n "__fish_use_subcommand" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c anvil -n "__fish_use_subcommand" -l chain-id -d 'The chain ID' -r
complete -c anvil -n "__fish_use_subcommand" -l memory-limit -d 'The memory limit per EVM execution in bytes' -r
complete -c anvil -n "__fish_use_subcommand" -l allow-origin -d 'Set the CORS allow_origin' -r
complete -c anvil -n "__fish_use_subcommand" -l silent -d 'Don\'t print anything on startup and don\'t print logs'
complete -c anvil -n "__fish_use_subcommand" -l no-mining -l no-mine -d 'Disable auto and interval mining, and mine on demand instead'
complete -c anvil -n "__fish_use_subcommand" -l no-rate-limit -l no-rpc-rate-limit -d 'Disables rate limiting for this node\'s provider'
complete -c anvil -n "__fish_use_subcommand" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c anvil -n "__fish_use_subcommand" -l disable-block-gas-limit -d 'Disable the `call.gas_limit <= block.gas_limit` constraint'
complete -c anvil -n "__fish_use_subcommand" -l steps-tracing -l tracing -d 'Enable steps tracing used for debug calls returning geth-style traces'
complete -c anvil -n "__fish_use_subcommand" -l auto-impersonate -l auto-impersonate -d 'Enable autoImpersonate on startup'
complete -c anvil -n "__fish_use_subcommand" -l optimism -l optimism -d 'Run an Optimism chain'
complete -c anvil -n "__fish_use_subcommand" -l disable-default-create2-deployer -l no-create2 -d 'Disable the default create2 deployer'
complete -c anvil -n "__fish_use_subcommand" -l no-cors -d 'Disable CORS'
complete -c anvil -n "__fish_use_subcommand" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c anvil -n "__fish_use_subcommand" -s V -l version -d 'Print version'
complete -c anvil -n "__fish_use_subcommand" -f -a "completions" -d 'Generate shell completions script'
complete -c anvil -n "__fish_use_subcommand" -f -a "generate-fig-spec" -d 'Generate Fig autocompletion spec'
complete -c anvil -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c anvil -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Print help'
complete -c anvil -n "__fish_seen_subcommand_from generate-fig-spec" -s h -l help -d 'Print help'
complete -c anvil -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from help" -f -a "completions" -d 'Generate shell completions script'
complete -c anvil -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from help" -f -a "generate-fig-spec" -d 'Generate Fig autocompletion spec'
complete -c anvil -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'

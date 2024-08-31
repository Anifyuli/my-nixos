complete -c forge -n "__fish_use_subcommand" -s h -l help -d 'Print help'
complete -c forge -n "__fish_use_subcommand" -s V -l version -d 'Print version'
complete -c forge -n "__fish_use_subcommand" -f -a "test" -d 'Run the project\'s tests'
complete -c forge -n "__fish_use_subcommand" -f -a "script" -d 'Run a smart contract as a script, building transactions that can be sent onchain'
complete -c forge -n "__fish_use_subcommand" -f -a "coverage" -d 'Generate coverage reports'
complete -c forge -n "__fish_use_subcommand" -f -a "bind" -d 'Generate Rust bindings for smart contracts'
complete -c forge -n "__fish_use_subcommand" -f -a "build" -d 'Build the project\'s smart contracts'
complete -c forge -n "__fish_use_subcommand" -f -a "clone" -d 'Clone a contract from Etherscan'
complete -c forge -n "__fish_use_subcommand" -f -a "debug" -d 'Debugs a single smart contract as a script'
complete -c forge -n "__fish_use_subcommand" -f -a "update" -d 'Update one or multiple dependencies'
complete -c forge -n "__fish_use_subcommand" -f -a "install" -d 'Install one or multiple dependencies'
complete -c forge -n "__fish_use_subcommand" -f -a "remove" -d 'Remove one or multiple dependencies'
complete -c forge -n "__fish_use_subcommand" -f -a "remappings" -d 'Get the automatically inferred remappings for the project'
complete -c forge -n "__fish_use_subcommand" -f -a "verify-contract" -d 'Verify smart contracts on Etherscan'
complete -c forge -n "__fish_use_subcommand" -f -a "verify-check" -d 'Check verification status on Etherscan'
complete -c forge -n "__fish_use_subcommand" -f -a "create" -d 'Deploy a smart contract'
complete -c forge -n "__fish_use_subcommand" -f -a "init" -d 'Create a new Forge project'
complete -c forge -n "__fish_use_subcommand" -f -a "completions" -d 'Generate shell completions script'
complete -c forge -n "__fish_use_subcommand" -f -a "generate-fig-spec" -d 'Generate Fig autocompletion spec'
complete -c forge -n "__fish_use_subcommand" -f -a "clean" -d 'Remove the build artifacts and cache directories'
complete -c forge -n "__fish_use_subcommand" -f -a "cache" -d 'Manage the Foundry cache'
complete -c forge -n "__fish_use_subcommand" -f -a "snapshot" -d 'Create a snapshot of each test\'s gas usage'
complete -c forge -n "__fish_use_subcommand" -f -a "config" -d 'Display the current config'
complete -c forge -n "__fish_use_subcommand" -f -a "flatten" -d 'Flatten a source file and all of its imports into one file'
complete -c forge -n "__fish_use_subcommand" -f -a "fmt" -d 'Format Solidity source files'
complete -c forge -n "__fish_use_subcommand" -f -a "inspect" -d 'Get specialized information about a smart contract'
complete -c forge -n "__fish_use_subcommand" -f -a "tree" -d 'Display a tree visualization of the project\'s dependency graph'
complete -c forge -n "__fish_use_subcommand" -f -a "geiger" -d 'Detects usage of unsafe cheat codes in a project and its dependencies'
complete -c forge -n "__fish_use_subcommand" -f -a "doc" -d 'Generate documentation for the project'
complete -c forge -n "__fish_use_subcommand" -f -a "selectors" -d 'Function selector utilities'
complete -c forge -n "__fish_use_subcommand" -f -a "generate" -d 'Generate scaffold files'
complete -c forge -n "__fish_use_subcommand" -f -a "verify-bytecode" -d 'Verify the deployed bytecode against its source'
complete -c forge -n "__fish_use_subcommand" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from test" -l debug -d 'Run a test in the debugger' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l etherscan-api-key -d 'The Etherscan (or equivalent) API key' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l fuzz-seed -d 'Set seed used to generate randomness during your fuzz runs' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l fuzz-runs -r
complete -c forge -n "__fish_seen_subcommand_from test" -l fuzz-input-file -d 'File to rerun fuzz failures from' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l max-threads -d 'Max concurrent threads to use. Default value is the number of available CPUs' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l match-test -l mt -d 'Only run test functions matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l no-match-test -l nmt -d 'Only run test functions that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l match-contract -l mc -d 'Only run tests in contracts matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l no-match-contract -l nmc -d 'Only run tests in contracts that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l match-path -l mp -d 'Only run tests in source files matching the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l no-match-path -l nmp -d 'Only run tests in source files that do not match the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from test" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l fork-retries -d 'Number of retries' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l chain -l chain-id -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l memory-limit -d 'The memory limit per EVM execution in bytes. If this limit is exceeded, a `MemoryLimitOOG` result is thrown' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from test" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from test" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from test" -s w -l watch -d 'Watch the given files or directories for changes' -r -F
complete -c forge -n "__fish_seen_subcommand_from test" -l watch-delay -d 'File update debounce delay' -r
complete -c forge -n "__fish_seen_subcommand_from test" -l gas-report -d 'Print a gas report'
complete -c forge -n "__fish_seen_subcommand_from test" -l allow-failure -d 'Exit with code 0 even if a test fails'
complete -c forge -n "__fish_seen_subcommand_from test" -s j -l json -d 'Output test results in JSON format'
complete -c forge -n "__fish_seen_subcommand_from test" -l fail-fast -d 'Stop running tests after the first failure'
complete -c forge -n "__fish_seen_subcommand_from test" -s l -l list -d 'List tests instead of running them'
complete -c forge -n "__fish_seen_subcommand_from test" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from test" -l ffi -d 'Enable the FFI cheatcode'
complete -c forge -n "__fish_seen_subcommand_from test" -l always-use-create-2-factory -d 'Use the create 2 factory in all cases including tests and non-broadcasting scripts'
complete -c forge -n "__fish_seen_subcommand_from test" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from test" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node\'s provider'
complete -c forge -n "__fish_seen_subcommand_from test" -l disable-block-gas-limit -l no-gas-limit -d 'Whether to disable the block gas limit checks'
complete -c forge -n "__fish_seen_subcommand_from test" -l isolate -d 'Whether to enable isolation of calls. In isolation mode all top-level calls are executed as a separate transaction in a separate EVM context, enabling more precise gas accounting and transaction state changes'
complete -c forge -n "__fish_seen_subcommand_from test" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from test" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from test" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from test" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from test" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from test" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from test" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from test" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from test" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from test" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from test" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from test" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from test" -l no-restart -d 'Do not restart the command while it\'s still running'
complete -c forge -n "__fish_seen_subcommand_from test" -l run-all -d 'Explicitly re-run all tests when a change is made'
complete -c forge -n "__fish_seen_subcommand_from test" -l summary -d 'Print test summary table'
complete -c forge -n "__fish_seen_subcommand_from test" -l detailed -d 'Print detailed test summary table'
complete -c forge -n "__fish_seen_subcommand_from test" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from script" -l target-contract -l tc -d 'The name of the contract you want to run' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s s -l sig -d 'The signature of the function you want to call in the contract, or raw calldata' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l priority-gas-price -d 'Max priority fee per gas for EIP1559 transactions' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l batch-size -d 'Batch size of transactions' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s g -l gas-estimate-multiplier -d 'Relative percentage to multiply gas estimates by' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l etherscan-api-key -d 'The Etherscan (or equivalent) API key' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l with-gas-price -d 'Gas price for legacy transactions, or max fee per gas for EIP1559 transactions' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l skip -d 'Skip building files whose names contain the given filter' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from script" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from script" -s a -l froms -d 'The sender accounts' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s i -l interactives -d 'Open an interactive prompt to enter your private key' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l private-keys -d 'Use the provided private keys' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l private-key -d 'Use the provided private key' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l mnemonics -d 'Use the mnemonic phrases of mnemonic files at the specified paths' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l mnemonic-passphrases -d 'Use a BIP39 passphrases for the mnemonic' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l mnemonic-derivation-paths -d 'The wallet derivation path' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l mnemonic-indexes -d 'Use the private key from the given mnemonic index' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l keystore -l keystores -d 'Use the keystore in the given folder or file' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l account -l accounts -d 'Use a keystore from the default keystores folder (~/.foundry/keystores) by its filename' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l password -d 'The keystore password' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l password-file -d 'The keystore password file path' -r
complete -c forge -n "__fish_seen_subcommand_from script" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l fork-retries -d 'Number of retries' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l chain -l chain-id -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l memory-limit -d 'The memory limit per EVM execution in bytes. If this limit is exceeded, a `MemoryLimitOOG` result is thrown' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l verifier -d 'The contract verification provider to use' -r -f -a "{etherscan	'',sourcify	'',blockscout	'',oklink	''}"
complete -c forge -n "__fish_seen_subcommand_from script" -l verifier-url -d 'The verifier URL, if using a custom provider' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l retries -d 'Number of attempts for retrying verification' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l delay -d 'Optional delay to apply inbetween verification attempts, in seconds' -r
complete -c forge -n "__fish_seen_subcommand_from script" -l legacy -d 'Use legacy transactions instead of EIP1559 ones'
complete -c forge -n "__fish_seen_subcommand_from script" -l broadcast -d 'Broadcasts the transactions'
complete -c forge -n "__fish_seen_subcommand_from script" -l skip-simulation -d 'Skips on-chain simulation'
complete -c forge -n "__fish_seen_subcommand_from script" -l unlocked -d 'Send via `eth_sendTransaction` using the `--from` argument or `$ETH_FROM` as sender'
complete -c forge -n "__fish_seen_subcommand_from script" -l resume -d 'Resumes submitting transactions that failed or timed-out previously'
complete -c forge -n "__fish_seen_subcommand_from script" -l multi -d 'If present, --resume or --verify will be assumed to be a multi chain deployment'
complete -c forge -n "__fish_seen_subcommand_from script" -l debug -d 'Open the script in the debugger'
complete -c forge -n "__fish_seen_subcommand_from script" -l slow -d 'Makes sure a transaction is sent, only after its previous one has been confirmed and succeeded'
complete -c forge -n "__fish_seen_subcommand_from script" -l non-interactive -d 'Disables interactive prompts that might appear when deploying big contracts'
complete -c forge -n "__fish_seen_subcommand_from script" -l verify -d 'Verifies all the contracts found in the receipts of a script, if any'
complete -c forge -n "__fish_seen_subcommand_from script" -l json -d 'Output results in JSON format'
complete -c forge -n "__fish_seen_subcommand_from script" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from script" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from script" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from script" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from script" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from script" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from script" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from script" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from script" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from script" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from script" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from script" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from script" -s l -l ledger -d 'Use a Ledger hardware wallet'
complete -c forge -n "__fish_seen_subcommand_from script" -s t -l trezor -d 'Use a Trezor hardware wallet'
complete -c forge -n "__fish_seen_subcommand_from script" -l aws -d 'Use AWS Key Management Service'
complete -c forge -n "__fish_seen_subcommand_from script" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from script" -l ffi -d 'Enable the FFI cheatcode'
complete -c forge -n "__fish_seen_subcommand_from script" -l always-use-create-2-factory -d 'Use the create 2 factory in all cases including tests and non-broadcasting scripts'
complete -c forge -n "__fish_seen_subcommand_from script" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from script" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node\'s provider'
complete -c forge -n "__fish_seen_subcommand_from script" -l disable-block-gas-limit -l no-gas-limit -d 'Whether to disable the block gas limit checks'
complete -c forge -n "__fish_seen_subcommand_from script" -l isolate -d 'Whether to enable isolation of calls. In isolation mode all top-level calls are executed as a separate transaction in a separate EVM context, enabling more precise gas accounting and transaction state changes'
complete -c forge -n "__fish_seen_subcommand_from script" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l report -d 'The report type to use for coverage' -r -f -a "{summary	'',lcov	'',debug	'',bytecode	''}"
complete -c forge -n "__fish_seen_subcommand_from coverage" -s r -l report-file -d 'The path to output the report' -r -F
complete -c forge -n "__fish_seen_subcommand_from coverage" -l debug -d 'Run a test in the debugger' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l etherscan-api-key -d 'The Etherscan (or equivalent) API key' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l fuzz-seed -d 'Set seed used to generate randomness during your fuzz runs' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l fuzz-runs -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l fuzz-input-file -d 'File to rerun fuzz failures from' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l max-threads -d 'Max concurrent threads to use. Default value is the number of available CPUs' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l match-test -l mt -d 'Only run test functions matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-match-test -l nmt -d 'Only run test functions that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l match-contract -l mc -d 'Only run tests in contracts matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-match-contract -l nmc -d 'Only run tests in contracts that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l match-path -l mp -d 'Only run tests in source files matching the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-match-path -l nmp -d 'Only run tests in source files that do not match the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l fork-retries -d 'Number of retries' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l chain -l chain-id -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l memory-limit -d 'The memory limit per EVM execution in bytes. If this limit is exceeded, a `MemoryLimitOOG` result is thrown' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from coverage" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from coverage" -s w -l watch -d 'Watch the given files or directories for changes' -r -F
complete -c forge -n "__fish_seen_subcommand_from coverage" -l watch-delay -d 'File update debounce delay' -r
complete -c forge -n "__fish_seen_subcommand_from coverage" -l ir-minimum -d 'Enable viaIR with minimum optimization'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l include-libs -d 'Whether to include libraries in the coverage report'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l gas-report -d 'Print a gas report'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l allow-failure -d 'Exit with code 0 even if a test fails'
complete -c forge -n "__fish_seen_subcommand_from coverage" -s j -l json -d 'Output test results in JSON format'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l fail-fast -d 'Stop running tests after the first failure'
complete -c forge -n "__fish_seen_subcommand_from coverage" -s l -l list -d 'List tests instead of running them'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l ffi -d 'Enable the FFI cheatcode'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l always-use-create-2-factory -d 'Use the create 2 factory in all cases including tests and non-broadcasting scripts'
complete -c forge -n "__fish_seen_subcommand_from coverage" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node\'s provider'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l disable-block-gas-limit -l no-gas-limit -d 'Whether to disable the block gas limit checks'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l isolate -d 'Whether to enable isolation of calls. In isolation mode all top-level calls are executed as a separate transaction in a separate EVM context, enabling more precise gas accounting and transaction state changes'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l no-restart -d 'Do not restart the command while it\'s still running'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l run-all -d 'Explicitly re-run all tests when a change is made'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l summary -d 'Print test summary table'
complete -c forge -n "__fish_seen_subcommand_from coverage" -l detailed -d 'Print detailed test summary table'
complete -c forge -n "__fish_seen_subcommand_from coverage" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from bind" -s b -l bindings-path -d 'Path to where the contract artifacts are stored' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -l select -d 'Create bindings only for contracts whose names match the specified filter(s)' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l skip -d 'Create bindings only for contracts whose names do not match the specified filter(s)' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l crate-name -d 'The name of the Rust crate to generate' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l crate-version -d 'The version of the Rust crate to generate' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from bind" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from bind" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from bind" -l select-all -d 'Explicitly generate bindings for all contracts'
complete -c forge -n "__fish_seen_subcommand_from bind" -l module -d 'Generate the bindings as a module instead of a crate'
complete -c forge -n "__fish_seen_subcommand_from bind" -l overwrite -d 'Overwrite existing generated bindings'
complete -c forge -n "__fish_seen_subcommand_from bind" -l single-file -d 'Generate bindings as a single file'
complete -c forge -n "__fish_seen_subcommand_from bind" -l skip-cargo-toml -d 'Skip Cargo.toml consistency checks'
complete -c forge -n "__fish_seen_subcommand_from bind" -l skip-build -d 'Skips running forge build before generating binding'
complete -c forge -n "__fish_seen_subcommand_from bind" -l skip-extra-derives -d 'Don\'t add any additional derives to generated bindings'
complete -c forge -n "__fish_seen_subcommand_from bind" -l ethers -d 'Generate bindings for the `ethers` library, instead of `alloy` (default, deprecated)'
complete -c forge -n "__fish_seen_subcommand_from bind" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from bind" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from bind" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from bind" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from bind" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from bind" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from bind" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from bind" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from bind" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from bind" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from bind" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from bind" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from bind" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from build" -l skip -d 'Skip building files whose names contain the given filter' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from build" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from build" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from build" -s w -l watch -d 'Watch the given files or directories for changes' -r -F
complete -c forge -n "__fish_seen_subcommand_from build" -l watch-delay -d 'File update debounce delay' -r
complete -c forge -n "__fish_seen_subcommand_from build" -l names -d 'Print compiled contract names'
complete -c forge -n "__fish_seen_subcommand_from build" -l sizes -d 'Print compiled contract sizes'
complete -c forge -n "__fish_seen_subcommand_from build" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from build" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from build" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from build" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from build" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from build" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from build" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from build" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from build" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from build" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from build" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from build" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from build" -l no-restart -d 'Do not restart the command while it\'s still running'
complete -c forge -n "__fish_seen_subcommand_from build" -l run-all -d 'Explicitly re-run all tests when a change is made'
complete -c forge -n "__fish_seen_subcommand_from build" -l format-json -d 'Output the compilation errors in the json format. This is useful when you want to use the output in other tools'
complete -c forge -n "__fish_seen_subcommand_from build" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from clone" -s e -l etherscan-api-key -d 'The Etherscan (or equivalent) API key' -r
complete -c forge -n "__fish_seen_subcommand_from clone" -s c -l chain -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from clone" -l no-remappings-txt -d 'Do not generate the remappings.txt file. Instead, keep the remappings in the configuration'
complete -c forge -n "__fish_seen_subcommand_from clone" -l keep-directory-structure -d 'Keep the original directory structure collected from Etherscan'
complete -c forge -n "__fish_seen_subcommand_from clone" -l shallow -d 'Perform shallow clones instead of deep ones'
complete -c forge -n "__fish_seen_subcommand_from clone" -l no-git -d 'Install without adding the dependency as a submodule'
complete -c forge -n "__fish_seen_subcommand_from clone" -l no-commit -d 'Do not create a commit'
complete -c forge -n "__fish_seen_subcommand_from clone" -s q -l quiet -d 'Do not print any messages'
complete -c forge -n "__fish_seen_subcommand_from clone" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from debug" -l target-contract -l tc -d 'The name of the contract you want to run' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -s s -l sig -d 'The signature of the function you want to call in the contract, or raw calldata' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from debug" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from debug" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l fork-retries -d 'Number of retries' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l chain -l chain-id -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l memory-limit -d 'The memory limit per EVM execution in bytes. If this limit is exceeded, a `MemoryLimitOOG` result is thrown' -r
complete -c forge -n "__fish_seen_subcommand_from debug" -l debug -d 'Open the script in the debugger'
complete -c forge -n "__fish_seen_subcommand_from debug" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from debug" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from debug" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from debug" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from debug" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from debug" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from debug" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from debug" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from debug" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from debug" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from debug" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from debug" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from debug" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from debug" -l ffi -d 'Enable the FFI cheatcode'
complete -c forge -n "__fish_seen_subcommand_from debug" -l always-use-create-2-factory -d 'Use the create 2 factory in all cases including tests and non-broadcasting scripts'
complete -c forge -n "__fish_seen_subcommand_from debug" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from debug" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node\'s provider'
complete -c forge -n "__fish_seen_subcommand_from debug" -l disable-block-gas-limit -l no-gas-limit -d 'Whether to disable the block gas limit checks'
complete -c forge -n "__fish_seen_subcommand_from debug" -l isolate -d 'Whether to enable isolation of calls. In isolation mode all top-level calls are executed as a separate transaction in a separate EVM context, enabling more precise gas accounting and transaction state changes'
complete -c forge -n "__fish_seen_subcommand_from debug" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from update" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from update" -s f -l force -d 'Override the up-to-date check'
complete -c forge -n "__fish_seen_subcommand_from update" -s r -l recursive -d 'Recursively update submodules'
complete -c forge -n "__fish_seen_subcommand_from update" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from install" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from install" -l shallow -d 'Perform shallow clones instead of deep ones'
complete -c forge -n "__fish_seen_subcommand_from install" -l no-git -d 'Install without adding the dependency as a submodule'
complete -c forge -n "__fish_seen_subcommand_from install" -l no-commit -d 'Do not create a commit'
complete -c forge -n "__fish_seen_subcommand_from install" -s q -l quiet -d 'Do not print any messages'
complete -c forge -n "__fish_seen_subcommand_from install" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from remove" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from remove" -s f -l force -d 'Override the up-to-date check'
complete -c forge -n "__fish_seen_subcommand_from remove" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from remappings" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from remappings" -l pretty -d 'Pretty-print the remappings, grouping each of them by context'
complete -c forge -n "__fish_seen_subcommand_from remappings" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l constructor-args -l encoded-constructor-args -d 'The ABI-encoded constructor arguments' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l constructor-args-path -d 'The path to a file containing the constructor arguments' -r -F
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l compiler-version -d 'The `solc` version to use to build the smart contract' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l num-of-optimizations -l optimizer-runs -d 'The number of optimization runs used to build the smart contract' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l evm-version -d 'The EVM version to use' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -s e -l etherscan-api-key -d 'The Etherscan (or equivalent) API key' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -s c -l chain -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -s r -l rpc-url -d 'The RPC endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l jwt-secret -d 'JWT Secret for the RPC endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l retries -d 'Number of attempts for retrying verification' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l delay -d 'Optional delay to apply inbetween verification attempts, in seconds' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l verifier -d 'The contract verification provider to use' -r -f -a "{etherscan	'',sourcify	'',blockscout	'',oklink	''}"
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l verifier-url -d 'The verifier URL, if using a custom provider' -r
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l guess-constructor-args -d 'Try to extract constructor arguments from on-chain creation code'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l flatten -d 'Flatten the source code before verifying'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -s f -l force -d 'Do not compile the flattened smart contract before verifying (if --flatten is passed)'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l skip-is-verified-check -d 'Do not check if the contract is already verified before verifying'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l watch -d 'Wait for verification result after submission'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l show-standard-json-input -d 'Prints the standard json compiler input'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -l flashbots -d 'Use the Flashbots RPC URL with fast mode (https://rpc.flashbots.net/fast). This shares the transaction privately with all registered builders. https://docs.flashbots.net/flashbots-protect/quick-start#faster-transactions'
complete -c forge -n "__fish_seen_subcommand_from verify-contract" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from verify-check" -l retries -d 'Number of attempts for retrying verification' -r
complete -c forge -n "__fish_seen_subcommand_from verify-check" -l delay -d 'Optional delay to apply inbetween verification attempts, in seconds' -r
complete -c forge -n "__fish_seen_subcommand_from verify-check" -s e -l etherscan-api-key -d 'The Etherscan (or equivalent) API key' -r
complete -c forge -n "__fish_seen_subcommand_from verify-check" -s c -l chain -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from verify-check" -l verifier -d 'The contract verification provider to use' -r -f -a "{etherscan	'',sourcify	'',blockscout	'',oklink	''}"
complete -c forge -n "__fish_seen_subcommand_from verify-check" -l verifier-url -d 'The verifier URL, if using a custom provider' -r
complete -c forge -n "__fish_seen_subcommand_from verify-check" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from create" -l constructor-args -d 'The constructor arguments' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l constructor-args-path -d 'The path to a file containing the constructor arguments' -r -F
complete -c forge -n "__fish_seen_subcommand_from create" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from create" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from create" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from create" -l gas-limit -d 'Gas limit for the transaction' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l gas-price -d 'Gas price for legacy transactions, or max fee per gas for EIP1559 transactions' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l priority-gas-price -d 'Max priority fee per gas for EIP1559 transactions' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l value -d 'Ether to send in the transaction, either specified in wei, or as a string with a unit type' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l nonce -d 'Nonce for the transaction' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l blob-gas-price -d 'Gas price for EIP-4844 blob transaction' -r
complete -c forge -n "__fish_seen_subcommand_from create" -s r -l rpc-url -d 'The RPC endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l jwt-secret -d 'JWT Secret for the RPC endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from create" -s e -l etherscan-api-key -d 'The Etherscan (or equivalent) API key' -r
complete -c forge -n "__fish_seen_subcommand_from create" -s c -l chain -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from create" -s f -l from -d 'The sender account' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l private-key -d 'Use the provided private key' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l mnemonic -d 'Use the mnemonic phrase of mnemonic file at the specified path' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l mnemonic-passphrase -d 'Use a BIP39 passphrase for the mnemonic' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l mnemonic-derivation-path -d 'The wallet derivation path' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l mnemonic-index -d 'Use the private key from the given mnemonic index' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l keystore -d 'Use the keystore in the given folder or file' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l account -d 'Use a keystore from the default keystores folder (~/.foundry/keystores) by its filename' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l password -d 'The keystore password' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l password-file -d 'The keystore password file path' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l verifier -d 'The contract verification provider to use' -r -f -a "{etherscan	'',sourcify	'',blockscout	'',oklink	''}"
complete -c forge -n "__fish_seen_subcommand_from create" -l verifier-url -d 'The verifier URL, if using a custom provider' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l retries -d 'Number of attempts for retrying verification' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l delay -d 'Optional delay to apply inbetween verification attempts, in seconds' -r
complete -c forge -n "__fish_seen_subcommand_from create" -l json -d 'Print the deployment information as JSON'
complete -c forge -n "__fish_seen_subcommand_from create" -l verify -d 'Verify contract after creation'
complete -c forge -n "__fish_seen_subcommand_from create" -l unlocked -d 'Send via `eth_sendTransaction` using the `--from` argument or `$ETH_FROM` as sender'
complete -c forge -n "__fish_seen_subcommand_from create" -l show-standard-json-input -d 'Prints the standard json compiler input if `--verify` is provided'
complete -c forge -n "__fish_seen_subcommand_from create" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from create" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from create" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from create" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from create" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from create" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from create" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from create" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from create" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from create" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from create" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from create" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from create" -l legacy -d 'Send a legacy transaction instead of an EIP1559 transaction'
complete -c forge -n "__fish_seen_subcommand_from create" -l blob -d 'Send a EIP-4844 blob transaction'
complete -c forge -n "__fish_seen_subcommand_from create" -l flashbots -d 'Use the Flashbots RPC URL with fast mode (https://rpc.flashbots.net/fast). This shares the transaction privately with all registered builders. https://docs.flashbots.net/flashbots-protect/quick-start#faster-transactions'
complete -c forge -n "__fish_seen_subcommand_from create" -s i -l interactive -d 'Open an interactive prompt to enter your private key'
complete -c forge -n "__fish_seen_subcommand_from create" -s l -l ledger -d 'Use a Ledger hardware wallet'
complete -c forge -n "__fish_seen_subcommand_from create" -s t -l trezor -d 'Use a Trezor hardware wallet'
complete -c forge -n "__fish_seen_subcommand_from create" -l aws -d 'Use AWS Key Management Service'
complete -c forge -n "__fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from init" -s t -l template -d 'The template to start from' -r
complete -c forge -n "__fish_seen_subcommand_from init" -s b -l branch -d 'Branch argument that can only be used with template option. If not specified, the default branch is used' -r
complete -c forge -n "__fish_seen_subcommand_from init" -l offline -l no-deps -d 'Do not install dependencies from the network'
complete -c forge -n "__fish_seen_subcommand_from init" -l force -d 'Create the project even if the specified root directory is not empty'
complete -c forge -n "__fish_seen_subcommand_from init" -l vscode -d 'Create a .vscode/settings.json file with Solidity settings, and generate a remappings.txt file'
complete -c forge -n "__fish_seen_subcommand_from init" -l shallow -d 'Perform shallow clones instead of deep ones'
complete -c forge -n "__fish_seen_subcommand_from init" -l no-git -d 'Install without adding the dependency as a submodule'
complete -c forge -n "__fish_seen_subcommand_from init" -l no-commit -d 'Do not create a commit'
complete -c forge -n "__fish_seen_subcommand_from init" -s q -l quiet -d 'Do not print any messages'
complete -c forge -n "__fish_seen_subcommand_from init" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from completions" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from generate-fig-spec" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from clean" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from clean" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "clean" -d 'Cleans cached data from the global foundry directory'
complete -c forge -n "__fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "ls" -d 'Shows cached data from the global foundry directory'
complete -c forge -n "__fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from clean" -s b -l blocks -d 'The blocks to clean the cache for' -r
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from clean" -l etherscan -d 'Whether to clean the Etherscan cache'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from clean" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from ls" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "clean" -d 'Cleans cached data from the global foundry directory'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "ls" -d 'Shows cached data from the global foundry directory'
complete -c forge -n "__fish_seen_subcommand_from cache; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l diff -d 'Output a diff against a pre-existing snapshot' -r -F
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l check -d 'Compare against a pre-existing snapshot, exiting with code 1 if they do not match' -r -F
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l format -d 'How to format the output' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l snap -d 'Output file for the snapshot' -r -F
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l tolerance -d 'Tolerates gas deviations up to the specified percentage' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l debug -d 'Run a test in the debugger' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l etherscan-api-key -d 'The Etherscan (or equivalent) API key' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l fuzz-seed -d 'Set seed used to generate randomness during your fuzz runs' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l fuzz-runs -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l fuzz-input-file -d 'File to rerun fuzz failures from' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l max-threads -d 'Max concurrent threads to use. Default value is the number of available CPUs' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l match-test -l mt -d 'Only run test functions matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-match-test -l nmt -d 'Only run test functions that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l match-contract -l mc -d 'Only run tests in contracts matching the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-match-contract -l nmc -d 'Only run tests in contracts that do not match the specified regex pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l match-path -l mp -d 'Only run tests in source files matching the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-match-path -l nmp -d 'Only run tests in source files that do not match the specified glob pattern' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l fork-retries -d 'Number of retries' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l chain -l chain-id -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l memory-limit -d 'The memory limit per EVM execution in bytes. If this limit is exceeded, a `MemoryLimitOOG` result is thrown' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s w -l watch -d 'Watch the given files or directories for changes' -r -F
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l watch-delay -d 'File update debounce delay' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l min -d 'Only include tests that used more gas that the given amount' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l max -d 'Only include tests that used less gas that the given amount' -r
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l gas-report -d 'Print a gas report'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l allow-failure -d 'Exit with code 0 even if a test fails'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s j -l json -d 'Output test results in JSON format'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l fail-fast -d 'Stop running tests after the first failure'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s l -l list -d 'List tests instead of running them'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l ffi -d 'Enable the FFI cheatcode'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l always-use-create-2-factory -d 'Use the create 2 factory in all cases including tests and non-broadcasting scripts'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node\'s provider'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l disable-block-gas-limit -l no-gas-limit -d 'Whether to disable the block gas limit checks'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l isolate -d 'Whether to enable isolation of calls. In isolation mode all top-level calls are executed as a separate transaction in a separate EVM context, enabling more precise gas accounting and transaction state changes'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l no-restart -d 'Do not restart the command while it\'s still running'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l run-all -d 'Explicitly re-run all tests when a change is made'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l summary -d 'Print test summary table'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l detailed -d 'Print detailed test summary table'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l asc -d 'Sort results by gas used (ascending)'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -l desc -d 'Sort results by gas used (descending)'
complete -c forge -n "__fish_seen_subcommand_from snapshot" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from config" -l skip -d 'Skip building files whose names contain the given filter' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from config" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from config" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from config" -s w -l watch -d 'Watch the given files or directories for changes' -r -F
complete -c forge -n "__fish_seen_subcommand_from config" -l watch-delay -d 'File update debounce delay' -r
complete -c forge -n "__fish_seen_subcommand_from config" -s f -l fork-url -l rpc-url -d 'Fetch state over a remote endpoint instead of starting from an empty state' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l fork-block-number -d 'Fetch state from a specific block number over a remote endpoint' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l fork-retries -d 'Number of retries' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l fork-retry-backoff -d 'Initial retry backoff on encountering errors' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l initial-balance -d 'The initial balance of deployed test contracts' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l sender -d 'The address which will be executing tests' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l compute-units-per-second -d 'Sets the number of assumed available compute units per second for this provider' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l code-size-limit -d 'EIP-170: Contract code size limit in bytes. Useful to increase this because of tests. By default, it is 0x6000 (~25kb)' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l chain -l chain-id -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l gas-price -d 'The gas price' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-base-fee-per-gas -l base-fee -d 'The base fee in a block' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l tx-origin -d 'The transaction origin' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-coinbase -d 'The coinbase of the block' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-timestamp -d 'The timestamp of the block' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-number -d 'The block number' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-difficulty -d 'The block difficulty' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-prevrandao -d 'The block prevrandao value. NOTE: Before merge this field was mix_hash' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l block-gas-limit -d 'The block gas limit' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l memory-limit -d 'The memory limit per EVM execution in bytes. If this limit is exceeded, a `MemoryLimitOOG` result is thrown' -r
complete -c forge -n "__fish_seen_subcommand_from config" -l basic -d 'Print only a basic set of the currently set config values'
complete -c forge -n "__fish_seen_subcommand_from config" -l json -d 'Print currently set config values as JSON'
complete -c forge -n "__fish_seen_subcommand_from config" -l fix -d 'Attempt to fix any configuration warnings'
complete -c forge -n "__fish_seen_subcommand_from config" -l names -d 'Print compiled contract names'
complete -c forge -n "__fish_seen_subcommand_from config" -l sizes -d 'Print compiled contract sizes'
complete -c forge -n "__fish_seen_subcommand_from config" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from config" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from config" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from config" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from config" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from config" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from config" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from config" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from config" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from config" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from config" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from config" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from config" -l no-restart -d 'Do not restart the command while it\'s still running'
complete -c forge -n "__fish_seen_subcommand_from config" -l run-all -d 'Explicitly re-run all tests when a change is made'
complete -c forge -n "__fish_seen_subcommand_from config" -l format-json -d 'Output the compilation errors in the json format. This is useful when you want to use the output in other tools'
complete -c forge -n "__fish_seen_subcommand_from config" -l no-storage-caching -d 'Explicitly disables the use of RPC caching'
complete -c forge -n "__fish_seen_subcommand_from config" -l ffi -d 'Enable the FFI cheatcode'
complete -c forge -n "__fish_seen_subcommand_from config" -l always-use-create-2-factory -d 'Use the create 2 factory in all cases including tests and non-broadcasting scripts'
complete -c forge -n "__fish_seen_subcommand_from config" -s v -l verbosity -d 'Verbosity of the EVM.'
complete -c forge -n "__fish_seen_subcommand_from config" -l no-rpc-rate-limit -l no-rate-limit -d 'Disables rate limiting for this node\'s provider'
complete -c forge -n "__fish_seen_subcommand_from config" -l disable-block-gas-limit -l no-gas-limit -d 'Whether to disable the block gas limit checks'
complete -c forge -n "__fish_seen_subcommand_from config" -l isolate -d 'Whether to enable isolation of calls. In isolation mode all top-level calls are executed as a separate transaction in a separate EVM context, enabling more precise gas accounting and transaction state changes'
complete -c forge -n "__fish_seen_subcommand_from config" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from flatten" -s o -l output -d 'The path to output the flattened contract' -r -F
complete -c forge -n "__fish_seen_subcommand_from flatten" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from flatten" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from flatten" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from flatten" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from flatten" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from flatten" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from flatten" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from flatten" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from flatten" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from fmt" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from fmt" -l check -d 'Run in \'check\' mode'
complete -c forge -n "__fish_seen_subcommand_from fmt" -s r -l raw -d 'In \'check\' and stdin modes, outputs raw formatted code instead of the diff'
complete -c forge -n "__fish_seen_subcommand_from fmt" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from inspect" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from inspect" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from inspect" -l pretty -d 'Pretty print the selected field, if supported'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from inspect" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from inspect" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from tree" -l charset -d 'Character set to use in output' -r
complete -c forge -n "__fish_seen_subcommand_from tree" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from tree" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from tree" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from tree" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from tree" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from tree" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from tree" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from tree" -l no-dedupe -d 'Do not de-duplicate (repeats all shared dependencies)'
complete -c forge -n "__fish_seen_subcommand_from tree" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from tree" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from geiger" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from geiger" -l ignore -d 'Globs to ignore' -r -F
complete -c forge -n "__fish_seen_subcommand_from geiger" -l check -d 'Run in "check" mode'
complete -c forge -n "__fish_seen_subcommand_from geiger" -l full -d 'Print a report of all files, even if no unsafe functions are found'
complete -c forge -n "__fish_seen_subcommand_from geiger" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from doc" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from doc" -s o -l out -d 'The doc\'s output path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from doc" -l hostname -d 'Hostname for serving documentation' -r
complete -c forge -n "__fish_seen_subcommand_from doc" -s p -l port -d 'Port for serving documentation' -r
complete -c forge -n "__fish_seen_subcommand_from doc" -l deployments -d 'The relative path to the `hardhat-deploy` or `forge-deploy` artifact directory. Leave blank for default' -r -F
complete -c forge -n "__fish_seen_subcommand_from doc" -s b -l build -d 'Build the `mdbook` from generated files'
complete -c forge -n "__fish_seen_subcommand_from doc" -s s -l serve -d 'Serve the documentation'
complete -c forge -n "__fish_seen_subcommand_from doc" -l open -d 'Open the documentation in a browser after serving'
complete -c forge -n "__fish_seen_subcommand_from doc" -s i -l include-libraries -d 'Whether to create docs for external libraries'
complete -c forge -n "__fish_seen_subcommand_from doc" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from help" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from help" -f -a "collision" -d 'Check for selector collisions between contracts'
complete -c forge -n "__fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from help" -f -a "upload" -d 'Upload selectors to registry'
complete -c forge -n "__fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from help" -f -a "list" -d 'List selectors from current workspace'
complete -c forge -n "__fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l libraries -d 'Set pre-linked libraries' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l ignored-error-codes -d 'Ignore solc warnings by error code' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l use -d 'Specify the solc version, or a path to a local solc, to build with' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -s o -l out -d 'The path to the contract artifacts folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l revert-strings -d 'Revert string configuration' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l build-info-path -d 'Output path to directory that build info files will be written to' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l evm-version -d 'The target EVM version' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l optimizer-runs -d 'The number of optimizer runs' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l extra-output -d 'Extra output to include in the contract\'s artifact' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l extra-output-files -d 'Extra output to write to separate files' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l force -d 'Clear the cache and artifacts folder and recompile'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l no-cache -d 'Disable the cache'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l deny-warnings -d 'Warnings will trigger a compiler error'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l no-auto-detect -d 'Do not auto-detect the `solc` version'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l offline -d 'Do not access the network'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l via-ir -d 'Use the Yul intermediate representation compilation pipeline'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l no-metadata -d 'Do not append any metadata to the bytecode'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l silent -d 'Don\'t print anything on startup'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l build-info -d 'Generate build info files'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l ast -d 'Includes the AST as JSON in the compiler output'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l optimize -d 'Activate the Solidity optimizer'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from collision" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from upload" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from upload" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from upload" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from upload" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from upload" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from upload" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from upload" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from upload" -l all -d 'Upload selectors for all contracts in the project'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from upload" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from upload" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from list" -l root -d 'The project\'s root path' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from list" -s C -l contracts -d 'The contracts source directory' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from list" -s R -l remappings -d 'The project\'s remappings' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from list" -l remappings-env -d 'The project\'s remappings from the environment' -r
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from list" -l cache-path -d 'The path to the compiler cache' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from list" -l lib-paths -d 'The path to the library folder' -r -f -a "(__fish_complete_directories)"
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from list" -l config-path -d 'Path to the config file' -r -F
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from list" -l hardhat -l hh -d 'Use the Hardhat-style project layout'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from help" -f -a "collision" -d 'Check for selector collisions between contracts'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from help" -f -a "upload" -d 'Upload selectors to registry'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from help" -f -a "list" -d 'List selectors from current workspace'
complete -c forge -n "__fish_seen_subcommand_from selectors; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from help" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from help" -f -a "test" -d 'Scaffolds test file for given contract'
complete -c forge -n "__fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from generate; and __fish_seen_subcommand_from test" -s c -l contract-name -d 'Contract name for test generation' -r
complete -c forge -n "__fish_seen_subcommand_from generate; and __fish_seen_subcommand_from test" -s h -l help -d 'Print help'
complete -c forge -n "__fish_seen_subcommand_from generate; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from help" -f -a "test" -d 'Scaffolds test file for given contract'
complete -c forge -n "__fish_seen_subcommand_from generate; and __fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from verify-bytecode" -l block -d 'The block at which the bytecode should be verified' -r
complete -c forge -n "__fish_seen_subcommand_from verify-bytecode" -l constructor-args -l encoded-constructor-args -d 'The constructor args to generate the creation code' -r
complete -c forge -n "__fish_seen_subcommand_from verify-bytecode" -l constructor-args-path -d 'The path to a file containing the constructor arguments' -r -F
complete -c forge -n "__fish_seen_subcommand_from verify-bytecode" -s r -l rpc-url -d 'The rpc url to use for verification' -r
complete -c forge -n "__fish_seen_subcommand_from verify-bytecode" -l verification-type -d 'Verfication Type: `full` or `partial`. Ref: https://docs.sourcify.dev/docs/full-vs-partial-match/' -r -f -a "{full	'',partial	''}"
complete -c forge -n "__fish_seen_subcommand_from verify-bytecode" -s e -l etherscan-api-key -d 'The Etherscan (or equivalent) API key' -r
complete -c forge -n "__fish_seen_subcommand_from verify-bytecode" -s c -l chain -d 'The chain name or EIP-155 chain ID' -r
complete -c forge -n "__fish_seen_subcommand_from verify-bytecode" -l skip -d 'Skip building files whose names contain the given filter' -r
complete -c forge -n "__fish_seen_subcommand_from verify-bytecode" -l json -d 'Suppress logs and emit json results to stdout'
complete -c forge -n "__fish_seen_subcommand_from verify-bytecode" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "test" -d 'Run the project\'s tests'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "script" -d 'Run a smart contract as a script, building transactions that can be sent onchain'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "coverage" -d 'Generate coverage reports'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "bind" -d 'Generate Rust bindings for smart contracts'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "build" -d 'Build the project\'s smart contracts'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "clone" -d 'Clone a contract from Etherscan'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "debug" -d 'Debugs a single smart contract as a script'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "update" -d 'Update one or multiple dependencies'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "install" -d 'Install one or multiple dependencies'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "remove" -d 'Remove one or multiple dependencies'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "remappings" -d 'Get the automatically inferred remappings for the project'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "verify-contract" -d 'Verify smart contracts on Etherscan'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "verify-check" -d 'Check verification status on Etherscan'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "create" -d 'Deploy a smart contract'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "init" -d 'Create a new Forge project'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "completions" -d 'Generate shell completions script'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "generate-fig-spec" -d 'Generate Fig autocompletion spec'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "clean" -d 'Remove the build artifacts and cache directories'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "cache" -d 'Manage the Foundry cache'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "snapshot" -d 'Create a snapshot of each test\'s gas usage'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "config" -d 'Display the current config'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "flatten" -d 'Flatten a source file and all of its imports into one file'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "fmt" -d 'Format Solidity source files'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "inspect" -d 'Get specialized information about a smart contract'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "tree" -d 'Display a tree visualization of the project\'s dependency graph'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "geiger" -d 'Detects usage of unsafe cheat codes in a project and its dependencies'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "doc" -d 'Generate documentation for the project'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "selectors" -d 'Function selector utilities'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "generate" -d 'Generate scaffold files'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "verify-bytecode" -d 'Verify the deployed bytecode against its source'
complete -c forge -n "__fish_seen_subcommand_from help; and not __fish_seen_subcommand_from test; and not __fish_seen_subcommand_from script; and not __fish_seen_subcommand_from coverage; and not __fish_seen_subcommand_from bind; and not __fish_seen_subcommand_from build; and not __fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from debug; and not __fish_seen_subcommand_from update; and not __fish_seen_subcommand_from install; and not __fish_seen_subcommand_from remove; and not __fish_seen_subcommand_from remappings; and not __fish_seen_subcommand_from verify-contract; and not __fish_seen_subcommand_from verify-check; and not __fish_seen_subcommand_from create; and not __fish_seen_subcommand_from init; and not __fish_seen_subcommand_from completions; and not __fish_seen_subcommand_from generate-fig-spec; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from snapshot; and not __fish_seen_subcommand_from config; and not __fish_seen_subcommand_from flatten; and not __fish_seen_subcommand_from fmt; and not __fish_seen_subcommand_from inspect; and not __fish_seen_subcommand_from tree; and not __fish_seen_subcommand_from geiger; and not __fish_seen_subcommand_from doc; and not __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from verify-bytecode; and not __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c forge -n "__fish_seen_subcommand_from help; and __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls" -f -a "clean" -d 'Cleans cached data from the global foundry directory'
complete -c forge -n "__fish_seen_subcommand_from help; and __fish_seen_subcommand_from cache; and not __fish_seen_subcommand_from clean; and not __fish_seen_subcommand_from ls" -f -a "ls" -d 'Shows cached data from the global foundry directory'
complete -c forge -n "__fish_seen_subcommand_from help; and __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list" -f -a "collision" -d 'Check for selector collisions between contracts'
complete -c forge -n "__fish_seen_subcommand_from help; and __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list" -f -a "upload" -d 'Upload selectors to registry'
complete -c forge -n "__fish_seen_subcommand_from help; and __fish_seen_subcommand_from selectors; and not __fish_seen_subcommand_from collision; and not __fish_seen_subcommand_from upload; and not __fish_seen_subcommand_from list" -f -a "list" -d 'List selectors from current workspace'
complete -c forge -n "__fish_seen_subcommand_from help; and __fish_seen_subcommand_from generate; and not __fish_seen_subcommand_from test" -f -a "test" -d 'Scaffolds test file for given contract'

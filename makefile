# Include .env file
-include .env

# Declare phony targets
.PHONY: all test clean deploy fund help install snapshot format anvil Mint deployMood mintMoodNft flipMoodNft zkdeploy

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""

# Default target: Clean and prepare environment
all: clean remove install update build

# Clean the repo
clean:; forge clean

# Remove modules
remove:; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

# Install dependencies
install:; forge install Harystyleseze/foundry-devops@0.0.11 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit

# Update dependencies
update:; forge update

# Build the contracts
build:; forge build

# Run tests
test:; forge test

# Take a snapshot of the contracts
snapshot:; forge snapshot

# Format the code
format:; forge fmt

# Start Anvil node
anvil:; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1 --port 8546 --gas-price 2000000000 --disable-min-priority-fee --block-base-fee-per-gas 0

# Set network-specific arguments based on ARGS passed to the `make` command
NETWORK_ARGS := --rpc-url http://localhost:8546 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network holesky,$(ARGS)),--network holesky)
	NETWORK_ARGS := --rpc-url $(HOLESKY_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast
endif

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

ifeq ($(findstring --network ephemery,$(ARGS)),--network ephemery)
	NETWORK_ARGS := --rpc-url $(EPHEMERY_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast
endif

# Deployment scripts
# Deployment command
# deploy:
# 	@forge script script/DeployHarystylesMainToken.s.sol:DeployHarystylesMainToken $(NETWORK_ARGS) --gas-price 200000000 --block-base-fee-per-gas 0 -- --no-eip1559
deploy:
	@forge script script/DeployHarystylesNft.s.sol:DeployHarystylesNft $(NETWORK_ARGS)

Mint:
	@forge script script/Interactions.s.sol:MintHarystylesNft $(NETWORK_ARGS)

deployMood:
	@forge script script/DeployMoodNft.s.sol:DeployMoodNft $(NETWORK_ARGS)

mintMoodNft:
	@forge script script/Interactions.s.sol:MintMoodNft $(NETWORK_ARGS)

flipMoodNft:
	@forge script script/Interactions.s.sol:FlipMoodNft $(NETWORK_ARGS)

# zkSync Deployment (local testnet)
zkdeploy:
	@forge create src/OurToken.sol:OurToken --rpc-url http://127.0.0.1:8011 --private-key $(DEFAULT_ZKSYNC_LOCAL_KEY) --legacy --zksync

help: ## Display this help screen
	@grep -h \
		-E '^[a-zA-Z_0-9-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


query_l1: ## query from l1
	@cd ../ && ./web3/web3 --rpc-url http://localhost:8545 balance  0x618263CE921F7dd5F4f40C29f6c524Aaf97b9bbd && cd local-setup

query_l2: ## query from l2
	@cd ../ && ./web3/web3 --rpc-url http://localhost:3050 balance  0x618263CE921F7dd5F4f40C29f6c524Aaf97b9bbd && cd local-setup


fund: ## faught for l1: eth.sendTransaction({from: personal.listAccounts[0], to: "0xde03a0b5963f75f1c8485b355ff6d30f3093bde7", value: "7400000000000000000"})
	@eth.sendTransaction({from: personal.listAccounts[0], to: "0x618263CE921F7dd5F4f40C29f6c524Aaf97b9bbd", value: "7400000000000000000"})

transfer: ## transfer from l1->l2. Key in: Private key of the sender: 0x5090c024edb3bdf4ce2ebc2da96bedee925d9d77d729687e5e2d56382cf0a5a6  Recipient address on L2: 0x618263CE921F7dd5F4f40C29f6c524Aaf97b9bbd
	@npx zksync-cli bridge deposit


login_db: ## pswd: notsecurepassword
	@psql -h localhost -U postgres


login_geth: ## enter geth's docker bash
	@docker container exec -it local-setup_geth_1  geth attach http://localhost:8545

.PHONY: clippy fmt test
{
	"compiler": {
		"version": "0.8.2+commit.661d1103"
	},
	"language": "Solidity",
	"output": {
		"abi": [
			{
				"inputs": [],
				"stateMutability": "nonpayable",
				"type": "constructor"
			},
			{
				"anonymous": false,
				"inputs": [
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "auctionIndex",
						"type": "uint256"
					},
					{
						"indexed": true,
						"internalType": "address",
						"name": "_address",
						"type": "address"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "tokenId",
						"type": "uint256"
					},
					{
						"indexed": false,
						"internalType": "address",
						"name": "claimedBy",
						"type": "address"
					}
				],
				"name": "NFTClaimed",
				"type": "event"
			},
			{
				"anonymous": false,
				"inputs": [
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "auctionIndex",
						"type": "uint256"
					},
					{
						"indexed": true,
						"internalType": "address",
						"name": "_address",
						"type": "address"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "tokenId",
						"type": "uint256"
					},
					{
						"indexed": false,
						"internalType": "address",
						"name": "claimedBy",
						"type": "address"
					}
				],
				"name": "NFTRefunded",
				"type": "event"
			},
			{
				"anonymous": false,
				"inputs": [
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "index",
						"type": "uint256"
					},
					{
						"indexed": false,
						"internalType": "address",
						"name": "addressNFTCollection",
						"type": "address"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "nftId",
						"type": "uint256"
					},
					{
						"indexed": false,
						"internalType": "address",
						"name": "mintedBy",
						"type": "address"
					},
					{
						"indexed": false,
						"internalType": "address",
						"name": "currentBidOwner",
						"type": "address"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "currentBidPrice",
						"type": "uint256"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "endAuction",
						"type": "uint256"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "bidCount",
						"type": "uint256"
					}
				],
				"name": "NewAuction",
				"type": "event"
			},
			{
				"anonymous": false,
				"inputs": [
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "auctionIndex",
						"type": "uint256"
					},
					{
						"indexed": true,
						"internalType": "address",
						"name": "_address",
						"type": "address"
					},
					{
						"indexed": false,
						"internalType": "address",
						"name": "from",
						"type": "address"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "tokenId",
						"type": "uint256"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "endAuction",
						"type": "uint256"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "newBid",
						"type": "uint256"
					}
				],
				"name": "NewBidOnAuction",
				"type": "event"
			},
			{
				"anonymous": false,
				"inputs": [
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "auctionIndex",
						"type": "uint256"
					},
					{
						"indexed": true,
						"internalType": "address",
						"name": "_address",
						"type": "address"
					},
					{
						"indexed": false,
						"internalType": "uint256",
						"name": "tokenId",
						"type": "uint256"
					},
					{
						"indexed": false,
						"internalType": "address",
						"name": "claimedBy",
						"type": "address"
					}
				],
				"name": "TokensClaimed",
				"type": "event"
			},
			{
				"inputs": [],
				"name": "_owner",
				"outputs": [
					{
						"internalType": "address payable",
						"name": "",
						"type": "address"
					}
				],
				"stateMutability": "view",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "_auctionIndex",
						"type": "uint256"
					}
				],
				"name": "bid",
				"outputs": [
					{
						"internalType": "bool",
						"name": "",
						"type": "bool"
					}
				],
				"stateMutability": "payable",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "_auctionIndex",
						"type": "uint256"
					}
				],
				"name": "claimNFT",
				"outputs": [],
				"stateMutability": "nonpayable",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "_auctionIndex",
						"type": "uint256"
					}
				],
				"name": "claimToken",
				"outputs": [],
				"stateMutability": "nonpayable",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "address",
						"name": "_addressNFTCollection",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "_nftId",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "_initialBid",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "_endAuction",
						"type": "uint256"
					}
				],
				"name": "createAuction",
				"outputs": [
					{
						"internalType": "uint256",
						"name": "",
						"type": "uint256"
					}
				],
				"stateMutability": "nonpayable",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "_auctionIndex",
						"type": "uint256"
					}
				],
				"name": "getAuction",
				"outputs": [
					{
						"components": [
							{
								"internalType": "uint256",
								"name": "index",
								"type": "uint256"
							},
							{
								"internalType": "address",
								"name": "addressNFTCollection",
								"type": "address"
							},
							{
								"internalType": "uint256",
								"name": "nftId",
								"type": "uint256"
							},
							{
								"internalType": "address",
								"name": "creator",
								"type": "address"
							},
							{
								"internalType": "address payable",
								"name": "currentBidOwner",
								"type": "address"
							},
							{
								"internalType": "uint256",
								"name": "currentBidPrice",
								"type": "uint256"
							},
							{
								"internalType": "uint256",
								"name": "endAuction",
								"type": "uint256"
							},
							{
								"internalType": "uint256",
								"name": "bidCount",
								"type": "uint256"
							}
						],
						"internalType": "struct BidNefti.Auction",
						"name": "",
						"type": "tuple"
					}
				],
				"stateMutability": "view",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "_auctionIndex",
						"type": "uint256"
					}
				],
				"name": "getCurrentBid",
				"outputs": [
					{
						"internalType": "uint256",
						"name": "",
						"type": "uint256"
					}
				],
				"stateMutability": "view",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "_auctionIndex",
						"type": "uint256"
					}
				],
				"name": "getCurrentBidOwner",
				"outputs": [
					{
						"internalType": "address",
						"name": "",
						"type": "address"
					}
				],
				"stateMutability": "view",
				"type": "function"
			},
			{
				"inputs": [],
				"name": "index",
				"outputs": [
					{
						"internalType": "uint256",
						"name": "",
						"type": "uint256"
					}
				],
				"stateMutability": "view",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "_auctionIndex",
						"type": "uint256"
					}
				],
				"name": "isOpen",
				"outputs": [
					{
						"internalType": "bool",
						"name": "",
						"type": "bool"
					}
				],
				"stateMutability": "view",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "_auctionIndex",
						"type": "uint256"
					}
				],
				"name": "refund",
				"outputs": [],
				"stateMutability": "nonpayable",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "address",
						"name": "account",
						"type": "address"
					}
				],
				"name": "replaceOwner",
				"outputs": [],
				"stateMutability": "nonpayable",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "address",
						"name": "contractAddress",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "fees",
						"type": "uint256"
					},
					{
						"internalType": "address payable",
						"name": "ownerAddress",
						"type": "address"
					}
				],
				"name": "setFeeContracts",
				"outputs": [],
				"stateMutability": "nonpayable",
				"type": "function"
			},
			{
				"inputs": [
					{
						"internalType": "uint256",
						"name": "newFeePercentage",
						"type": "uint256"
					}
				],
				"name": "setFeePercentage",
				"outputs": [],
				"stateMutability": "nonpayable",
				"type": "function"
			}
		],
		"devdoc": {
			"kind": "dev",
			"methods": {
				"bid(uint256)": {
					"params": {
						"_auctionIndex": "Index of auction"
					}
				},
				"getCurrentBid(uint256)": {
					"params": {
						"_auctionIndex": "Index of the auction"
					}
				},
				"getCurrentBidOwner(uint256)": {
					"params": {
						"_auctionIndex": "Index of the auction"
					}
				},
				"isOpen(uint256)": {
					"params": {
						"_auctionIndex": "Index of the auction"
					}
				},
				"refund(uint256)": {
					"params": {
						"_auctionIndex": "Index of the auction"
					}
				}
			},
			"version": 1
		},
		"userdoc": {
			"kind": "user",
			"methods": {
				"bid(uint256)": {
					"notice": "Place new bid on a specific auction"
				},
				"getCurrentBid(uint256)": {
					"notice": "Return the current highest bid price for a specific auction"
				},
				"getCurrentBidOwner(uint256)": {
					"notice": "Return the address of the current highest bider for a specific auction"
				},
				"isOpen(uint256)": {
					"notice": "Check if an auction is open"
				},
				"refund(uint256)": {
					"notice": "Function used by the creator of an auction to get his NFT back in case the auction is closed but there is no bider to make the NFT won't stay locked in the contract"
				}
			},
			"version": 1
		}
	},
	"settings": {
		"compilationTarget": {
			"contracts/BidNefti.sol": "BidNefti"
		},
		"evmVersion": "istanbul",
		"libraries": {},
		"metadata": {
			"bytecodeHash": "ipfs"
		},
		"optimizer": {
			"enabled": false,
			"runs": 200
		},
		"remappings": []
	},
	"sources": {
		"@openzeppelin/contracts/security/ReentrancyGuard.sol": {
			"keccak256": "0x0e9621f60b2faabe65549f7ed0f24e8853a45c1b7990d47e8160e523683f3935",
			"license": "MIT",
			"urls": [
				"bzz-raw://287a2f8d5814dd0f05f22b740f18ca8321acc21c9bd03a6cb2203ea626e2f3f2",
				"dweb:/ipfs/QmZRQv9iuwU817VuqkA2WweiaibKii69x9QxYBBEfbNEud"
			]
		},
		"@openzeppelin/contracts/token/ERC721/ERC721.sol": {
			"keccak256": "0x0b606994df12f0ce35f6d2f6dcdde7e55e6899cdef7e00f180980caa81e3844e",
			"license": "MIT",
			"urls": [
				"bzz-raw://4c827c981a552d1c76c96060e92f56b52bc20c6f9b4dbf911fe99ddbfb41f2ea",
				"dweb:/ipfs/QmW8xvJdzHrr8Ry34C7viBsgG2b8T1mL4BQWJ5CdfD9JLB"
			]
		},
		"@openzeppelin/contracts/token/ERC721/IERC721.sol": {
			"keccak256": "0xed6a749c5373af398105ce6ee3ac4763aa450ea7285d268c85d9eeca809cdb1f",
			"license": "MIT",
			"urls": [
				"bzz-raw://20a97f891d06f0fe91560ea1a142aaa26fdd22bed1b51606b7d48f670deeb50f",
				"dweb:/ipfs/QmTbCtZKChpaX5H2iRiTDMcSz29GSLCpTCDgJpcMR4wg8x"
			]
		},
		"@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol": {
			"keccak256": "0xa82b58eca1ee256be466e536706850163d2ec7821945abd6b4778cfb3bee37da",
			"license": "MIT",
			"urls": [
				"bzz-raw://6e75cf83beb757b8855791088546b8337e9d4684e169400c20d44a515353b708",
				"dweb:/ipfs/QmYvPafLfoquiDMEj7CKHtvbgHu7TJNPSVPSCjrtjV8HjV"
			]
		},
		"@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol": {
			"keccak256": "0x5c3501c1b70fcfc64417e9da5cc6a3597191baa354781e508e1e14cc0e50a038",
			"license": "MIT",
			"urls": [
				"bzz-raw://899c87a849a94c848818d0afede6961d2c87665af1dd23a5c983e78981a65691",
				"dweb:/ipfs/QmUeFDffQRDmX87FX3MRxN3bmpUxDTWpWLwPJzeAJ3yF6H"
			]
		},
		"@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol": {
			"keccak256": "0x75b829ff2f26c14355d1cba20e16fe7b29ca58eb5fef665ede48bc0f9c6c74b9",
			"license": "MIT",
			"urls": [
				"bzz-raw://a0a107160525724f9e1bbbab031defc2f298296dd9e331f16a6f7130cec32146",
				"dweb:/ipfs/QmemujxSd7gX8A9M8UwmNbz4Ms3U9FG9QfudUgxwvTmPWf"
			]
		},
		"@openzeppelin/contracts/utils/Address.sol": {
			"keccak256": "0xd6153ce99bcdcce22b124f755e72553295be6abcd63804cfdffceb188b8bef10",
			"license": "MIT",
			"urls": [
				"bzz-raw://35c47bece3c03caaa07fab37dd2bb3413bfbca20db7bd9895024390e0a469487",
				"dweb:/ipfs/QmPGWT2x3QHcKxqe6gRmAkdakhbaRgx3DLzcakHz5M4eXG"
			]
		},
		"@openzeppelin/contracts/utils/Context.sol": {
			"keccak256": "0xe2e337e6dde9ef6b680e07338c493ebea1b5fd09b43424112868e9cc1706bca7",
			"license": "MIT",
			"urls": [
				"bzz-raw://6df0ddf21ce9f58271bdfaa85cde98b200ef242a05a3f85c2bc10a8294800a92",
				"dweb:/ipfs/QmRK2Y5Yc6BK7tGKkgsgn3aJEQGi5aakeSPZvS65PV8Xp3"
			]
		},
		"@openzeppelin/contracts/utils/Counters.sol": {
			"keccak256": "0xf0018c2440fbe238dd3a8732fa8e17a0f9dce84d31451dc8a32f6d62b349c9f1",
			"license": "MIT",
			"urls": [
				"bzz-raw://59e1c62884d55b70f3ae5432b44bb3166ad71ae3acd19c57ab6ddc3c87c325ee",
				"dweb:/ipfs/QmezuXg5GK5oeA4F91EZhozBFekhq5TD966bHPH18cCqhu"
			]
		},
		"@openzeppelin/contracts/utils/Strings.sol": {
			"keccak256": "0xaf159a8b1923ad2a26d516089bceca9bdeaeacd04be50983ea00ba63070f08a3",
			"license": "MIT",
			"urls": [
				"bzz-raw://6f2cf1c531122bc7ca96b8c8db6a60deae60441e5223065e792553d4849b5638",
				"dweb:/ipfs/QmPBdJmBBABMDCfyDjCbdxgiqRavgiSL88SYPGibgbPas9"
			]
		},
		"@openzeppelin/contracts/utils/introspection/ERC165.sol": {
			"keccak256": "0xd10975de010d89fd1c78dc5e8a9a7e7f496198085c151648f20cba166b32582b",
			"license": "MIT",
			"urls": [
				"bzz-raw://fb0048dee081f6fffa5f74afc3fb328483c2a30504e94a0ddd2a5114d731ec4d",
				"dweb:/ipfs/QmZptt1nmYoA5SgjwnSgWqgUSDgm4q52Yos3xhnMv3MV43"
			]
		},
		"@openzeppelin/contracts/utils/introspection/IERC165.sol": {
			"keccak256": "0x447a5f3ddc18419d41ff92b3773fb86471b1db25773e07f877f548918a185bf1",
			"license": "MIT",
			"urls": [
				"bzz-raw://be161e54f24e5c6fae81a12db1a8ae87bc5ae1b0ddc805d82a1440a68455088f",
				"dweb:/ipfs/QmP7C3CHdY9urF4dEMb9wmsp1wMxHF6nhA2yQE5SKiPAdy"
			]
		},
		"contracts/BidNefti.sol": {
			"keccak256": "0x296c60a0b2404154c9292c45193bb89d7b1c4caffc20f8fc24d1d3f3ae5ad989",
			"urls": [
				"bzz-raw://b24d9043a3c3d8cc8cf9858c64619247fd3c325e780bcd7148ed7afa6ab890fc",
				"dweb:/ipfs/QmdWqTDvoN72opuFDwsMTeD4PJCTahmz5LubrFDta7UDUy"
			]
		}
	},
	"version": 1
}
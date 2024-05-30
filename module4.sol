// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Module4 is ERC20{

    address public OwnerWalletAddress;

    constructor() ERC20("Degen", "DGN"){
        OwnerWalletAddress = msg.sender;
    }

    string[] DegenItems = ["Selection 1: Solana Token", "Selection 2: BitCoin Token", "Selection 3: Etherium Token"];

    mapping (address Wallet => uint DGN) public TokenBalance;

    function Minting(address WalletAddress, uint256 DGN) public {
        require(WalletAddress == OwnerWalletAddress, "Only Owner can access");
        _mint(WalletAddress, DGN);
        TokenBalance[WalletAddress] += DGN;
    }

    function Burning(address WalletAddress, uint256 DGN) public{
        if(TokenBalance[WalletAddress] >= DGN){
            _burn(WalletAddress, DGN);
            TokenBalance[WalletAddress] -= DGN;
        }else{
            revert("Account doesnt have enough DGN Token to burn");
        }
    }

    function Transferring(address spender, address receiver, uint256 DGN)public{
        if(TokenBalance[spender] >= DGN){
            _approve(spender, receiver, DGN);
            _transfer(spender, receiver, DGN);

            TokenBalance[spender] -= DGN;
            TokenBalance[receiver] += DGN;
        }else{
            revert("Account doesnt have enough DGN Token to transfer");
        }
    }

    function DGNAvailableItem() public view returns(string memory, string memory, string memory){
        return (DegenItems[0], DegenItems[1], DegenItems[2]);
    }

    function Redeeming(address WalletAddress, uint256 choose) public{
        if(choose == 1){
            require(TokenBalance[WalletAddress] >= 1500, "Account doesnt have enough DGN Token" );
            TokenBalance[WalletAddress] -= 1500;
        }else if(choose == 2){
            require(TokenBalance[WalletAddress] >= 3000, "Account doesnt have enough DGN Token" );
            TokenBalance[WalletAddress] -= 3000;
        }else if(choose == 3){
            require(TokenBalance[WalletAddress] >= 5000, "Account doesnt have enough DGN Token" );
            TokenBalance[WalletAddress] -= 5000;
        }else{
            revert("Item not found, Choose 1, 2, 3 only!");
        }
        
    }

}

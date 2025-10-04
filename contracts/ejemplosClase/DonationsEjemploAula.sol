// SPDX-License-Identifier: MIT
pragma solidity > 0.8.0;

/**
 * @title Contrato Donations
 * @author FeliPerdao
 * @notice Este es un contrato con fines eductativos para recibir donaciones en ETH
 * @custom:security Este contrato es educativo y no debe ser usado con fines productivos
 */

contract Donations {
    
    ///@notice variable inmutable para almacenar la dirección que debe retirar las donacionese
    address immutable public BENEFICIARY; //immutable solo modifica variable en el constructor

    ///@notice mapping para almacenar el valor donado por el usuario
    address constant public BENEFICIARY2 = address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
    mapping (address  => uint256) public donations;
    
    event DonationReceived(address sender, uint256 amount);
    event WithdrawalPerformed(address BENEFICIEARY, uint256 amount);
    
    error TransactionFailed(bytes reason);
    error UnauthorizedWithdrawer(address caller, address BENEFICIEARY);

    modifier onlyBeneficiary() {
        if (msg.sender != BENEFICIARY) revert UnauthorizedWithdrawer(msg.sender, BENEFICIARY);
        _;
    }

    constructor(address _beneficiary) {
        BENEFICIARY = _beneficiary;
    }

    receive() external payable {
        donations[msg.sender] += msg.value;
        emit DonationReceived(msg.sender, msg.value);
    }

    fallback() external payable {
        donations[msg.sender] += msg.value;
        emit DonationReceived(msg.sender, msg.value);
    }

    function donate() external payable {
        donations[msg.sender] += msg.value;
        emit DonationReceived(msg.sender, msg.value);
    }

    function withdraw() external onlyBeneficiary returns(bytes memory data) {
        emit WithdrawalPerformed(BENEFICIARY, address(this).balance);
        data = _transferEth(BENEFICIARY, address(this).balance);
        return data;
    }

    function _transferEth(address to, uint256 amount) private returns (bytes memory) {
        (bool success, bytes memory data) = to.call{value:amount}("");
        if (!success) revert TransactionFailed("call failed");
        return data;
    }

}
/**
* Copyright CENTRE SECZ 2018
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is furnished to
* do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

pragma solidity ^0.4.24;

import './../Ownable.sol';

/**
 * @title Controller
 * @dev Generic implementation of the owner-controller-minter model.
 *
 */
contract Controller is Ownable {
    // controllers[controller]=minter
    // The controller manages a single minter address.
    mapping(address => address) public controllers;

    event ControllerConfigured(address indexed _controller, address indexed _minter);

    /**
     * @dev ensure that the caller is the controller of a non-zero minter address
     */
    modifier onlyController() {
        require(controllers[msg.sender] != address(0));
        _;
    }

    constructor() public {
    }

    // onlyOwner functions

    /**
     * @dev set the controller of a particular _minter
     * To disable the controller, call configureController(_controller, address(0))
     */
    function configureController(address _controller, address _minter) onlyOwner public returns (bool) {
        controllers[_controller] = _minter;
        emit ControllerConfigured(_controller, _minter);
        return true;
    }
}
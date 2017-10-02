## Summary
Everyone loves amusement parks(fun parks)!

This project is an implementation of using tokens/ether to pay for rides at an
amusement park using smart contracts using Solidity on the EVM.

The contracts allow managing new fun parks, managing customers, and allowing customers to enter and pay for attractions using ERC20 compatible FunParkTokens or ether.



## Contract Explanation
  * Owned.sol
    * Define modifiers and functions that allows control only by the owner of the contract
* Pausable.sol
    * Define modifiers and functions to pause and unpause a contract
* FunParkToken.sol
    * Define an ERC20 compatible fixed supply token, which can be used to pay for rides at the amusement park
* Hub.sol
    * Define functions to create and remove amusement parks
* AttractionHolder.sol
    * Define functions to add and remove attractions(rides) and update their price
* FunPark.sol
    * Is an AttractionHolder. Also, manages customer registration, and allows customers to enter attractions.


## Installation

```
$ npm install
```

## Running the application
Assuming a testrpc or some ethereum network is running locally. For testrpc, please set the gaslimit to a very high number like 999999999

```
$ ./node_modules/.bin/truffle migrate --reset
$ ./node_modules/.bin/webpack
```

Start the Web Server

```
$ chmod 755 startServer.js
$ ./startServer.js
```


## TODO
Complete the UI
  * Add a page for the main hub
     *  Add feature for adding/removing Amusement Parks
  * Add a page for the FunParks
     * Add feature to register and unregister customers
     * Add feature to add and update new attraction and their fees
     * Add feature to allow customers to enter attractions
     * Add feature to allow customers to retrieve refunds
     * Add feature to allow customers to receive tokens


## How to use the web application

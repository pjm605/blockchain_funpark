import React, { Component } from 'react';
// import { Link, Switch, Route } from 'react-router-dom';
import getWeb3 from './utils/getWeb3';

import HubJSON from "../build/contracts/Hub.json";

class App extends Component {
	constructor(props) {
		super(props)

		this.state = {
			web3: null,
			accounts: [],
			balance: null,
			instance: null
		}
	}

	componentWillMount() {
		getWeb3
		.then(results => {
			this.setState({
				web3: results.web3
			})

			this.instantiateContract()
		})
		.catch(() => {
			 console.log('Error finding web3.')
		})
	}

	instantiateContract() {
		const contract = require('truffle-contract');
    	const Hub = contract(HubJSON);

    	Hub.setProvider(this.state.web3.currentProvider);

    	this.state.web3.eth.getAccounts((error, accounts) => {
    		Hub.deployed().then((instance) => {
    			this.setState({
	    			accounts: accounts,
	    			instance: instance
	    		})
	    		console.log(accounts[0]);
	    		console.log(instance);
    			return this.state.web3.eth.getBalance(accounts[0]);

    		})
    		.then(balance => {
    			return this.setState({
    				balance: balance.toString(10)
    			})
    		})

    	})
	}

	render() {
		return (
			<h1>Hello</h1>
		)
	}
}

export default App
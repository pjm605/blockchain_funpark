import React, { Component } from 'react';
import { Link, Switch, Route } from 'react-router-dom';
import getWeb3 from './utils/getWeb3';

import HubJSON from "../build/contracts/Hub.json";
import FunParkJSON from "../build/contracts/FunPark.json";

import AccountInfo from "./components/AccountInfo.js";
import FunParkInfo from "./components/FunParkInfo.js";
import Hub from "./components/Hub/Hub.js";
import FunPark from "./components/FunPark/FunPark.js";

class App extends Component {
	constructor(props) {
		super(props)

		this.state = {
			web3: null,
			accounts: [],
			currentAccount: null,
			balance: null,
			hubInstance: null,
			hubOwner: null,
			FunParkABI: null,
			funParkInstance: null,
			funParks: [],
			currFunPark: null,
			currFunParkOwner: null,
			registeredCustomers: []
		}

		this.setAccount = this.setAccount.bind(this);
		this.setFunPark = this.setFunPark.bind(this);
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
    	const HubContract = contract(HubJSON);
    	this.state.FunParkABI = contract(FunParkJSON);

    	HubContract.setProvider(this.state.web3.currentProvider);
    	this.state.FunParkABI.setProvider(this.state.web3.currentProvider);

    	this.state.web3.eth.getAccounts((error, accounts) => {
    		HubContract.deployed().then((instance) => {
    			this.setState({
	    			accounts: accounts,
	    			currentAccount: accounts[0],
	    			hubInstance: instance,
	    			hubOwner: accounts[0]
	    		})

   
    			this.watchFunParkCreated();

    			return this.state.web3.eth.getBalance(accounts[0]);
    		})
    		.then(balance => {
    			return this.setState({
    				balance: balance.toString(10)
    			})
    		})

    	})
	}

	setAccount(account) {
		this.state.web3.eth.getBalance(account, (err, balance) => {
			if (err) {
				console.log("Error getting balance from setAccount function", err);
			} else {
				this.setState({
					currentAccount: account,
					balance: balance.toString(10)
				})
			}
		})
	}

	setFunPark (address) {
		this.state.hubInstance.isFunPark(address)
		.then(result => {
			if(!result) {
				throw "Selected Funpark not exist"
			}

			var funParkInstance = this.state.FunParkABI.at(address);
			this.setState({
				funParkInstance: funParkInstance
			})

			return funParkInstance.getOwner()
		})
		.then(funParkOwner => {
			this.setState({
				currFunPark: address,
				currFunParkOwner: funParkOwner
			})

			this.watchRegisterCustomer();
		})
		.catch(err => {
			console.log("Error setting funpark", err);
			alert(err);
		})
	}

	watchFunParkCreated () {
		this.state.hubInstance.LogFunParkCreated({}, {fromBlock: 0})
		.watch((err, newFunPark) => {
			if (err) {
				console.log("Error watching LogFunParkCreated", err);
			} else {
				let funParks = this.state.funParks;
				funParks.push(newFunPark);

				this.setState({
					funParks: funParks
				})
			}
		})
	}

	watchRegisterCustomer () {
		this.state.funParkInstance.LogRegisterCustomer({}, {fromBlock: 0})
		.watch((err, newCusotmer) => {
			if (err) {
			} else {
				let registeredCustomers = this.state.registeredCustomers;
				registeredCustomers.push(newCusotmer);

				this.setState({
					registeredCustomers: registeredCustomers
				})
			}
		})
	}


	render() {
		return (
			<div>
				<div className="container-fluid">
					<AccountInfo
				        accounts={this.state.accounts} 
				        currentAccount={this.state.currentAccount} 
				        balance={this.state.balance} 
				        setAccount={this.setAccount} />

					<FunParkInfo
				        funParks={this.state.funParks} 
				        setFunPark={this.setFunPark}
				        currFunPark={this.state.currFunPark} />

				   	<div className="row">
						<nav className="navbar navbar-inverse">
							<ul className="nav navbar-nav">
								<li className="nav-item"><Link to="/">Hub</Link></li>
								<li className="nav-item"><Link to="/funpark">FunPark</Link></li>
							</ul>
						</nav>
					</div>
				</div>
				<div className="container">
					<div className="row">
						<Switch>
							<Route 
					            exact path='/' 
					            render={(props) => <Hub {...props}  
					            hubInstance={this.state.hubInstance}
					            hubOwner={this.state.hubOwner} />} />
					    	<Route 
					            exact path='/funpark' 
					            render={(props) => <FunPark {...props}  
					            funParkInstance={this.state.funParkInstance}
					            currFunParkOwner={this.state.currFunParkOwner}
					            registeredCustomers={this.state.registeredCustomers} />} />
						</Switch>
					</div>
				</div>
			</div>
		)
	}
}

export default App
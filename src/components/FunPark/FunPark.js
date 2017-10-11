import React, { Component } from 'react';
import CustomerRegistration from "./CustomerRegistration.js";
import DisplayRegisteredCustomers from "./DisplayRegisteredCustomers.js";

class FunPark extends Component
{
	constructor (props) {
		super(props)

		this.state = {
		}

		this.registerCustomer = this.registerCustomer.bind(this);
		this.removeCustomer = this.removeCustomer.bind(this);
	}


	registerCustomer (customer) {
		console.log("from register", customer)
		this.props.funParkInstance.registerCustomer(customer, {from: this.props.currFunParkOwner, gas: 9999999})
		.then(result => {
			console.log("Successfully register new customer");
		})
		.catch(err => {
			console.log("Error register new customer", err)
		})
	}

	removeCustomer (customer) {
		this.props.funParkInstance.removeCustomer(customer, {from: this.props.currFunParkOwner, gas: 9999999})
		.then(result => {
			console.log("Successfully removed customer");
		})
		.catch(err => {
			console.log("Error removing customer", err)
		})
	}

	displayCollectedFeeTotal () {

	}

	withdrawBalances() {

	}

	render () {
		return (
			<div>
				<DisplayRegisteredCustomers 
					registeredCustomers={this.props.registeredCustomers} />

				<CustomerRegistration
					registerCustomer={this.registerCustomer}
					removeCustomer={this.removeCustomer} />
			</div>
		)
	}
	
}
export default FunPark
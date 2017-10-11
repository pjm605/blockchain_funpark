import React, { Component } from 'react';
import CreateFunPark from "./CreateFunPark.js";


class Hub extends Component
{
	constructor (props) {
		super(props)
		this.state = {
		}
		this.createNewFunPark = this.createNewFunPark.bind(this);
	}

	createNewFunPark(owner) {

	    this.props.hubInstance.createNewFunPark(owner, {from: this.props.hubOwner, gas: 3000000})
	    .then(result => {
	      console.log("Successfully create new FunPark");
	    })
	    .catch(err => {
	      console.log("Error creating new FunPark", err)
	      alert (err);
	    })
	}

	render () {
		return (
			<div>
				<CreateFunPark 
					createNewFunPark={this.createNewFunPark} />
			</div>
		)
	}
	
}
export default Hub
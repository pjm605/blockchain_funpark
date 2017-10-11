import React, { Component } from 'react';

class CustomerRegistration extends Component
{
	constructor (props) {
		super(props)

		this.state = {
			registerCustomer: "",
			removeCustomer: ""
		}

		this.handleInputChange = this.handleInputChange.bind(this);
		this.handleRegister = this.handleRegister.bind(this);
		this.handleRemove = this.handleRemove.bind(this);
	}
	
	handleInputChange (event) {
		const name = event.target.name;
		this.setState({
			[name]: event.target.value
		});
	}
	handleRegister (event) {
		event.preventDefault();
		this.props.registerCustomer(this.state.registerCustomer);

		this.setState({
			registerCustomer: ""
		})
	}

	handleRemove (event) {
		event.preventDefault();
		
		this.props.removeCustomer(this.state.removeCustomer);

		this.setState({
			removeCustomer: ""
		})
	}
	render () {
		return (
			<div className="row">
		        <div className="col-md-12">
			        <div className="row">
			        	<div className="col-md-6">
			        		<h3>Register New Customer</h3>
				          	<form role="form" onSubmit={this.handleRegister}>
					          	<div className="form-group float-label-control">
					          		<label>Customer</label>
					          		<input name="registerCustomer" value={this.state.registerCustomer} onChange={this.handleInputChange} required/>
					          	</div>
				            <button type="submit" className="btn btn-primary"> Register </button>
				        	</form>
				        </div>
				        <div className="col-md-6">
				        	<h3>Remove Customer</h3>
				          	<form role="form" onSubmit={this.handleRemove}>
					          	<div className="form-group float-label-control">
					          		<label>Customer</label>
					          		<input name="removeCustomer" value={this.state.removeCustomer} onChange={this.removeCustomer} required/>
					          	</div>
				            <button type="submit" className="btn btn-primary"> Register </button>
				        	</form>
				        </div>
			        </div>
		        </div>
		    </div>
		)
	}
}
export default CustomerRegistration
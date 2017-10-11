import React, { Component } from 'react'
import DisplayFunParks from "./DisplayFunParks.js";

class FunParkInfo extends Component
{
	constructor (props) {
		super(props)
		this.state = {
			selctedFunPark: ""
		}
		this.handleInputChange = this.handleInputChange.bind(this);
		this.handleSubmit = this.handleSubmit.bind(this);
	}
	handleInputChange (event) {
		const name = event.target.name;
		this.setState({
			[name]: event.target.value
		});
	}
	handleSubmit (event) {
		event.preventDefault();
		
		this.props.setFunPark(this.state.selctedFunPark);
		this.setState({
			selctedFunPark: ""
		})
	}
	render () {
		let isCurrentFunPark = this.props.currFunPark ? (
			<div>
				<h4>Current FunPark:</h4> 
				<p>{this.props.currFunPark}</p>
			</div>
		) : (<div><h4>Please Choose FunPark</h4></div>)

		return (
			<div className="row">
				<div className="col-md-12">
					<DisplayFunParks
						funParks={this.props.funParks} />
					{isCurrentFunPark}
					
					<form role="form" onSubmit={this.handleSubmit}>
						<div className="form-group float-label-control">
			          		<label>FunPark: </label>
			          		<input name="selctedFunPark" placeholder="Choose FunPark" value={this.state.selctedFunPark} onChange={this.handleInputChange} required/>
			          	</div>
			          	<button type="submit" className="btn btn-primary"> Select </button>
					</form>
				</div>
			</div>
		)
	}
}
export default FunParkInfo
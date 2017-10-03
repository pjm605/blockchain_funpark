import React, { Component } from 'react';

class CreateFunPark extends Component
{
	constructor (props) {
		super(props)
		this.state = {
			newFunParkOwner: ""
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
		
		this.props.createNewFunPark(this.state.newFunParkOwner);

		this.setState({
			newFunParkOwner: ""
		})
	}
	render () {
		return (
			<div className="row">
		        <div className="col-md-12">
		          <h3>Create New FunPark</h3>
		          <form role="form" onSubmit={this.handleSubmit}>
		          	<div className="form-group float-label-control">
		          		<label>Owner</label>
		          		<input name="newFunParkOwner" value={this.state.newFunParkOwner} onChange={this.handleInputChange} required/>
		          	</div>
		            <button type="submit" className="btn btn-primary"> Create </button>
		          </form>
		        </div>
		    </div>
		)
	}
}
export default CreateFunPark
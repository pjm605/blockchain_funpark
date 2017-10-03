import React, { Component } from 'react';

class DisplayFunParks extends Component
{
	constructor (props) {
		super(props);
	}
	render () {

		const funParks = this.props.funParks.map((result) => {
			return (
				<tr className="collection" key={result.args.newFunPark}>
					<td>{result.args.newFunPark}</td>
					<td>{result.args.newFunParkOwner}</td>
				</tr>
			)
		});

		return (
			<div className="row">
				<div className="col-md-12">
					<h4>Created FunParks</h4>
					<table className="table table-responsive table-striped table-bordered table-sm">
						<thead>
							<tr>
								<th>FunPark Address</th>
								<th>FunPark Owner</th>
							</tr>
						</thead>
						<tbody>
							{funParks}
						</tbody>
					</table>
				</div>
		    </div>
		)
	}
}
export default DisplayFunParks
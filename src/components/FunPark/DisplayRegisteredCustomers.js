import React, { Component } from 'react';

class DisplayRegisteredCustomers extends Component
{
	constructor (props) {
		super(props);
	}
	render () {

		const registeredCustomers = this.props.registeredCustomers.map((result) => {
			return (
				<tr className="collection" key={result.args.customer}>
					<td>{result.args.customer}</td>
				</tr>
			)
		});

		return (
			<div className="row">
				<div className="col-md-12">
					<h4>Registered Customers</h4>
					<table className="table table-responsive table-striped table-bordered table-sm">
						<thead>
							<tr>
								<th>Customers</th>
							</tr>
						</thead>
						<tbody>
							{registeredCustomers}
						</tbody>
					</table>
				</div>
		    </div>
		)
	}
}
export default DisplayRegisteredCustomers
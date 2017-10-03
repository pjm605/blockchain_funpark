import React, { Component } from 'react';

class AccountInfo extends Component
{
	constructor (props) {
		super(props);

		this.onChangeAccount = this.onChangeAccount.bind(this);
	}

	getAccounts() {
		var accounts = this.props.accounts.map(account => {
			return (
				<option key={account}>
					{account}
				</option>
			)
		});
		return accounts;
	}

	onChangeAccount(event) {
		this.props.setAccount(event.target.value);
	}
	
	render () {
		var accounts;
		if (this.props.accounts) {
			accounts = this.getAccounts();
		}
		return (
			<div className="row spadding">
				<div className="col-md-12">				
					<p className="oneline display"><b>Available Accounts:</b>  
					<select id="newAccountInput" onChange={this.onChangeAccount}>
						{accounts}
					</select>
					</p>
					<p className="oneline display spadding">Account Address: {this.props.currentAccount} Account Balance: {this.props.balance}</p> 
				</div>
			</div>
		)
	}
}
export default AccountInfo
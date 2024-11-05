var table = []
var selectedWindow = "none"
var data_graph = {}
var isLoggingOut = false
var useSound = false

window.addEventListener('message', function(event) {
	if (event.data.UseSound) {
		useSound = event.data.UseSound;
	  }
	switch (event.data.action) {
		case 'loading_data':
			if (selectedWindow == "none") {
				$('#menu').html(`
					<div class="d-flex justify-content-center flex-column align-items-center">
						<span class="load"></span>
						<br>
						<div class="ldata-txt">Aan het laden...</div>
					</div>
				`);
				$("#menu").fadeIn();
				$(".main_card").fadeIn();
				selectedWindow = "loading_data";
			}
			break
		case 'bankmenu':
			if (selectedWindow == "loading_data") {
				if(useSound) {
					var popup_sound = new Audio('popup.mp3');
					popup_sound.volume = 0.2;
					popup_sound.play();
				}
				$("#menu").fadeOut();

				setTimeout(function(){
					if (event.data.playerSex == "m") {
						avatar = `<img src="img/avatar_male.png" class="avatar">`;
					} else {
						avatar = `<img src="img/avatar_female.png" class="avatar">`;
					}
					

					$('#menu').html(`
						<div class="col-md-2 d-flex flex-column sidebar-s">
							<img src="img/logo.png" class="logo">
							<hr>
							<span class="sidebar-title">Personal</span>
							<div id="sidebar"></div>
							<p class="sidebar-item mt-auto logout"><i class="fas fa-sign-out-alt"></i></i> <span class="ms-1">Uitloggen</span></p>
						</div>
						<div class="col-md-10 tab-s">
							<div class="d-flex justify-content-between align-items-center">
								<span class="selected-page"><span id="page-title">Overzicht</span></span>
								<div>
									<span class="username align-middle">
										<span id="playerName"></span> <span id="avatar">${avatar}</span>
									</span>
									<div class="wallet-div">
										<span>Wallet: <span id="wallet_money"></span> EUR</span>
									</div>
								</div>
							</div>
							<hr>
							<div class="row" id="page_info"></div>
						</div>
					`);
					$("#menu").fadeIn();
					overview_page_function(event);
				}, 400);
				
			}
			break
		case 'updatevalue':
			$("#playerBankMoney").html('');
			$("#playerBankMoney").html(event.data.playerBankMoney.toLocaleString());
			$("#wallet_money").html(event.data.walletMoney.toLocaleString());
			break
		case 'updateiban':
			$("#playerIBAN").html('');
			$("#playerIBAN").html(event.data.iban);
			break
		case 'overview_page':
			overview_page_function(event);
			break
		case 'transactions_page':
			for(var i=0; i<table.length; i++) {
				table[i].destroy();
				table.splice(i, 1);
			}

			$('#page-title').html('TRANSACTIES');

			if (event.data.isInSociety){
				society = `<span class="sidebar-title mt-5">Society</span>
						   <p class="sidebar-item mt-2" id="society_page"><i class="bi bi-grid-1x2-fill"></i> <span class="ms-1">Overzicht</span></p>
						   <p class="sidebar-item" id="society_transactions"><i class="fas fa-exchange-alt"></i> <span class="ms-1">Transacties</span></p>`;
			} else {
				society = '';
			}

			$('#sidebar').html(`
				<p class="sidebar-item mt-2" id="overview_page"><i class="bi bi-grid-1x2-fill"></i> <span class="ms-1">Overzicht</span></p>
				<p class="sidebar-item selected" id="transactions_page"><i class="fas fa-exchange-alt"></i> <span class="ms-1">Transacties</span></p>
				<p class="sidebar-item mt-2" id="settings_page"><i class="fas fa-cog"></i> <span class="ms-1">Instellingen</span></p>
				${society}
			`);

			var row = '';
			var num = event.data.db.length;
			var numOfTransactions = 0

			for(var i = 0; i < num; i++) {
				numOfTransactions++
				var db = event.data.db[i];

				// Received
				if (db.type == 'transfer' && db.receiver_identifier == event.data.identifier) {
					var name = db.sender_name;
					if (name.length > 15){
						name = name.substring(0, 15)+"..."
					}
					icon = '<td class="align-middle"><span class="transactions-action"><i class="bi bi-download"></i></span></td>';
					data = `<td class="align-middle fw500">
								From <span class="transactions-name">${name}</span>
								<div class="mtm3125">Received</div>
							</td>`;
					amount = `<td class="align-middle fw500 transactions-received text-center">+ ${db.value.toLocaleString()} EUR</td>`;
				// Sent
				} else if (db.type == 'transfer' && db.sender_identifier == event.data.identifier) {
					var name = db.receiver_name;
					if (name.length > 15){
						name = name.substring(0, 15)+"..."
					}
					icon = '<td class="align-middle"><span class="transactions-action"><i class="bi bi-upload"></i></span></td>';
					data = `<td class="align-middle fw500">
								To <span class="transactions-name">${name}</span>
								<div class="mtm3125">Sent</div>
							</td>`;
					amount = `<td class="align-middle fw500 text-center">- ${db.value.toLocaleString()} EUR</td>`;
				// Deposited
				} else if (db.type == 'deposit') {
					var name = db.receiver_name;
					if (name.length > 15){
						name = name.substring(0, 15)+"..."
					}
					icon = '<td class="align-middle"><span class="transactions-action"><i class="bi bi-download"></i></span></td>';
					data = `<td class="align-middle fw500">
								Into <span class="transactions-name">${name}</span>
								<div class="mtm3125">Storten</div>
							</td>`;
					amount = `<td class="align-middle fw500 transactions-received text-center">+ ${db.value.toLocaleString()} EUR</td>`;
				// Withdrawn
				} else if (db.type == 'withdraw') {
					var name = db.sender_name;
					if (name.length > 15){
						name = name.substring(0, 15)+"..."
					}
					icon = '<td class="align-middle"><span class="transactions-action"><i class="bi bi-upload"></i></span></td>';
					data = `<td class="align-middle fw500">
								From <span class="transactions-name">${name}</span>
								<div class="mtm3125">Afhalen</div>
							</td>`;
					amount = `<td class="align-middle fw500 text-center">- ${db.value.toLocaleString()} EUR</td>`;
				}

				row += `
					<tr>
						${icon}
						${data}
						<td class="align-middle fw500">${db.date}</td>
						${amount}
					</tr>
				`;
			}

			$('#page_info').removeClass('row');

			$('#page_info').html(`
				<div class="row mb-3">
					<div class="col col-md-3 pr05">
						<div class="card stats-title">
							<div class="card-body text-center">
								<h6 class="card-title">TRANSACTIES</h6>
								<p class="card-text fw125" id="totalInvoices">${numOfTransactions}</p>
							</div>
						</div>
					</div>
					<div class="col col-md-3 pr05 pl05">
						<div class="card stats-title">
							<div class="card-body text-center">
								<h6 class="card-title">INKOMEN</h6>
								<p class="card-text fw125" id="totalIncome">${event.data.graph_values[7].toLocaleString()}€</p>
							</div>
						</div>
					</div>
					<div class="col col-md-3 pr05 pl05">
						<div class="card stats-title">
							<div class="card-body text-center">
								<h6 class="card-title">UITGAVEN</h6>
								<p class="card-text fw125" id="unpaidInvoices">${event.data.graph_values[8].toLocaleString()}€</p>
							</div>
						</div>
					</div>
					<div class="col col-md-3 pl05">
						<div class="card stats-title">
							<div class="card-body text-center">
								<h6 class="card-title">INKOMSTEN</h6>
								<p class="card-text fw125" id="awaitedIncome">${event.data.graph_values[9].toLocaleString()}€</p>
							</div>
						</div>
					</div>
				</div>
				<table id="transactionsTable">
					<tbody id="transactionsData">
					</tbody>
				</table>
			`);

			$('#transactionsData').html(row);

			var table_id = document.getElementById('transactionsTable');
			table.push(new simpleDatatables.DataTable(table_id, {
				perPageSelect: false,
				perPage: 5,
			}));

			break
		case 'society_transactions':
			for(var i=0; i<table.length; i++) {
				table[i].destroy();
				table.splice(i, 1);
			}

			$('#page-title').html('Transactions');

			if (event.data.isInSociety){
				society = `<span class="sidebar-title mt-5">Society</span>
						   <p class="sidebar-item mt-2" id="society_page"><i class="bi bi-grid-1x2-fill"></i> <span class="ms-1">Overzicht</span></p>
						   <p class="sidebar-item selected" id="society_transactions"><i class="fas fa-exchange-alt"></i> <span class="ms-1">Transactions</span></p>`;
			} else {
				society = '';
			}

			$('#sidebar').html(`
				<p class="sidebar-item mt-2" id="overview_page"><i class="bi bi-grid-1x2-fill"></i> <span class="ms-1">Overzicht</span></p>
				<p class="sidebar-item" id="transactions_page"><i class="fas fa-exchange-alt"></i> <span class="ms-1">Transacties</span></p>
				<p class="sidebar-item mt-2" id="settings_page"><i class="fas fa-cog"></i> <span class="ms-1">Instellingen</span></p>
				${society}
			`);

			var row = '';
			var num = event.data.db.length;
			var numOfTransactions = 0

			for(var i = 0; i < num; i++) {
				numOfTransactions++
				var db = event.data.db[i];

				// Received
				if (db.type == 'transfer' && db.receiver_identifier == event.data.identifier) {
					var name = db.sender_name;
					if (name.length > 15){
						name = name.substring(0, 15)+"..."
					}
					icon = '<td class="align-middle"><span class="transactions-action"><i class="bi bi-download"></i></span></td>';
					data = `<td class="align-middle transactions-name-div">
								From <span class="transactions-name">${name}</span>
								<div class="mtm3125">Received</div>
							</td>`;
					amount = `<td class="align-middle fw500 transactions-received text-center">+ ${db.value.toLocaleString()} EUR</td>`;
				// Sent
				} else if (db.type == 'transfer' && db.sender_identifier == event.data.identifier) {
					var name = db.receiver_name;
					if (name.length > 15){
						name = name.substring(0, 15)+"..."
					}
					icon = '<td class="align-middle"><span class="transactions-action"><i class="bi bi-upload"></i></span></td>';
					data = `<td class="align-middle transactions-name-div">
								To <span class="transactions-name">${name}</span>
								<div class="mtm3125">Sent</div>
							</td>`;
					amount = `<td class="align-middle fw500 text-center">- ${db.value.toLocaleString()} EUR</td>`;
				// Deposited
				} else if (db.type == 'deposit') {
					var name = db.receiver_name;
					if (name.length > 15){
						name = name.substring(0, 15)+"..."
					}
					icon = '<td class="align-middle"><span class="transactions-action"><i class="bi bi-download"></i></span></td>';
					data = `<td class="align-middle transactions-name-div">
								Into <span class="transactions-name">${name}</span>
								<div class="mtm3125">Deposited</div>
							</td>`;
					amount = `<td class="align-middle fw500 transactions-received text-center">+ ${db.value.toLocaleString()} EUR</td>`;
				// Withdrawn
				} else if (db.type == 'withdraw') {
					var name = db.sender_name;
					if (name.length > 15){
						name = name.substring(0, 15)+"..."
					}
					icon = '<td class="align-middle"><span class="transactions-action"><i class="bi bi-upload"></i></span></td>';
					data = `<td class="align-middle transactions-name-div">
								From <span class="transactions-name">${name}</span>
								<div class="mtm3125">Withdrawn</div>
							</td>`;
					amount = `<td class="align-middle fw500 text-center">- ${db.value.toLocaleString()} EUR</td>`;
				}

				row += `
					<tr>
						${icon}
						${data}
						<td class="align-middle fw500">${db.date}</td>
						${amount}
					</tr>
				`;
			}

			$('#page_info').removeClass('row');

			$('#page_info').html(`
				<div class="row mb-3">
					<div class="col col-md-3 pr05">
						<div class="card stats-title">
							<div class="card-body text-center">
								<h6 class="card-title">TRANSACTIES</h6>
								<p class="card-text fw125" id="totalInvoices">${numOfTransactions}</p>
							</div>
						</div>
					</div>
					<div class="col col-md-3 pr05 pl05">
						<div class="card stats-title">
							<div class="card-body text-center">
								<h6 class="card-title">INKOMEN</h6>
								<p class="card-text fw125" id="totalIncome">${event.data.graph_values[7].toLocaleString()}€</p>
							</div>
						</div>
					</div>
					<div class="col col-md-3 pr05 pl05">
						<div class="card stats-title">
							<div class="card-body text-center">
								<h6 class="card-title">UITGAVEN</h6>
								<p class="card-text fw125" id="unpaidInvoices">${event.data.graph_values[8].toLocaleString()}€</p>
							</div>
						</div>
					</div>
					<div class="col col-md-3 pl05">
						<div class="card stats-title">
							<div class="card-body text-center">
								<h6 class="card-title">INKOMSTEN</h6>
								<p class="card-text fw125" id="awaitedIncome">${event.data.graph_values[9].toLocaleString()}€</p>
							</div>
						</div>
					</div>
				</div>
				<table id="transactionsTable">
					<tbody id="transactionsData">
					</tbody>
				</table>
			`);

			$('#transactionsData').html(row);

			var table_id = document.getElementById('transactionsTable');
			table.push(new simpleDatatables.DataTable(table_id, {
				perPageSelect: false,
				perPage: 5,
			}));


			break
		case 'society_page':
			society_page_function(event);
			break
		case 'settings_page':
			settings_page_function(event);
			break
		case 'atm':
			atm_numpad(event.data.pin);

			$(".atm_card").fadeIn();
			selectedWindow = "atm";
			break
	}
});

// Overview
$(document).on('click', "#overview_page", function() {
	$.post('https://okokBanking/action', JSON.stringify({
		action: "overview_page",
	}));
});

// Transactions
$(document).on('click', "#transactions_page", function() {
	$.post('https://okokBanking/action', JSON.stringify({
		action: "transactions_page",
	}));
});

$(document).on('click', "#view_all_transactions", function() {
	$.post('https://okokBanking/action', JSON.stringify({
		action: "transactions_page",
	}));
});

$(document).on('click', "#view_all_transactions_society", function() {
	$.post('https://okokBanking/action', JSON.stringify({
		action: "society_transactions",
	}));
});

// Society
$(document).on('click', "#society_page", function() {
	$.post('https://okokBanking/action', JSON.stringify({
		action: "society_page",
	}));
});

// Society transactions
$(document).on('click', "#society_transactions", function() {
	$.post('https://okokBanking/action', JSON.stringify({
		action: "society_transactions",
	}));
});

// Settings
$(document).on('click', "#settings_page", function() {
	$.post('https://okokBanking/action', JSON.stringify({
		action: "settings_page",
	}));
});

// End Pages

$(document).on('click', ".depositMoneyModal", function() {
	var modalId = $('#depositModal');
	var depositModal = new bootstrap.Modal(modalId);
	depositModal.show()
});

$(document).on('click', ".withdrawMoneyModal", function() {
	var modalId = $('#withdrawModal');
	var depositModal = new bootstrap.Modal(modalId);
	depositModal.show()
});

$(document).on('click', ".transferMoneyModal", function() {
	var modalId = $('#transferModal');
	var depositModal = new bootstrap.Modal(modalId);
	depositModal.show()
});

// aqui
$(document).on('click', "#buy_new_cc", function() {
	$.post('https://okokBanking/action', JSON.stringify({
		action: "buy_new_cc",
	}));
});

$(document).on('click', ".logout", function() {
	if(!isLoggingOut) {
		isLoggingOut = true
		logout_page()
	}
});

// Close ESC Key
$(document).ready(function() {
	document.onkeyup = function(data) {
		if (data.which == 27) {
			switch (selectedWindow) {
				case 'bankmenu':
					if(!isLoggingOut) {
						isLoggingOut = true
						logout_page()
					}
					break
				case 'societies':
					if(!isLoggingOut) {
						isLoggingOut = true
						logout_page()
					}
					break
				case 'settings':
					if(!isLoggingOut) {
						isLoggingOut = true
						logout_page()
					}
					break
				case 'atm':
					$(".atm_card").fadeOut();
					$.post('https://okokBanking/action', JSON.stringify({
						action: "close",
					}));
					selectedWindow = "none";

					break
			}
		}
	};
});

$(document).on('click', '#depositMoney', function() {
	var deposit_value = $('#deposit_value').val();

	deposit_value = Math.trunc( deposit_value );

	$.post('https://okokBanking/action', JSON.stringify({
		action: 'deposit',
		value: deposit_value,
		window: selectedWindow,
	}));
	$('#deposit_value').val('');
	document.getElementById('depositMoney').disabled = true;
})

$(document).on('click', '#withdrawMoney', function() {
	var withdraw_value = $('#withdraw_value').val();

	withdraw_value = Math.trunc( withdraw_value );

	$.post('https://okokBanking/action', JSON.stringify({
		action: 'withdraw',
		value: withdraw_value,
		window: selectedWindow,
	}));
	$('#withdraw_value').val('');
	document.getElementById('withdrawMoney').disabled = true;
})

$(document).on('click', "#transferMoney", function() {
	var transfer_value = $('#transfer_value').val();
	var iban_value = $('#transfer_iban').val();

	$.post('https://okokBanking/action', JSON.stringify({
		action: 'transfer',
		value: transfer_value,
		iban: iban_value,
		window: selectedWindow,
	}));
	$('#transfer_value').val('');
	$('#transfer_iban').val('');
	document.getElementById('transferMoney').disabled = true;
});

// Change iban
$(document).on('click', "#change_iban", function() {
	var new_iban = $('#new_iban').val();

	$.post('https://okokBanking/action', JSON.stringify({
		action: "change_iban",
		iban: new_iban,
	}));
	$('#new_iban').val('');
	document.getElementById('change_iban').disabled = true;
});

// Change pin
$(document).on('click', "#change_pin", function() {
	var new_pin = $('#new_pin').val();

	$.post('https://okokBanking/action', JSON.stringify({
		action: "change_pin",
		pin: new_pin,
	}));
	$('#new_pin').val('');
	document.getElementById('change_pin').disabled = true;
});

$(document).on('click', ".close-atm", function() {
	if(useSound) {
		var popuprev_sound = new Audio('popupreverse.mp3');
		popuprev_sound.volume = 0.2;
		popuprev_sound.play();
	}
	$('.atm_card').fadeOut();
	$.post('https://okokBanking/action', JSON.stringify({
		action: "close",
	}));
	selectedWindow = "none";
})

function checkIfEmpty() {
	// Deposit
	if (document.getElementById("deposit_value").value === "") {
		document.getElementById('depositMoney').disabled = true;
	} else { 
	document.getElementById('depositMoney').disabled = false;
	}

	// Withdraw
	if(document.getElementById("withdraw_value").value === "") {
		document.getElementById('withdrawMoney').disabled = true;
	} else { 
	document.getElementById('withdrawMoney').disabled = false;
	}

	// Transfer
	if(document.getElementById("transfer_value").value === "" || document.getElementById("transfer_iban").value === "") {
		document.getElementById('transferMoney').disabled = true;
	} else { 
	document.getElementById('transferMoney').disabled = false;
	}
}

function checkIfEmptySettings() {
	 // New pin
	if(document.getElementById("new_pin").value === "") {
		document.getElementById('change_pin').disabled = true;
	} else { 
	document.getElementById('change_pin').disabled = false;
	}

	// New iban
	if(document.getElementById("new_iban").value === "") {
		document.getElementById('change_iban').disabled = true;
	} else { 
	document.getElementById('change_iban').disabled = false;
	}
}

function overview_page_function(event) {
	if(event.data.isUpdate && selectedWindow == "bankmenu" || !event.data.isUpdate){
		for(var i=0; i<table.length; i++) {
			table[i].destroy();
			table.splice(i, 1);
		}

		$('#page-title').html('Overzicht');

		if (event.data.isInSociety){
			society = `<span class="sidebar-title mt-5">Society</span>
					   <p class="sidebar-item mt-2" id="society_page"><i class="bi bi-grid-1x2-fill"></i> <span class="ms-1">Overzicht</span></p>
					   <p class="sidebar-item" id="society_transactions"><i class="fas fa-exchange-alt"></i> <span class="ms-1">Transacties</span></p>`;
		} else {
			society = '';
		}

		$('#sidebar').html(`
			<p class="sidebar-item mt-2 selected" id="overview_page"><i class="bi bi-grid-1x2-fill"></i> <span class="ms-1">Overzicht</span></p>
			<p class="sidebar-item" id="transactions_page"><i class="fas fa-exchange-alt"></i> <span class="ms-1">Transacties</span></p>
			<p class="sidebar-item mt-2" id="settings_page"><i class="fas fa-cog"></i> <span class="ms-1">Instellingen</span></p>
			${society}
		`);

		if(event.data.RequireCC) {
			informations = `<span class="card-o-title">Informations<span class="badge bg-primary viewall-badge buy_new_card" data-bs-toggle="modal" data-bs-target="#buycc_modal"><i class="fa-solid fa-plus"></i> NEW</span></span>`;
		} else {
			informations = `<span class="card-o-title">Informations</span>`;
		}

		$('#page_info').addClass('row');

		$('#page_info').html(`
			<div class="col-md-7 chart-main">
				<div class="card chart-card text-center">
					<div class="card-header card-o-header">
						<span class="card-o-title">Statistics</span>
					</div>
					<div class="card-body chart-card-body">
						<div class="chart-div">
							<canvas id="myChart"></canvas>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card last-t-card">
							<div class="card-header card-o-header text-center">
								<span class="card-o-title">Laaste Transacties<span class="badge bg-primary viewall-badge" id="view_all_transactions"><i class="fas fa-eye"></i> VIEW ALL</span></span>
							</div>
							<div class="card-body" id="last-t-body">
								<table id="lastTransactionsTable">
									<tbody id="lastTransactionsData">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-5">
				<div class="col-md-12">
					<div class="card ccard-card">
						<div class="card-header card-o-header text-center">
							${informations}
						</div>
						<div class="card-body ccard-body">
							<div class="card creditcard-classic_card d-flex align-items-center">
								<div class="card-body creditcard-classic_card-body">
									<span class="d-flex justify-content-between"><span><img src="img/visa_white.svg" class="w20p"><span class="ccard-name">okokBank Classic</span></span><span><i class="fas fa-wifi"></i></span></span>
									<div class="mt38p">
										<div class="d-flex align-items-center">
											<span class="ccard-status">Status</span>
										</div>
										<div class="d-flex justify-content-between align-items-center">
											<span class="ccard-active">ACTIVE</span>
											<div class="d-flex align-items-center ccard-valid">
												<span class="ccard-thru">VALID THRU</span>
												<span class="ccard-exp">08/25</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<hr>
							<p class="card-text text-center ccard-fs" style="margin-bottom: 1.1rem;"><span class="fff">Balance:</span> <span id="playerBankMoney"></span> EUR</p>
							<p class="card-text text-center ccard-fs"><span class="fff">IBAN:</span> <span id="playerIBAN"></span></p>
						</div>
					</div>
					<div class="card text-center h-100 actions-card">
						<div class="card-header card-o-header">
							<span class="card-o-title">Actions</span>
						</div>
						<div class="card-body actions-card_body">
							<div class="d-flex justify-content-center">
								<button type="button" id="depositMoneyModal" class="btn btn-blue flex-grow-1" data-bs-toggle="modal" data-bs-target="#depositModal"><i class="bi bi-upload"></i> Deposit</button>
							</div>
							<div class="d-flex justify-content-center mt4375">
								<button type="button" id="withdrawMoneyModal" class="btn btn-blue flex-grow-1" data-bs-toggle="modal" data-bs-target="#withdrawModal"><i class="bi bi-download"></i> Withdraw</button>
							</div>
							<div class="d-flex justify-content-center mt4375">
								<button type="button" id="transferMoneyModal" class="btn btn-blue flex-grow-1" data-bs-toggle="modal" data-bs-target="#transferModal"><i class="fas fa-exchange-alt"></i> Transfer</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		`);

		$("#playerName").html(event.data.playerName);
		$("#playerBankMoney").html(event.data.playerBankMoney.toLocaleString());
		$("#playerIBAN").html(event.data.playerIBAN);
		$("#wallet_money").html(event.data.walletMoney.toLocaleString());

		var row = '';
		var num = event.data.db.length;

		if (num > 4) {
			num = 4
		}

		for(var i = 0; i < num; i++) {

			var db = event.data.db[i];

			// Received
			if (db.type == 'transfer' && db.receiver_identifier == event.data.identifier) {
				var name = db.sender_name;
				if (name.length > 15){
					name = name.substring(0, 15)+"..."
				}
				icon = '<td class="align-middle"><span class="lastT-action"><i class="bi bi-download"></i></span></td>';
				data = `<td class="align-middle lastT-name-div">
							From <span class="lastT-name">${name}</span>
							<div class="mtm3125">Received</div>
						</td>`;
				amount = `<td class="align-middle fw500 lastT-received"><span class="floatr">+ ${db.value.toLocaleString()} EUR</span></td>`;
			// Sent
			} else if (db.type == 'transfer' && db.sender_identifier == event.data.identifier) {
				var name = db.receiver_name;
				if (name.length > 15){
					name = name.substring(0, 15)+"..."
				}
				icon = '<td class="align-middle"><span class="lastT-action"><i class="bi bi-upload"></i></span></td>';
				data = `<td class="align-middle lastT-name-div">
							To <span class="lastT-name">${name}</span>
							<div class="mtm3125">Sent</div>
						</td>`;
				amount = `<td class="align-middle fw500"><span class="floatr">- ${db.value.toLocaleString()} EUR</span></td>`;
			// Deposited
			} else if (db.type == 'deposit') {
				var name = db.receiver_name;
				if (name.length > 15){
					name = name.substring(0, 15)+"..."
				}
				icon = '<td class="align-middle"><span class="lastT-action"><i class="bi bi-download"></i></span></td>';
				data = `<td class="align-middle lastT-name-div">
							Into <span class="lastT-name">${name}</span>
							<div class="mtm3125">Deposited</div>
						</td>`;
				amount = `<td class="align-middle fw500 lastT-received"><span class="floatr">+ ${db.value.toLocaleString()} EUR</span></td>`;
			// Withdrawn
			} else if (db.type == 'withdraw') {
				var name = db.sender_name;
				if (name.length > 15){
					name = name.substring(0, 15)+"..."
				}
				icon = '<td class="align-middle"><span class="lastT-action"><i class="bi bi-upload"></i></span></td>';
				data = `<td class="align-middle lastT-name-div">
							From <span class="transactions-name">${name}</span>
							<div class="mtm3125">Withdrawn</div>
						</td>`;
				amount = `<td class="align-middle fw500"><span class="floatr">- ${db.value.toLocaleString()} EUR</span></td>`;
			}

			row += `
				<tr>
					${icon}
					${data}
					${amount}
				</tr>
			`;
		}
		$('#lastTransactionsData').html(row);

		var table_id = document.getElementById('lastTransactionsTable');
		table.push(new simpleDatatables.DataTable(table_id, {
			searchable: false,
			perPageSelect: false,
			paging: false,
		}));

		const labels = [];

		const months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"];

		for (i = 6; i > -1; i--) {
			var days = i;
			var date = new Date();
			var last = new Date(date.getTime() - (days * 24 * 60 * 60 * 1000));
			var day =last.getDate();
			var month=last.getMonth();

			labels.push(day+" "+months[month])
		}

		var ctx = document.getElementById('myChart').getContext('2d');
		var gradient = ctx.createLinearGradient(0, 0, 0, 300);

		gradient.addColorStop(0, 'rgba(241, 170, 4, 0.5)');
		gradient.addColorStop(1, 'rgba(241, 170, 4, 0)');

		const day_earnings = event.data.graphDays;

		var data_graph = {
			labels: labels,
			datasets: [{
				label: 'Earnings',
				backgroundColor: gradient,
				borderColor: '#D17F03',
				data: [day_earnings[6], day_earnings[5], day_earnings[4], day_earnings[3], day_earnings[2], day_earnings[1], day_earnings[0]],
				tension: 0.25,
				fill: 'start',
				pointBackgroundColor: '#D17F03',
				pointRadius: 4,
				pointHoverRadius: 6,
			}]
		};

		var config = {
			type: 'line',
			data: data_graph,
			options: {
				plugins: {
					legend: {
						display: false
					}
				},
				animation: {
					duration: 0
				},
				scales: {
					y: { // y-axis configuration
						grid: {
							lineWidth: 1,
							color: '#2e2f36',
							drawBorder: false
						},
						ticks: {
							color: '#d5d6da'
						}
					},
					x: { // x-axis configuration
						grid: {
							display: false
						},
						ticks: {
							color: '#d5d6da'
						}
					}
				}
			}
		};
		
		var myChart = new Chart (document.getElementById('myChart'), config);

		selectedWindow = "bankmenu";
	}
}

function society_page_function(event) {
	if(event.data.isUpdate && selectedWindow == "societies" || !event.data.isUpdate){
		for(var i=0; i<table.length; i++) {
			table[i].destroy();
			table.splice(i, 1);
		}

		$('#page-title').html('Overview');

		if (event.data.isInSociety){
			society = `<span class="sidebar-title mt-5">Society</span>
					   <p class="sidebar-item mt-2 selected" id="society_page"><i class="bi bi-grid-1x2-fill"></i> <span class="ms-1">Overzicht</span></p>
					   <p class="sidebar-item" id="society_transactions"><i class="fas fa-exchange-alt"></i> <span class="ms-1">Transactions</span></p>`;
		} else {
			society = '';
		}

		$('#sidebar').html(`
			<p class="sidebar-item mt-2" id="overview_page"><i class="bi bi-grid-1x2-fill"></i> <span class="ms-1">Overzicht</span></p>
			<p class="sidebar-item" id="transactions_page"><i class="fas fa-exchange-alt"></i> <span class="ms-1">Transacties</span></p>
			<p class="sidebar-item mt-2" id="settings_page"><i class="fas fa-cog"></i> <span class="ms-1">Instellingen</span></p>
			${society}
		`);

		$('#page_info').addClass('row');

		$('#page_info').html(`
			<div class="col-md-7 chart-main">
				<div class="card chart-card text-center">
					<div class="card-header card-o-header">
						<span class="card-o-title">Statistics</span>
					</div>
					<div class="card-body chart-card-body">
						<div class="chart-div">
							<canvas id="myChart"></canvas>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card last-t-card">
							<div class="card-header card-o-header text-center">
								<span class="card-o-title">Last Transactions<span class="badge bg-primary viewall-badge" id="view_all_transactions_society"><i class="fas fa-eye"></i> VIEW ALL</span></span>
							</div>
							<div class="card-body" id="last-t-body">
								<table id="lastTransactionsTable">
									<tbody id="lastTransactionsData">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-5">
				<div class="col-md-12">
					<div class="card ccard-card">
						<div class="card-header card-o-header text-center">
							<span class="card-o-title">Informations</span>
						</div>
						<div class="card-body ccard-body">
							<div class="card creditcard-classic_card d-flex align-items-center">
								<div class="card-body creditcard-classic_card-body">
									<span class="d-flex justify-content-between"><span><img src="img/visa_white.svg" class="w20p"><span class="ccard-name">okokBank Classic</span></span><span><i class="fas fa-wifi"></i></span></span>
									<div class="mt38p">
										<div class="d-flex align-items-center">
											<span class="ccard-status">Status</span>
										</div>
										<div class="d-flex justify-content-between align-items-center">
											<span class="ccard-active">ACTIVE</span>
											<div class="d-flex align-items-center ccard-valid">
												<span class="ccard-thru">VALID THRU</span>
												<span class="ccard-exp">08/25</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<hr>
							<p class="card-text text-center ccard-fs" style="margin-bottom: 1.1rem;""><span class="fff">Balance:</span> <span id="playerBankMoney"></span> EUR</p>
							<p class="card-text text-center ccard-fs"><span class="fff">IBAN:</span> <span id="playerIBAN"></span></p>
						</div>
					</div>
					<div class="card text-center h-100 actions-card">
						<div class="card-header card-o-header">
							<span class="card-o-title">Actions</span>
						</div>
						<div class="card-body actions-card_body">
							<div class="d-flex justify-content-center">
								<button type="button" id="depositMoneyModal" class="btn btn-blue flex-grow-1" data-bs-toggle="modal" data-bs-target="#depositModal"><i class="bi bi-upload"></i> Deposit</button>
							</div>
							<div class="d-flex justify-content-center mt4375">
								<button type="button" id="withdrawMoneyModal" class="btn btn-blue flex-grow-1" data-bs-toggle="modal" data-bs-target="#withdrawModal"><i class="bi bi-download"></i> Withdraw</button>
							</div>
							<div class="d-flex justify-content-center mt4375">
								<button type="button" id="transferMoneyModal" class="btn btn-blue flex-grow-1" data-bs-toggle="modal" data-bs-target="#transferModal"><i class="fas fa-exchange-alt"></i> Transfer</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		`);

		$("#playerBankMoney").html(event.data.societyInfo.value.toLocaleString());
		$("#wallet_money").html(event.data.walletMoney.toLocaleString());
		$("#playerIBAN").html(event.data.societyInfo.iban);

		var row = '';
		var num = event.data.db.length;

		if (num > 4) {
			num = 4
		}

		for(var i = 0; i < num; i++) {

			var db = event.data.db[i];

			// Received
			if (db.type == 'transfer' && db.receiver_identifier == event.data.identifier) {
				var name = db.sender_name;
				if (name.length > 15){
					name = name.substring(0, 15)+"..."
				}
				icon = '<td class="align-middle"><span class="lastT-action"><i class="bi bi-download"></i></span></td>';
				data = `<td class="align-middle lastT-name-div">
							From <span class="lastT-name">${name}</span>
							<div class="mtm3125">Received</div>
						</td>`;
				amount = `<td class="align-middle fw500 lastT-received"><span class="floatr">+ ${db.value.toLocaleString()} EUR</span></td>`;
			// Sent
			} else if (db.type == 'transfer' && db.sender_identifier == event.data.identifier) {
				var name = db.receiver_name;
				if (name.length > 15){
					name = name.substring(0, 15)+"..."
				}
				icon = '<td class="align-middle"><span class="lastT-action"><i class="bi bi-upload"></i></span></td>';
				data = `<td class="align-middle lastT-name-div">
							To <span class="lastT-name">${name}</span>
							<div class="mtm3125">Sent</div>
						</td>`;
				amount = `<td class="align-middle fw500"><span class="floatr">- ${db.value.toLocaleString()} EUR</span></td>`;
			// Deposited
			} else if (db.type == 'deposit') {
				var name = db.receiver_name;
				if (name.length > 15){
					name = name.substring(0, 15)+"..."
				}
				icon = '<td class="align-middle"><span class="lastT-action"><i class="bi bi-download"></i></span></td>';
				data = `<td class="align-middle lastT-name-div">
							Into <span class="lastT-name">${name}</span>
							<div class="mtm3125">Deposited</div>
						</td>`;
				amount = `<td class="align-middle fw500 lastT-received"><span class="floatr">+ ${db.value.toLocaleString()} EUR</span></td>`;
			// Withdrawn
			} else if (db.type == 'withdraw') {
				var name = db.sender_name;
				if (name.length > 15){
					name = name.substring(0, 15)+"..."
				}
				icon = '<td class="align-middle"><span class="lastT-action"><i class="bi bi-upload"></i></span></td>';
				data = `<td class="align-middle lastT-name-div">
							From <span class="transactions-name">${name}</span>
							<div class="mtm3125">Withdrawn</div>
						</td>`;
				amount = `<td class="align-middle fw500"><span class="floatr">- ${db.value.toLocaleString()} EUR</span></td>`;
			}

			row += `
				<tr>
					${icon}
					${data}
					${amount}
				</tr>
			`;
		}
		$('#lastTransactionsData').html(row);

		var table_id = document.getElementById('lastTransactionsTable');
		table.push(new simpleDatatables.DataTable(table_id, {
			searchable: false,
			perPageSelect: false,
			paging: false,
		}));

		const labels = [];

		const months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"];
		
		for (i = 6; i > -1; i--) {
			var days = i;
			var date = new Date();
			var last = new Date(date.getTime() - (days * 24 * 60 * 60 * 1000));
			var day =last.getDate();
			var month=last.getMonth();

			labels.push(day+" "+months[month])
		}

		var ctx = document.getElementById('myChart').getContext('2d');
		var gradient = ctx.createLinearGradient(0, 0, 0, 300);

		gradient.addColorStop(0, 'rgba(20, 75, 217, 0.5)');
		gradient.addColorStop(1, 'rgba(25, 70, 189, 0)');

		const day_earnings = event.data.graphDays;

		var data_graph = {
			labels: labels,
			datasets: [{
				label: 'Earnings',
				backgroundColor: gradient,
				borderColor: '#D17F03',
				data: [day_earnings[6], day_earnings[5], day_earnings[4], day_earnings[3], day_earnings[2], day_earnings[1], day_earnings[0]],
				tension: 0.25,
				fill: 'start',
				pointBackgroundColor: '#D17F03',
				pointRadius: 4,
				pointHoverRadius: 6,
			}]
		};

		var config = {
			type: 'line',
			data: data_graph,
			options: {
				plugins: {
					legend: {
						display: false
					}
				},
				animation: {
					duration: 0
				},
				scales: {
					y: { // y-axis configuration
						grid: {
							lineWidth: 1,
							color: '#2e2f36',
							drawBorder: false
						},
						ticks: {
							color: '#d5d6da'
						}
					},
					x: { // x-axis configuration
						grid: {
							display: false
						},
						ticks: {
							color: '#d5d6da'
						}
					}
				}
			}
		};
		
		var myChart = new Chart (document.getElementById('myChart'), config);

		selectedWindow = "societies";
	}
}

function settings_page_function(event) {
	for(var i=0; i<table.length; i++) {
		table[i].destroy();
		table.splice(i, 1);
	}

	$('#page-title').html('Instellingen');

	if (event.data.isInSociety){
		society = `<span class="sidebar-title mt-5">Society</span>
				   <p class="sidebar-item mt-2" id="society_page"><i class="bi bi-grid-1x2-fill"></i> <span class="ms-1">Overzicht</span></p>
				   <p class="sidebar-item" id="society_transactions"><i class="fas fa-exchange-alt"></i> <span class="ms-1">Transactions</span></p>`;
	} else {
		society = '';
	}

	$('#sidebar').html(`
		<p class="sidebar-item mt-2" id="overview_page"><i class="bi bi-grid-1x2-fill"></i> <span class="ms-1">Overzicht</span></p>
		<p class="sidebar-item" id="transactions_page"><i class="fas fa-exchange-alt"></i> <span class="ms-1">Transacties</span></p>
		<p class="sidebar-item mt-2 selected" id="settings_page"><i class="fas fa-cog"></i> <span class="ms-1">Instellingen</span></p>
		${society}
	`);

	$('#page_info').addClass('row');

	$('#page_info').html(`
		<div class="col-md-12 d-flex flex-grow-1 flex-column h-100 settings-col">
			<div class="card d-flex flex-column flex-grow-1 settings-card">
				<div class="card-header card-o-header text-center">
					<span class="card-o-title">
						<span>Account IBAN</span>
					</span>
				</div>
				<div class="card-body settings-card_body flex-grow-1">
					<div>
						<div class="row">
							<div class="col col-md-6 d-flex justify-content-center">
								<div class="card w-100 h-100 changeiban-card">
									<div class="card-body text-center">
										<span class="fs15 fff">Change IBAN</span>
										<input type="text" maxlength="${event.data.ibanCharNum}" id="new_iban" class="form-control text-center" placeholder="New IBAN" onkeyup="checkIfEmptySettings()">
										<button type="button" id="change_iban" class="btn btn-blue" disabled><i class="fas fa-paper-plane"></i> Submit</button>
									</div>
								</div>
							</div>
							<div class="col col-md-6 d-flex align-items-center">
								<div class="card w-100 h-100 d-flex justify-content-center settings_info-card">
									<div class="card-body text-center fs1125">
										<span>The IBAN has a change cost of ${event.data.ibanCost}€</span>
										<hr class="fff">
										<span>The IBAN always have the prefix "${event.data.ibanPrefix}"</span>
										<hr class="fff">
										<span>The maximum number of characters is ${event.data.ibanCharNum}</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="card d-flex flex-column flex-grow-1 settings2-card">
				<div class="card-header card-o-header text-center">
					<span class="card-o-title">
						<span>PIN Code</span>
					</span>
				</div>
				<div class="card-body flex-grow-1 settings-card_body">
					<div>
						<div class="row">
							<div class="col col-md-6 d-flex justify-content-center">
								<div class="card w-100 h-100 changepin-card">
									<div class="card-body text-center">
										<span class="fs15 fff">Change PIN</span>
										<input type="password" maxlength="4" id="new_pin" class="form-control text-center" placeholder="New PIN" onkeyup="checkIfEmptySettings()">
										<button type="button" id="change_pin" class="btn btn-blue" disabled><i class="fas fa-paper-plane"></i> Submit</button>
									</div>
								</div>
							</div>
							<div class="col col-md-6 d-flex align-items-center">
								<div class="card w-100 h-100 d-flex justify-content-center settings_info-card">
									<div class="card-body text-center fs1125">
										<span>The PIN has a change cost of ${event.data.pinCost}€</span>
										<hr class="fff">
										<span>The maximum number of characters is ${event.data.pinCharNum}</span>
										<hr class="fff">
										<span>You can only use numbers</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	`);

	selectedWindow = "settings";
}

function logout_page() {
	$("#menu").fadeOut();
	setTimeout(function () {
		$('#menu').html(`
			<div class="d-flex justify-content-center flex-column align-items-center">
				<span class="load"></span>
				<br>
				<div class="ldata-txt">Uitloggen...</div>
			</div>
		`);
		$("#menu").fadeIn();
		setTimeout(function(){
			$("#menu").fadeOut();
			$(".main_card").fadeOut();

			selectedWindow = "none";
			setTimeout(function(){
				isLoggingOut = false
				for(var i=0; i<table.length; i++) {
					table[i].destroy();
					table.splice(i, 1);
				}
			}, 600);
			$.post('https://okokBanking/action', JSON.stringify({
				action: "close",
			}));
		}, 1000);
	}, 400);
	if(useSound) {
		var popuprev_sound = new Audio('popupreverse.mp3');
		popuprev_sound.volume = 0.2;
		popuprev_sound.play();
	}
}

var canSetClick = true;

function atm_numpad(pin) {
	var input = "";
	correct = pin;

	var dots = document.querySelectorAll(".dot");
	numbers = document.querySelectorAll(".number");
	dots = Array.prototype.slice.call(dots);
	numbers = Array.prototype.slice.call(numbers);
	

	numbers.forEach(function (number, index) {
		if (canSetClick){
			number.addEventListener("click", numpad);
		}
		function numpad() {
			if(useSound) {
				var atm_sound = new Audio('atm.mp3');
				atm_sound.volume = 0.2;
				atm_sound.play();
			}
			if (index == 9 || index == 11) {
				if (index == 9) {
					dots.forEach(function (dot, index) {
							dot.className = "dot clear";
						});
				} else if (index == 11) {
					if (input == correct) {
						if (useSound) {
							var correct_sound = new Audio('correct.mp3');
							correct_sound.volume = 0.2;
							correct_sound.play();
						}
						dots.forEach(function (dot, index) {
							dot.className = "dot active correct";
						});
						setTimeout(function () {
							$(".atm_card").fadeOut();
							$.post('https://okokBanking/action', JSON.stringify({
								action: "close",
							}));
							selectedWindow = "none";
					
							$.post('https://okokBanking/action', JSON.stringify({
								action: "atm",
							}));
						}, 900);
					} else {
						dots.forEach(function (dot, index) {
							dot.className = "dot active wrong";
						});
						if(useSound) {
							var wrong_sound = new Audio('wrong.mp3');
							wrong_sound.volume = 0.2;
							wrong_sound.play();
						}
					}
				}
				setTimeout(function () {
					dots.forEach(function (dot, index) {
						dot.className = "dot";
					});
					input = "";
				}, 900);
				setTimeout(function () {
					document.body.className = "";
				}, 2000);
			} else {
				if (input.length < 4) {
					if (index == 10) {
					index = -1
				}
				number.className = "number grow";
				input += index + 1;
				dots[input.length - 1].className = "dot active";
				setTimeout(function () {
					number.className = "number";
				}, 1000);
				}
			}
		}
	});
	canSetClick = false
}
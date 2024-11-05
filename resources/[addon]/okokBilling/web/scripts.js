var table = [];
var Invoices;
var sendInvoiceToSociety = false;
var playerIdentifier;
var nearPlayers;
var playerSociety;
var vatPercentage
var billsList;
var playerJob;
var SocietyInvoices;
var AllInvoices;
var canAccessSociety = false;
var DetailsInvoices;
var VATPercentage;
var SocietyRecievesLessWithIVA;
var selectedWindow;
var isLoading = false;
var p2p = false;

var table0Page = 1;
var table1Page = 1;
var table2Page = 1;
var table3Page = 1;

var table_id = document.getElementById('invoicesTable');
table.push(new simpleDatatables.DataTable(table_id, {
	perPageSelect: false,
	perPage: 5,
	searchable: true,
}));

var table_id2 = document.getElementById('societyInvoicesTable');
table.push(new simpleDatatables.DataTable(table_id2, {
	perPageSelect: false,
	perPage: 5,
	searchable: true,
}));

var table_id4 = document.getElementById('courtTable');
table.push(new simpleDatatables.DataTable(table_id4, {
	perPageSelect: false,
	perPage: 5,
	searchable: true,
}));

window.addEventListener('message', function(event) {
	switch (event.data.action) {
		case 'selection_menu':
			selectedWindow = 'selection_menu';
			Invoices = JSON.parse(event.data.playerInvoices);
			DetailsInvoices = Invoices;
			playerIdentifier = event.data.playerIdentifier;
			playerSociety = event.data.playerSociety;
			vatPercentage = event.data.vatPercentage;
			billsList = new Object(JSON.parse(event.data.billsList));
			playerJob = event.data.playerJob;
			canAccessSociety = event.data.societyAccess;
			SocietyRecievesLessWithIVA = event.data.SocietyRecievesLessWithIVA;
			VATPercentage = event.data.VATPercentage;
			p2p = event.data.AllowPlayersInvoice;
			var width = '14.25%';

			$('.selection_menu').css('width', width);

			var normalMenuRow = `
			<div class="col pr05 selection-colw">
				<div class="card h-100">
					<div class="selectionMyInvoices card-body text-center selection-subcard" id="selectionMyInvoices" onclick="selectionMyInvoices()">
						<span class="selection-subcard_card-title"><i class="fas fa-user"></i></span>
						<p class="selection-subcard_title">Persoonlijke<br>Facturen</p>
					</div>
				</div>
			</div>
			<div class="col pr05 pl05 selection-colw">
				<div class="card h-100">
					<div class="selectionPayReference card-body text-center selection-subcard" id="selectionPayReference" onclick="selectionPayReference()">
						<span class="selection-subcard_card-title"><i class="fa-solid fa-receipt"></i></span>
						<p class="selection-subcard_title">Betaal<br>Referentie</p>
					</div>
				</div>
			</div>
			
			`;

			var createInvoiceBtn = `
			<div class="col pr05 pl05 selection-colw">
				<div class="card h-100">
					<div class="selectionCreateInvoice card-body text-center selection-subcard" id="selectionCreateInvoice" onclick="selectionCreateInvoice()">
						<span class="selection-subcard_card-title"><i class="fas fa-paper-plane"></i></span>
						<p class="selection-subcard_title">Maak<br>Factuur</p>
					</div>
				</div>
			</div>
			`;

			var societyAccessCard = `
				<div class="col pl05 selection-colw" id="societyButton">
					<div class="card h-100">
						<div class="selectionSocietyInvoices card-body text-center selection-subcard_disabled" id="selectionSocietyInvoices" onclick="selectionSocietyInvoices()">
							<span class="selection-subcard_card-title"><i class="fas fa-building"></i></span>
							<p class="selection-subcard_title">Maatschappij<br>Facturen</p>
						</div>
					</div>
				</div>`;

			var inspectBtn = `
				<div class="col pr05 pl05 selection-colw">
					<div class="card h-100">
						<div class="card-body text-center selection-subcard" id="selectionInspectCitizen" onclick="selectionInspectCitizen()">
							<span class="selection-subcard_card-title"><i class="fa-solid fa-magnifying-glass"></i></span>
							<p class="selection-subcard_title">Bekijk<br>Burger</p>
						</div>
					</div>
				</div>`;

			var cityInvoicesBtn = `
				<div class="col pr05 pl05 selection-colw">
					<div class="card h-100">
						<div class="card-body text-center selection-subcard" id="selectionCityInvoices" onclick="selectionCityInvoices()">
							<span class="selection-subcard_card-title"><i class="fa-solid fa-city"></i></span>
							<p class="selection-subcard_title">Stad<br>Facturen</p>
						</div>
					</div>
				</div>`;
				
			$('#menu').html(normalMenuRow);

			var playerJobIsInBillsList = false;

			Object.keys(billsList).forEach(key => {
				if(playerJob == key){
					playerJobIsInBillsList = true
				}
			});

			if(playerJobIsInBillsList || p2p){
				width = parseFloat(width)+7;
				width = width.toString() + '%'
				$('.selection_menu').css('width', width);
				$('#menu').append(createInvoiceBtn);
			}

			if(event.data.isCop){
				width = parseFloat(width)+7;
				width = width.toString() + '%'
				$('.selection_menu').css('width', width);
				$('#menu').append(inspectBtn);
				
				if(event.data.hasCityInvoices){
					width = parseFloat(width)+7;
					width = width.toString() + '%'
					$('.selection_menu').css('width', width);
					$('#menu').append(cityInvoicesBtn);
					if(canAccessSociety){
						width = parseFloat(width)+7;
						width = width.toString() + '%'
						$('.selection_menu').css('width', width);
						$('#menu').append(societyAccessCard);
					}
				}else if(canAccessSociety){
					width = parseFloat(width)+7;
					width = width.toString() + '%'
					$('.selection_menu').css('width', width);
					$('#menu').append(societyAccessCard);
				}
			}else if(event.data.hasCityInvoices){
				width = parseFloat(width)+7;
				width = width.toString() + '%'
				$('.selection_menu').css('width', width);
				$('#menu').append(cityInvoicesBtn);
				if(canAccessSociety){
					width = parseFloat(width)+7;
					width = width.toString() + '%'
					$('.selection_menu').css('width', width);
					$('#menu').append(societyAccessCard);
				}
			}else{
				if(canAccessSociety){
					width = parseFloat(width)+7;
					width = width.toString() + '%'
					$('.selection_menu').css('width', width);
					$('#menu').append(societyAccessCard);
				}
			}
			
			$('#normalMenu').fadeIn();

			Object.keys(billsList).forEach(key => {
				if(playerJob == key){
					playerJobIsInBillsList = true
					$('#stp_item').empty();
					$('#bill_createinvoice_price').val(billsList[key][0][1])
					if(billsList[key][0][1] == undefined){
						$("#bill_createinvoice_price").attr("readonly", false);
						$('#bill_createinvoice_price').val('');
					}else{
						$("#bill_createinvoice_price").attr("readonly", true);
						$('#bill_createinvoice_price').val(billsList[key][0][1]);
					}
					var i = 0;
					billsList[key].forEach(element => {
						$('#stp_item').append($('<option>', {
							value: i,
							text: element[0]
						}));
						i++;
					});
				}
			});

			if(playerJobIsInBillsList){
				$('#invoiceBillsList').fadeIn();

				if(!p2p){
					$('#invoicesFirstMenu').html(`
						<button type="button" class="btn btn-blue w-100 ci-option">JOB</button>
					`);
					$('#invoicesSecondMenu').html(`
						<button type="button" id="openBillsListInvoice" class="btn btn-odark w-100 ci-option">JOB</button>
					`);
				}
			}
			else{
				$('#invoiceNormal').fadeIn();
			}

			$('.selection_menu').fadeIn();
			if(canAccessSociety){
				$('.selectionSocietyInvoices').removeClass("selection-subcard_disabled");
				$('.selectionSocietyInvoices').addClass("selection-subcard");
			}
			break;
		case 'update_AllInvoices':
			Invoices = JSON.parse(event.data.playerInvoices);
			AllInvoices = JSON.parse(event.data.allInvoices);
			SocietyInvoices = JSON.parse(event.data.societyInvoices);

			DetailsInvoices = Invoices;
			table[0].destroy();
			table[0].init();
			table[1].destroy();
			table[1].init();
			table[2].destroy();
			table[2].init();
			if(selectedWindow == "my_invoices"){
				renderMyInvoices();
			} else if(selectedWindow == "society_invoices"){
				renderSocietiesInvoices();
			} else if(selectedWindow == "all_invoices"){
				selectionCityInvoices();
			}
			
			table[0].page(table0Page);
			table[1].page(table1Page);
			table[2].page(table2Page);
			break;
		case 'updateNearPlayers':			
			nearPlayers = event.data.nearPlayers;
			openClosePlayers();
			break;
		case 'openMyInvoices':
			Invoices = JSON.parse(event.data.playerInvoices);
			OpenMyInvoices();
			break;
		case 'toggleMyInvoices':
			Invoices = JSON.parse(event.data.playerInvoices);
			load();
			OpenMyInvoices('my_invoices_toggle');
			break;
		case 'reference':
			var invoice = event.data.refInvoice;
			if(invoice[0] != undefined && ["ref_id"] != undefined && invoice[0]["status"] == "unpaid"){
				$('#payreference_receiver').html(invoice[0]["receiver_name"])
				$('#payreference_amount').html(invoice[0]["invoice_value"])
				$('#payreference').prop('disabled', false);
				$('#payreference_receiver').removeClass("payreference_noinfo");
				$('#payreference_amount').removeClass("payreference_noinfo");
			}else{
				$('#payreference_receiver').html("No Info Available")
				$('#payreference_amount').html("No Info Available")
				$('#payreference').prop('disabled', true);
				$('#payreference_receiver').addClass("payreference_noinfo");
				$('#payreference_amount').addClass("payreference_noinfo");
			}
			break;
		case 'close_all':
			selectedWindow = '';
			$('.invoices_menu').fadeOut();
			$('.selection_menu').fadeOut();
			$('.payreference_menu').fadeOut();
			$('.createinvoice_menu').fadeOut();
			$('.societyinvoices_menu').fadeOut();
			$('.police_menu').fadeOut();
			$('.cityinvoices_menu').fadeOut();
			break;
		case 'openCreateInvoice':
			billsList = event.data.bills
			playerJobIsInBillsList = event.data.societyInvoices
			p2p = event.data.p2p
			playerJob = event.data.job

			if(playerJobIsInBillsList){
				Object.keys(billsList).forEach(key => {
					if(playerJob == key){
						playerJobIsInBillsList = true
						$('#stp_item').empty();
						$('#bill_createinvoice_price').val(billsList[key][0][1])
						if(billsList[key][0][1] == undefined){
							$("#bill_createinvoice_price").attr("readonly", false);
							$('#bill_createinvoice_price').val('');
						}else{
							$("#bill_createinvoice_price").attr("readonly", true);
							$('#bill_createinvoice_price').val(billsList[key][0][1]);
						}
						var i = 0;
						billsList[key].forEach(element => {
							$('#stp_item').append($('<option>', {
								value: i,
								text: element[0]
							}));
							i++;
						});
					}
				});
				$('#invoiceBillsList').fadeIn();

				if(!p2p){
					$('#invoicesFirstMenu').html(`
						<button type="button" class="btn btn-blue w-100 ci-option">JOB</button>
					`);
					$('#invoicesSecondMenu').html(`
						<button type="button" id="openBillsListInvoice" class="btn btn-odark w-100 ci-option">JOB</button>
					`);
				}
			}
			else{
				$('#invoiceNormal').fadeIn();
			}

			selectionCreateInvoice("direct")
			break
	}
	
})

$('#stp_item').change(function() {
	var selectedText = $(this).find(':selected').text();

	Object.keys(billsList).forEach(key => {
		if(playerJob == key){
			billsList[key].forEach(element => {
				if(element[0] == selectedText){
					if(element[1] == undefined){
						$("#bill_createinvoice_price").attr("readonly", false);
						$('#bill_createinvoice_price').val('');
					}else{
						$("#bill_createinvoice_price").attr("readonly", true);
						$('#bill_createinvoice_price').val(element[1]);
					}
				}
			});
		}
	});
})

table[0].on('datatable.page', function(page) {
    table0Page = page;
});

table[1].on('datatable.page', function(page) {
    table1Page = page;
});

table[2].on('datatable.page', function(page) {
    table2Page = page;
});

function load() {
	selectedWindow = 'loading';
	isLoading = true;
	$('.loading_menu').fadeIn();
	$('.selection_menu').fadeOut();
}

function prepareInvoiceForTable(invoice, i, index = null){
	if(index == null){
		index = i;
	}
	var invoiceStatus = invoice["status"] == "unpaid" ? '<span class="due"><i class="fas fa-times-circle"></i></span>' : '<span class="paid"><i class="fas fa-check-circle"></i></span>';
	let newData = {
		data: [
			[
				`<div class="text-center align-middle">${i+1}</div>`,
				`<div class="text-center align-middle fs15">${invoiceStatus}</div>`,
				`<div class="text-center align-middle">${invoice["author_name"]}</div>`,
				`<div class="text-center align-middle">${invoice["invoice_value"]}€</div>`,
				`<div class="text-center align-middle"><button type="button" onclick="renderDetails(${index})" id="InvoiceModal${index}" class="btn-openInvoiceModal btn btn-blue btn-view" data-bs-toggle="modal" data-bs-target="#${invoice["status"] == "unpaid" ? "un" : ""}paidviewInvoiceModal"><i class="fas fa-eye"></i> VIEW</button></div>`,
			]
		]
	};
	return newData;
}

function renderMyInvoices(type){
	selectedWindow = 'my_invoices';
	if(type == 'my_invoices_toggle'){
		selectedWindow = 'my_invoices_toggle';
	}
	DetailsInvoices = Invoices;
	var i = 0;
	var index = 0;
	var total = 0;
	Invoices.forEach(invoice => {
		if(invoice["status"] == "unpaid"){
			total += invoice["invoice_value"];
		}
		
		table[0].insert(prepareInvoiceForTable(invoice, i, index))
		i++;
		index++;
	});

	if(i == 0){
		$('#view_invoice_payall').hide();
	}
	else{
		$('#view_invoice_payall').html(`PAY ALL (${total}€)`);
	}

	if(total <= 0){
		$('#view_invoice_payall').prop('disabled', true)
	} else {
		$('#view_invoice_payall').prop('disabled', false)
	}
	$.post('https://okokBilling/action', JSON.stringify({
		action: "invoicesLoaded",
	}));
}

function renderSocietiesInvoices(){
	selectedWindow = 'society_invoices';
	DetailsInvoices = SocietyInvoices;
	var i = 0;
	var index = 0;
	var total = 0;
	SocietyInvoices.forEach(invoice => {
		var invoiceStatus = invoice["status"] == "unpaid" ? '<span class="due"><i class="fas fa-times-circle"></i></span>' : '<span class="paid"><i class="fas fa-check-circle"></i></span>';
		if(invoice["status"] == "unpaid"){
			total += invoice["invoice_value"];
		}
		let newData = prepareInvoiceForTable(invoice, i, index)
		table[1].insert(newData)
		i++;
		index++;
	});
	if(SocietyRecievesLessWithIVA){
		total = total - (total*(VATPercentage/100))
	}
	$('#totalpending_value').html(Math.round(total));
	$.post('https://okokBilling/action', JSON.stringify({
		action: "invoicesLoaded",
	}));
}

function renderAllInvoices(){
	selectedWindow = 'all_invoices';
	DetailsInvoices = AllInvoices;
	var i = 0;
	var index = 0;
	var total = 0;
	AllInvoices.forEach(invoice => {
		var invoiceStatus = invoice["status"] == "unpaid" ? '<span class="due"><i class="fas fa-times-circle"></i></span>' : '<span class="paid"><i class="fas fa-check-circle"></i></span>';
		if(invoice["status"] == "unpaid"){
			total += invoice["invoice_value"];
		}
		let newData = prepareInvoiceForTable(invoice, i)
		table[2].insert(newData)
		i++;
	});
	$.post('https://okokBilling/action', JSON.stringify({
		action: "invoicesLoaded",
	}));
}

function selectionMyInvoices() {
	load();
	$.post('https://okokBilling/action', JSON.stringify({
		action: "getMyInvoices",
	}));
}

function OpenMyInvoices(type) {
	if(isLoading){
		table0Page = 1;
		table[0].destroy();
		table[0].init();
		renderMyInvoices(type);
		$('.invoices_menu').fadeIn();
		$('.loading_menu').fadeOut();
	}
	
}

function selectionPayReference() {
	selectedWindow = 'pay_reference';
	$('.selection_menu').fadeOut();
	$('.payreference_menu').fadeIn();
}

function selectionCreateInvoice(type) {
	if(type == "direct"){
		selectedWindow = 'direct_create_invoices';
	} else {
		selectedWindow = 'create_invoices';
	}
	
	$('.selection_menu').fadeOut();
	$('.createinvoice_menu').fadeIn();
	checkIfEmpty();
}

function selectionSocietyInvoices() {
	if(canAccessSociety){
		load();
		fetch(`https://okokBilling/action`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json; charset=UTF-8',
			},
			body: JSON.stringify({
				action: "getSocietyInvoices",
			})
		}).then(resp => resp.json()).then(resp => setSocietyInvoices(resp));
	}
}

function setSocietyInvoices(resp) {
	if(isLoading){
		SocietyInvoices = JSON.parse(resp);
		DetailsInvoices = SocietyInvoices;
		if(canAccessSociety){
			table1Page = 1;
			table[1].destroy();
			table[1].init();
			$('.selection_menu').fadeOut();
			renderSocietiesInvoices();
			$('.societyinvoices_menu').fadeIn();
			$('.loading_menu').fadeOut();
		}
	}
}

function selectionInspectCitizen() {
	selectedWindow = 'inspect_citizen'
	$('.selection_menu').fadeOut();
	$('.police_menu').fadeIn();
}


function selectionCityInvoices() {
	load();
	fetch(`https://okokBilling/action`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json; charset=UTF-8',
		},
		body: JSON.stringify({
			action: "getAllInvoices",
		})
	}).then(resp => resp.json()).then(resp => SetAllInvoices(resp));
}

function SetAllInvoices(resp){
	if(isLoading){
		AllInvoices = JSON.parse(resp);
		DetailsInvoices = AllInvoices;
		table2Page = 1;
		table3Page = 1;
		table[2].destroy();
		table[2].init();

		$('.selection_menu').fadeOut();
		renderAllInvoices();

		$('.cityinvoices_menu').fadeIn();
		$('.loading_menu').fadeOut();
	}
}

$("#closeSelectionMenu").click(function() {
	$('.selection_menu').fadeOut();
	$('#lspdMenu').fadeOut();
	$('#lspdMenuWCity').fadeOut();
	$('#allInvoicesMenu').fadeOut();
	$('#normalMenu').fadeOut();
	$('#invoiceNormal').fadeOut();
	$('#invoiceBillsList').fadeOut();
	$('#invoiceCustom').fadeOut();
	table0Page = 1;
	table1Page = 1;
	table2Page = 1;
	table3Page = 1;
	if($('.selectionSocietyInvoices').hasClass("selection-subcard")){
		$('.selectionSocietyInvoices').removeClass("selection-subcard");
		$('.selectionSocietyInvoices').addClass("selection-subcard_disabled");
	}
	$.post('https://okokBilling/action', JSON.stringify({
        action: "close"
    }));
    selectedWindow = '';
});

$("#closeInvoicesMenu").click(function() {
	$('.invoices_menu').fadeOut();
	if(selectedWindow == 'my_invoices_toggle'){
		document.getElementById('closeSelectionMenu').click();
	} else {
		$('.selection_menu').fadeIn();
		selectedWindow = 'selection_menu';
	}
	
});

$("#closePayReferenceMenu").click(function() {
	$('.payreference_menu').fadeOut();
	$('.selection_menu').fadeIn();
	selectedWindow = 'selection_menu';
});

$("#closeCreateInvoiceMenu").click(function() {
	$('.createinvoice_menu').fadeOut();

	if(selectedWindow == 'direct_create_invoices'){
		$.post('https://okokBilling/action', JSON.stringify({
	        action: "close"
	    }));
	    selectedWindow = '';
	} else {
		$('.selection_menu').fadeIn();
		selectedWindow = 'selection_menu';
	}

	
});

$("#closeSocietyInvoicesMenu").click(function() {
	$('.societyinvoices_menu').fadeOut();
	$('.selection_menu').fadeIn();
	selectedWindow = 'selection_menu';
});

$("#closePoliceMenu").click(function() {
	$('.police_menu').fadeOut();
	$('.selection_menu').fadeIn();
	selectedWindow = 'selection_menu';
});

$("#closeCityInvoicesMenu").click(function() {
	$('.cityinvoices_menu').fadeOut();
	$('.selection_menu').fadeIn();
	selectedWindow = 'selection_menu';
});

$("#openCustomInvoice").click(function() {
	$('#invoiceBillsList').hide();
	$('#invoiceCustom').show();
	checkIfEmpty();
});

$("#openBillsListInvoice").click(function() {
	$('#invoiceCustom').hide();
	$('#invoiceBillsList').show();
	checkIfEmpty();
});

function createInvoice(identifier){
	var item, price, note, player, sendToSociety;

	if( $("#invoiceNormal").css('display') == 'block') {
		item = $('#normal_createinvoice_item').val();
		price = $('#normal_createinvoice_price').val();
		note = $('#normal_createinvoice_note').val();
		$('#normal_createinvoice_note').val('');
		sendToSociety = false;
	}
	else{
		if( $("#invoiceBillsList").css('display') == 'block') {
			item = $('#stp_item').find(':selected').text();
			price = $('#bill_createinvoice_price').val();
			note = $('#bill_createinvoice_note').val();
			$('#bill_createinvoice_note').val('');
			sendToSociety = true;
		}
		else{
			item = $('#custom_createinvoice_item').val();
			price = $('#custom_createinvoice_price').val();
			note = $('#custom_createinvoice_note').val();
			$('#custom_createinvoice_item').val('');
			$('#custom_createinvoice_price').val('');
			$('#custom_createinvoice_note').val('');
			sendToSociety = false;
		}
	}
	
	player = identifier

	if(price > 0){
		$.post('https://okokBilling/action', JSON.stringify({
	        action: "createInvoice",
			item: item,
			price: price,
			note: note,
			player: player,
			sendToSociety: sendToSociety,
	    }));
		
	    $('.createinvoice_menu').fadeOut();
		if(selectedWindow != 'direct_create_invoices'){
			$('.selection_menu').fadeIn();
		} else {
			$.post('https://okokBilling/action', JSON.stringify({
				action: "close"
			}));
		}
	}
	
}

$('#createinvoice').click(function(){
	$.post('https://okokBilling/action', JSON.stringify({
		action: "getNearPlayers",
	}));
})

function openClosePlayers(){
	if(nearPlayers.length > 0){
		$('#selectPlayerToSendInvoiceModal').modal('toggle');
		var element = `<div class="d-flex flex-column justify-content-center">`;
		var addedCards = 0;
		var addedOneRow = false;
		$('#nearPlayersDiv').empty();

		for(var i = 0; i < nearPlayers.length; i+=1){
			var player = null;
			var player2 = null;

			if(i%2 == 0){
				if(addedOneRow){
					element += `<div class="row mt-3">`;
				} else {
					addedOneRow = true;
					element += `<div class="row">`;
				}
			}
			
			addedCards = addedCards + 1
			
			if(addedCards == 2){
				element += `
				<div class="col-md-6 pl05">
					<button type="button" onclick="createInvoice('${nearPlayers[i]["id"]}')" class="btn btn-odark2 fs125 h-100 w-100" id="${nearPlayers[i]["id"]}" data-bs-dismiss="modal">${nearPlayers[i]["name"]} (${Math.round(nearPlayers[i]["id"])})</button>
				</div>`;
				element += `</div>`;
				addedCards = 0;
			} else {
				element += `
				<div class="col-md-6 pr05">
					<button type="button" onclick="createInvoice('${nearPlayers[i]["id"]}')" class="btn btn-odark2 fs125 h-100 w-100" id="${nearPlayers[i]["id"]}" data-bs-dismiss="modal">${nearPlayers[i]["name"]} (${Math.round(nearPlayers[i]["id"])})</button>
				</div>`;
			}
		}
		element += `</div>`;

		$('#nearPlayersDiv').html(element);
	}
}

$('#view_invoice_payall').click(function(){
	$.post('https://okokBilling/action', JSON.stringify({
        action: "payAllInvoices",
    }));
})

$('#payreference').click(function (){
	$('#payreference_receiver').html("No Info Available")
	$('#payreference_amount').html("No Info Available")
	$('#payreference').prop('disabled', true);
	$('#payreference_receiver').addClass("payreference_noinfo");
	$('#payreference_amount').addClass("payreference_noinfo");
	$.post('https://okokBilling/action', JSON.stringify({
        action: "payReference",
		ref_id: $('#payreference_search').val()
    }));
})

function payInvoice(ref, type){
	$.post('https://okokBilling/action', JSON.stringify({
        action: "payInvoice",
		ref_id: ref,
		type: type
    }));
}

function renderDetails(id) {
	var invoice = DetailsInvoices[id];
	var type = 'pay'

	if(selectedWindow == 'all_invoices' || selectedWindow == "society_invoices"){
		type = 'cancel'
	}

	if(invoice['status'] == "autopaid"){
		invoice['status'] = "paid"
	}

	if(invoice["notes"] == ""){
		$(`#${invoice['status']}_view_invoice_note`).hide();
	} else {
		$(`#${invoice['status']}_view_invoice_note`).show();
	}

	$(`#${invoice['status']}_view_invoice_number`).html(invoice["id"])
	$(`#${invoice['status']}_view_invoice_id`).html(invoice["ref_id"])
	$(`#${invoice['status']}_view_invoice_sent`).html(invoice["sent_date"])
	$(`#${invoice['status']}_view_invoice_due`).html(invoice["limit_pay_date"])
	$(`#${invoice['status']}_view_invoice_from`).html(invoice["author_name"])
	$(`#${invoice['status']}_view_invoice_to`).html(invoice["receiver_name"])
	if(invoice['society'] == ""){
		$(`#${invoice['status']}_view_invoice_from`).html(invoice["author_name"])
	}
	else{
		$(`#${invoice['status']}_view_invoice_from`).html(invoice["society_name"])
	}
	$(`#${invoice['status']}_view_invoice_item`).html(invoice["item"])

	var price = invoice["invoice_value"];
	var vat = price * (vatPercentage / 100);
	var subtotal = price - vat;
	$(`#${invoice['status']}_view_invoice_vat_percentage`).html(vatPercentage)
	$(`#${invoice['status']}_view_invoice_item_price`).html(Math.round(subtotal) + " €")
	$(`#${invoice['status']}_view_invoice_subtotal_price`).html(Math.round(subtotal) + " €")
	$(`#${invoice['status']}_view_invoice_vat_price`).html(Math.round(vat) + " €")
	$(`#${invoice['status']}_view_invoice_total_price`).html(price + " €")
	$(`#${invoice['status']}_view_invoice_note`).html(invoice["notes"])
	$(`#${invoice['status']}_view_invoice_pay`).attr('onclick', `payInvoice("${invoice["ref_id"]}", "${type}")`);

	if(invoice['status'] == 'paid'){
		$('#paid_view_invoice_paid_date').html(invoice['paid_date'])
	}

	if(selectedWindow == 'all_invoices' || selectedWindow == "society_invoices"){
		$('#unpaid_view_invoice_pay').prop('disabled', false);
		$(`#unpaid_view_invoice_pay`).html(`CANCEL</button>`);
		$('#unpaid_view_invoice_pay').addClass("btn-red");
	} else {
		$('#unpaid_view_invoice_pay').prop('disabled', false);
		$('#unpaid_view_invoice_pay').html(`PAY</button>`);
		$('#unpaid_view_invoice_pay').removeClass("btn-red");
	}
	
};

$('#payreference_search').on('input', function(evt) {
  $(this).val(function(_, val) {
    return val.toUpperCase();
  });
});

function checkIfEmpty(){
	var item, price;

	if($("#invoiceNormal").css('display') == 'block') {
		item = $('#normal_createinvoice_item').val();
		price = $('#normal_createinvoice_price').val();
	}
	else{
		if( $("#invoiceBillsList").css('display') == 'block') {
			item = $('#stp_item').find(':selected').text();
			price = $('#bill_createinvoice_price').val();
		}
		else{
			item = $('#custom_createinvoice_item').val();
			price = $('#custom_createinvoice_price').val();
		}
	}

	if (item.length > 0 && price > 0) {
		$('#createinvoice').prop('disabled', false);
	}
	else{
		$('#createinvoice').prop('disabled', true);
	}
}

function checkReference(){
	var ref = $('#payreference_search').val()

	$.post('https://okokBilling/action', JSON.stringify({
        action: "checkRef",
        ref: ref,
    }));
}

function lookcitizen(){
	fetch(`https://okokBilling/action`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json; charset=UTF-8',
		},
		body: JSON.stringify({
			action: "lookCitizen",
			player_id: $('#police_search').val()
		})
	}).then(resp => resp.json()).then(resp => renderCitizen(resp));
}

function renderCitizen(resp){
	var unpaidInvoices = 0
	var unpaidAmount = 0
	if(resp[0] != undefined){
		resp.forEach(invoice => {
			if(invoice["status"] == "unpaid"){
				unpaidInvoices += 1;
				unpaidAmount += Number(invoice["invoice_value"])
			}
		});

		$('#police_unpaidinvoices').html(unpaidInvoices);
		$('#police_unpaidamount').html(unpaidAmount);
		$('#police_unpaidinvoices').removeClass("police_noinfo");
		$('#police_unpaidamount').removeClass("police_noinfo");
	} else {
		$('#police_unpaidinvoices').html('No Info Available');
		$('#police_unpaidamount').html('No Info Available');
		$('#police_unpaidinvoices').addClass("police_noinfo");
		$('#police_unpaidamount').addClass("police_noinfo");
	}
}


$(document).ready(function() {
	document.onkeyup = function(data) {
		if (data.which == 27) {
			if(selectedWindow == 'selection_menu'){
				document.getElementById('closeSelectionMenu').click();
			} else if(selectedWindow == 'my_invoices' || selectedWindow == 'my_invoices_toggle'){
				document.getElementById('closeInvoicesMenu').click();
			} else if(selectedWindow == 'society_invoices'){
				document.getElementById('closeSocietyInvoicesMenu').click();
			} else if(selectedWindow == 'all_invoices'){
				document.getElementById('closeCityInvoicesMenu').click();
			} else if(selectedWindow == 'pay_reference'){
				document.getElementById('closePayReferenceMenu').click();
			} else if(selectedWindow == 'create_invoices' || selectedWindow == 'direct_create_invoices'){
				document.getElementById('closeCreateInvoiceMenu').click();
			} else if(selectedWindow == 'inspect_citizen'){
				document.getElementById('closePoliceMenu').click();
			} else if(selectedWindow == 'loading'){
				$('.loading_menu').fadeOut();
				isLoading = false;
				$.post('https://okokBilling/action', JSON.stringify({
			        action: "close"
			    }));
			}
			$('.modal').modal('hide');
		}
	};
});
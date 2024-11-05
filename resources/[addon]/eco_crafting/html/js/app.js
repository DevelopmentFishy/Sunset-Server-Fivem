const player = new Player();
const model = new Model();
const view = new View();
const resourceName = GetParentResourceName();

let translation = {};
let imagePath = '/';

let computedStyle;
let baseFontSize;

const numberFormat = function (num) {

    return (num === undefined || !num) ? 0 : num.toLocaleString('hu-HU');
};

const lang = function (key) {

    return (translation[key]) ? translation[key] : key;
};


let $required_qty = $('#required_qty');
let $container = $('#container');
let $historyBtn = $('#history_btn');
let $craft = $('#craft');
let $q = $('#q');

computedStyle = getComputedStyle(document.documentElement);
baseFontSize = parseInt(computedStyle.getPropertyValue('--html-font-size'));

$required_qty.val(1);


$container.draggable({
    handle: '.head',
    containment: 'parent'
});


//FIND ITEM
$q.on('keyup', function () {

    model.queryString = $q.val();
    view.lister();
});


//CRAFT BTN
$craft.on('click', function () {

    if (model.controlButtonEnabled && model.loadedRecipe.maxProduct && model.loadedRecipe.maxProduct > 0) {

        let qty = $required_qty.val();

        $.post(`https://${resourceName}/craftRequest`, JSON.stringify({
            productName: model.loadedRecipe.product,
            productRequest: (!qty || qty.trim() === '' || qty < 1) ? 1 : qty
        }));

        model.session = {
            inProgress: true,
            productName: model.loadedRecipe.product,
            productionTime: model.loadedRecipe.recipe.cTime
        };

        view.controlButtons();
        view.ongoingItemMarker();
    }
});


//CANCEL BTN
$('#cancel').on('click', function () {

    if (model.controlButtonEnabled) {

        $.post(`https://${resourceName}/craftCancel`);

        model.session = {
            inProgress: false,
        };
    }
});


$historyBtn.on('click', function (e) {

    e.preventDefault();
    model.history = -1;
    view.loadRecipe(model.history[model.history.length - 1]);
});


//CLOSE BUTTON
$('#close').on('click', function () {

    $container.fadeOut();
    $.post(`https://${resourceName}/exit`);
});


$(document).on('keypress', function (e) {

    if (e.which === 13) {

        e.preventDefault();
    }
});


$(document).on('keyup', function (e) {

    if (e.which === 27) {

        $container.fadeOut();
        $.post(`https://${resourceName}/exit`);
    }
});


//MAX QTY BUTTON
$('#max_qty').on('click', function () {

    if (model.loadedRecipe.maxProduct > 0) {

        $required_qty.val(model.loadedRecipe.maxProduct);
    }
});


//QTY INPUT FIELD
$required_qty.on('change', function () {

    let input = $required_qty;
    let v = input.val();
    let max = model.loadedRecipe.maxProduct < 1 ? 1 : model.loadedRecipe.maxProduct;
    input.val(v < 1 ? 1 : (v > max ? max : v));
});

//SEND READY MESSAGE
$.post(`https://${resourceName}/nuiReady`);


// Listen for NUI Events
window.addEventListener('message', function (event) {

    let item = event.data;

    switch (item.subject) {

        case 'POPUP':

            view.popUp(item);
            break;

        case 'UPDATE':

            if (item.playerData) {

                player.update = item.playerData;
                view.updatePlayer();
                view.updateList();
            }


            if (item.session) {

                model.session = item.session;
                view.ongoingItemMarker();
            }


            //reload recipe
            if (model.loadedRecipe.product && !item.noReload) {

                view.loadRecipe(model.loadedRecipe.product);
                view.updateQtyValue();
            }

            break;

        case 'INIT':

            translation = item.translation || {};
            imagePath = item.imagePath;

            model.init = item;
            player.init = item;
            view.init();
            break;

        case 'OPEN':

            if (!item.session.inProgress) {

                model.unloadRecipe();
                view.unloadRecipe();
            }

            player.update = item.playerData;
            model.zone = item.zoneData;
            model.session = item.session;

            view.pageSwitch('craft');
            view.openPage();

            //reload recipe
            if (model.loadedRecipe.product) {

                view.loadRecipe(model.loadedRecipe.product);
            }
            break;

        case 'CLOSE':

            $('#container').fadeOut();
            break;

        case 'COPY':

            let input = document.createElement('input');
            input.value = item.string;
            document.body.appendChild(input);
            input.select();
            document.execCommand('copy');
            document.body.removeChild(input);
            break;
    }

});
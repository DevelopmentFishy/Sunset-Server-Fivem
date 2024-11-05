class View {

    _slots = 10;

    init() {

        let $conditionsParent = $('.conditions');
        let $paramsParent = $('.player_params');
        let $btnParent = $('#screen_btn_container');
        let $uiSizeBtnParent = $('#size_btn_container');
        let $orderByParent = $('#order_container');

        if (model.systemMode.profession) {

            //Add conditions li
            $("<li/>", {
                "html": `<span class="li_label">${lang('proficiency')}</span>
                        <span class="required_proficiency_container">-</span>`,
            }).appendTo($conditionsParent);

            //Add screen btn
            $("<a/>", {
                "text": lang('stat_screen_btn'),
                "href": '#',
                "id": 'stat_screen_btn',
                "class": 'btn',
                "click": function (e) {
                    e.preventDefault();
                    view.pageSwitch('stat');
                }
            }).appendTo($btnParent);

            $("<a/>", {
                "text": lang('craft_screen_btn'),
                "href": '#',
                "id": 'craft_screen_btn',
                "class": 'btn',
                "click": function (e) {
                    e.preventDefault();
                    view.pageSwitch('craft');
                }
            }).appendTo($btnParent);

            //order By contain
            $orderByParent.html(`<span>${lang('order_by')}</span>`);

            $("<input/>", {
                "type": 'button',
                "class": 'order_by_btn selected',
                "value": 'ABC',
                "click": function () {

                    if (model.orderBy !== 'abc') {

                        $('.order_by_btn').removeClass('selected');
                        $(this).addClass('selected');

                        model.orderBy = 'abc';
                        view.lister();
                    }
                }
            }).appendTo($orderByParent);

            $("<input/>", {
                "type": 'button',
                "class": 'order_by_btn',
                "value": lang('proficiency'),
                "click": function () {

                    if (model.orderBy !== 'proficiency') {

                        $('.order_by_btn').removeClass('selected');
                        $(this).addClass('selected');

                        model.orderBy = 'proficiency';
                        view.lister();
                    }
                }
            }).appendTo($orderByParent);
        } else {

            $orderByParent.remove();
            $('#head_form').css('grid-template-columns', '1fr');
        }

        if (model.systemMode.labor) {

            $("<li/>", {
                //Add conditions li
                "html": `<span class="li_label">${lang('labor')}</span>
                         <span class="required_labor_container">-</span>`,
            }).appendTo($conditionsParent);


            //Add params li
            $("<li/>", {
                "html": `<span class="li_label">${lang('labor')}</span>
                         <span class="labor_container"></span>`,
            }).appendTo($paramsParent);

        }

        if (model.systemMode.money) {

            //Add conditions li
            $("<li/>", {
                "html": `<span class="li_label">${lang('price')}</span>
                         <span class="price">-</span>`,
            }).appendTo($conditionsParent);

            //Add params li
            $("<li/>", {
                "html": `<span class="li_label">${lang('cash')}</span>
                         <span class="cash"></span>`,
            }).appendTo($paramsParent);
        }

        if (model.displayComponent.chance && model.systemMode.chance) {

            //Add chance li
            $("<li/>", {
                "html": `<span class="li_label">${lang('chance')}</span>
                         <span class="chance">-</span>`,
            }).appendTo($conditionsParent);
        }

        if (model.displayComponent.uiSizeBtn) {

            //Add UI size btns
            $("<a/>", {
                "text": '-',
                "href": '#',
                "id": 'sizeMinus',
                "class": 'ui_size_btn btn',
                "click": function (e) {
                    e.preventDefault();

                    let current = parseInt(computedStyle.getPropertyValue('--html-font-size'));

                    if (current > baseFontSize - 2) {

                        document.documentElement.style.setProperty('--html-font-size', (current - 1) + "px");
                    }
                }
            }).appendTo($uiSizeBtnParent);

            $("<a/>", {
                "text": '+',
                "href": '#',
                "id": 'sizePlus',
                "class": 'ui_size_btn btn',
                "click": function (e) {
                    e.preventDefault();

                    let current = parseInt(computedStyle.getPropertyValue('--html-font-size'));

                    if (current < baseFontSize + 2) {

                        document.documentElement.style.setProperty('--html-font-size', (current + 1) + "px");
                    }
                }
            }).appendTo($uiSizeBtnParent);
        }


        //translation HTML
        $.each($('*[data-lang]'), function () {

            let $this = $(this);
            let txt = lang($this.data().lang);

            if ($this.prop('nodeName') === 'INPUT') {

                ($this.prop('type') === 'text') ? $this.attr("placeholder", txt) : $this.val(txt);
            } else {

                $this.text(txt);
            }
        });


        //Add empty slots
        let ingredientsDiv = $('.ingredients');
        ingredientsDiv.empty();


        for (let i = 0; i < this._slots; i++) {

            $("<div/>", {
                "class": "slot",
            }).appendTo(ingredientsDiv);
        }

        //footer tips:
        let tips = [];
        $.each(translation, function (key, txt) {

            if (key.substring(0, 5) === 'tips.') {

                tips.push(txt);
            }
        });

        if (tips.length > 0) {

            model.shuffleArray(tips);

            let i = 0;
            let $footer = $('.footer');
            $footer.text(tips[i]).fadeIn();

            setInterval(function () {

                $.when($footer.fadeOut()).done(function () {

                    i++;
                    i = (tips[i]) ? i : 0;
                    $footer.text(tips[i]).fadeIn();
                });

            }, 30000);
        }
    }

    get slots() {

        return this._slots;
    }

    openPage() {

        //SET CRAFT PAGE
        $('#head_row2').css('display', 'block');
        $('.craft_main').css('display', 'grid');
        $('.stat_main').css('display', 'none');

        let val = model.session.productRequest < 1 ? 1 : model.session.productRequest;

        $('#required_qty').val(val);

        this.lister();
        this.updatePlayer();

        $("#container").fadeIn();
    }

    updateList(data) {

        let parent;
        let playerProficiency;

        data = (typeof data === 'object') ? data : model.filteredCraftData;

        $.each(data, function (profession, recipes) {

            parent = $('.list_parent_' + profession);
            playerProficiency = player.metadata.proficiency[profession] || 0;

            $.each(recipes, function (product, recipe) {

                model.recipe = {
                    'profession': profession,
                    'product': product,
                    'recipe': model.calcRecipeData(recipe, profession),
                };

                let maxProduct = model.maxProduct;

                if (maxProduct > 0) {

                    let statusClass = model.checkConditions(maxProduct) ? 'available_piece' : 'not_available_piece';

                    parent.find('.max_' + product).text(maxProduct).removeClass('not_available_piece').addClass(statusClass);
                } else {

                    parent.find('.max_' + product).text('').removeClass('available_piece not_available_piece');
                }

                if (model.displayComponent.hideHigherProficiencyItems) {

                    if (playerProficiency >= recipe.proficiency) {

                        parent.find(`[data-product="${product}"]`).css('display', 'flex');
                    } else {

                        parent.find(`[data-product="${product}"]`).css('display', 'none');
                    }
                }
            });
        });
    }

    updatePlayer() {

        let alertClass;

        // updateWeight
        let current = (player.inventoryWeight * 0.001).toFixed(1);
        let limit = (model.weightCap * 0.001).toFixed(1);

        alertClass = (limit * 0.75 < current) ? 'low_alert' : '';
        alertClass = (limit * 0.90 < current) ? 'high_alert' : alertClass;

        $('.weight_container').html(`<span class="${alertClass}">${current}</span> / <span>${limit}kg</span>`);


        //updateLabor
        if (model.systemMode.labor) {

            current = player.metadata.labor.point;
            limit = model.laborCap;

            alertClass = (500 > current) ? 'low_alert' : '';
            alertClass = (100 > current) ? 'high_alert' : alertClass;

            $('.labor_container').html(`<span class="${alertClass}">${ numberFormat(current) } / ${ numberFormat(limit) }</span>`);
        }

        //updateCash
        if (model.systemMode.money) {

            $('.cash').html(model.formatMoney(player.money.cash));
        }


        //updateProficiency page
        if (model.systemMode.profession) {

            let container = $('#proficiency_stat_container');

            if (container.html().trim() === '') {

                this.createProficiencyStatsHtml()
            }

            let ranks = player.ranks;
            let maxLevel = player.maxLevel;
            let progress = 0;
            let level = 0;

            $.each(player.metadata.proficiency, function (profession, point) {

                if (typeof ranks === 'object' && ranks[profession]) {

                    let rank = ranks[profession];
                    level = (rank.level === maxLevel) ? 'famed' : rank.level;
                    progress = rank.progress;

                } else {

                    level = 0;
                    progress = (model.proficiencyCap <= point) ? 100 : Math.round((100 / model.proficiencyCap) * point);
                }

                container.find(`#${ profession }_name`).attr("class", `name level lvl_${ level }`);
                container.find(`.${ profession }_progress`).css('width', progress + '%');
                container.find(`.${ profession }_point`).text(numberFormat(point));
            });
        }
    }

    unloadRecipe() {

        $('.target_item_name').html(lang('select_product'));
        $('#required_workbench').text('').removeAttr('class data-special');

        let targetItem = $('.target_item .slot');
        targetItem.css("background-image", 'none');
        targetItem.find(".amount").text('');

        if (model.systemMode.labor) {

            $('.required_labor_container').html('-');
        }

        if (model.systemMode.money) {

            $('.price').html('-');
        }

        if (model.displayComponent.chance && model.systemMode.chance) {

            $('.chance').html('-');
        }

        if (model.systemMode.profession) {

            $('.required_proficiency_container').html('-');
        }

        let ingredientsDiv = $('.ingredients');

        ingredientsDiv.empty();

        for (let i = 0; i < this._slots; i++) {

            $("<div/>", {
                "class": "slot",
            }).appendTo(ingredientsDiv);
        }

        /* CONTROL BUTTONS */
        $('#required_qty').val(1).prop('disabled', true);
        $('#craft').prop('disabled', true);
        $('#max_qty').prop('disabled', true);
        $('#cancel').prop('disabled', true);

        let $controlContainer = $('.control_container');

        $controlContainer.find('#condition_report').remove();
        $controlContainer.removeClass('condition_report');
        $controlContainer.find('form').show();
    }

    updateLoadedRecipe() {

        let alertClass;
        let recipeData = model.loadedRecipe;
        let recipe = recipeData.recipe;
        let profession = recipeData.profession;

        //updateRequiredLabor
        if (model.systemMode.labor) {

            alertClass = (recipe.cLabor > player.metadata.labor.point) ? 'high_alert' : '';

            $('.required_labor_container').html(`<span class="${alertClass}">${ numberFormat(recipe.cLabor) }</span>`);
        }


        //updatePrice
        if (model.systemMode.money) {

            alertClass = (recipe.cPrice > player.money.cash) ? 'high_alert' : '';

            let out = `<span class="${alertClass}">${ model.formatMoney(recipe.cPrice) }</span>`;

            $('.price').html(out);
        }


        if (model.displayComponent.chance && model.systemMode.chance) {

            $('.chance').html(`${recipe.cChance}%`);
        }


        //updateProficiency
        if (model.systemMode.profession) {

            alertClass = (recipe.proficiency > player.metadata.proficiency[profession]) ? 'high_alert' : '';

            $('.required_proficiency_container').html(
                `<span class="${alertClass}">${
                    numberFormat(player.metadata.proficiency[profession]) } / ${ numberFormat(recipe.proficiency)
                    }</span>`
            );
        }

        //update control
        this.controlButtons()
    }

    controlButtons() {

        if (!model.controlButtonEnabled) {
            return false
        }

        let $cancel = $('#cancel');
        let $craft = $('#craft');
        let $controlContainer = $('.control_container');
        let $forms = $controlContainer.find('form');
        let $reportDiv = $controlContainer.find('#condition_report');

        model.controlButtonEnabled = false;

        //btn switch
        if (model.session.inProgress) {

            $craft.prop('disabled', true);
            $('#required_qty').prop('disabled', true);
            $('#max_qty').prop('disabled', true);

            $.when($craft.fadeOut(800)).done(function () {

                $cancel.prop('disabled', false);

                $.when($cancel.fadeIn(800)).done(function () {

                    model.controlButtonEnabled = true;

                    if (!model.session.inProgress) {

                        $cancel.prop('disabled', true);
                        view.controlButtons();
                    }
                });
            });

        } else {

            $.when($cancel.fadeOut(800)).done(function () {

                $.when($craft.fadeIn(800)).done(function () {

                    model.controlButtonEnabled = true;

                    if (model.session.inProgress) {

                        view.controlButtons();
                    }
                });
            });


            //REPORT HANDLE
            model.recipe = model.loadedRecipe;

            if (model.workstation === 'all') {

                $craft.prop('disabled', true);
                $cancel.prop('disabled', true);
                $('#required_qty').prop('disabled', true);
                $('#max_qty').prop('disabled', true);

                $reportDiv.remove();
                $controlContainer.removeClass('condition_report');
                $forms.show();

            } else {

                if (model.checkConditions(model.loadedRecipe.maxProduct)) {

                    $('#required_qty').prop('disabled', false);
                    $('#max_qty').prop('disabled', false);
                    $craft.prop('disabled', false);

                    $reportDiv.remove();
                    $controlContainer.removeClass('condition_report');
                    $forms.show();

                } else {

                    $forms.hide();
                    $controlContainer.addClass('condition_report');

                    let html = lang(model.conditionReport === '' ? 'not_possible' : model.conditionReport);

                    if ($reportDiv.length) {

                        $reportDiv.html(html);
                    } else {

                        $("<div/>", {
                            "html": html,
                            "id": "condition_report",
                        }).appendTo($controlContainer.slideDown(500));
                    }
                }
            }
        }
    }

    updateQtyValue() {

        let input = $('#required_qty');

        if (model.session.inProgress) {

            input.val(model.session.productRequest - model.session.productDone);
        } else {

            input.val(1);
        }
    }

    createProficiencyStatsHtml() {

        let container = $('#proficiency_stat_container');
        let firstLetter = '';
        let bgImage = '';
        let colors = [
            "#ec6f86",
            "#4573e7",
            "#d187ef",
            "#fe816d",
            "#7e69ff",
            "#ffba6d",
            "#b2f068",
            "#45b4e7",
            "#ad61ed"];


        let proficiencyArray = [];

        $.each(player.metadata.proficiency, function (profession, point) {

            if (model.craftData[profession]) {

                proficiencyArray.push([profession, point, lang(profession)])
            }
        });

        proficiencyArray.sort((a, b) => a[2].localeCompare(b[2]));

        let colorIdx = 0;

        let parent = $("<ul/>", {
            "class": "proficiency_stats",
        }).appendTo(container);

        proficiencyArray.forEach(function (proficiencyData) {

            if (model.displayComponent.professionIcon) {

                bgImage = `background-image: url(img/${ proficiencyData[0] }.png)`;
            } else {

                firstLetter = proficiencyData[2].substring(0, 1);
            }

            $("<li/>", {
                "html": `<span 
                    style="background-color: ${colors[colorIdx]};${ bgImage }" 
                    class="icon">${ firstLetter }</span>
                    <span class="data">
                        <span class="name" id="${ proficiencyData[0] }_name">${ proficiencyData[2] }</span>
                        <span class="${ proficiencyData[0] }_point point">${ numberFormat(proficiencyData[1]) }</span>
                        <div class="bar">
                            <div class="${ proficiencyData[0] }_progress progress"></div>
                        </div>
                    </span>`
            }).appendTo(parent);

            colorIdx++;

            if (colorIdx >= colors.length) {

                colorIdx = 0;
            }
        });
    }

    loadRecipe(name) {

        model.loadRecipe = name;

        let recipeData = model.loadedRecipe;

        let slots = view.slots;

        let itemData = model.itemList[name];
        let label = itemData.label;
        let image = itemData.image;
        let imageUrl = imagePath + image;

        let ingredientsDiv = $('.ingredients');
        let targetItem = $('.target_item .slot');

        let recipe = recipeData.recipe;
        let profession = recipeData.profession;
        let special = recipe.special ? ' special' : '';
        let req_workbench_class = (profession === model.workstation) ? '' : 'red';

        $('.target_item_name').html(label);
        $('#required_workbench')
            .text(lang(profession))
            .removeAttr('class data-special')
            .addClass(`${ req_workbench_class } ${ special }`)
            .attr('data-special', recipe.special);

        targetItem.css("background-image", `url(${ imageUrl })`);
        targetItem.find(".amount").text(Math.abs(recipe.amount));


        //DISABLE / ENABLE BUTTONS
        this.updateLoadedRecipe();

        //Highlight menu button
        $('li').removeClass('selected');
        $(`li[data-product="${ recipeData.product }"]`).addClass('selected');

        ingredientsDiv.empty();

        if (model.history.length > 1) {

            $('#history_btn').css("display", "inline-block");
        } else {

            $('#history_btn').hide();
        }


        let ingredientArray = Object.entries(recipe.ingredients);

        ingredientArray.map(c => {

            let d = model.itemList[c[0]] || {};
            c.push(d.label);
            c.push(d.image);
        });

        ingredientArray.sort((a, b) => a[2].localeCompare(b[2]));

        ingredientArray.forEach(function (item) {

            let ingredient = item[0];
            let amount = Math.abs(item[1]);
            let label = item[2];
            let image = item[3];

            let playerIngredientAmount = (player.inventory[ingredient]) ? player.inventory[ingredient] : 0;

            slots--;

            let amountTxt = `${playerIngredientAmount} / ${amount}`;
            let amountClass = (playerIngredientAmount >= amount) ? '' : ' red';
            let permanentClass = (item[1] < 0) ? 'permanent' : '';

            let slot = $("<div/>", {
                "class": `slot tooltip ${ permanentClass }`,
                "style": `background-image: url(${ imagePath }${ image })`,
                "data-details": label,
            }).appendTo(ingredientsDiv);

            $("<span/>", {
                "text": amountTxt,
                "class": `text_shadow ${ amountClass }`,
            }).appendTo(slot);

            $("<span/>", {
                "text": label,
                "class": "tooltiptext",
            }).appendTo(slot);


            model.recipe = {
                product: ingredient,
                noCalc: true
            };

            if (!$.isEmptyObject(model.recipe)) {

                slot.addClass('ingredientProduct');
                slot.on('click', function () {
                    model.history = ingredient;
                    view.loadRecipe(ingredient);
                });
            }

        });


        for (let i = 0; i < slots; i++) {

            $("<div/>", {
                "class": "slot",
            }).appendTo(ingredientsDiv);
        }

        //max required input reset
        if (!model.session.inProgress) {

            $('#required_qty').val(1);
        }
    }

    lister() {

        let parent, img, selected;

        let openList = model.selectedProfession !== 'all' || model.queryString.length > 0;

        let parentClass = openList ? "" : "ulClose";
        let container = $('.left_column');
        container.empty();

        let filteredData = model.filteredCraftData;

        if ($.isEmptyObject(filteredData)) {

            $("<div/>", {
                "html": `<span class="msg_header">Ooooops!</span><span>${ lang('no_hits') }</span>`,
                "class": 'no_hits',
            }).appendTo(container);
        } else {

            let data = model.objectSort(filteredData);
            let loadedProduct = model.loadedRecipe.product;

            $.each(data, function (profession, recipes) {

                if (model.selectedProfession === 'all') {
                    $("<a/>", {
                        "text": lang(profession),
                        "href": '#',
                        "class": `profession_head no_href ${ parentClass }`,
                        "click": function () {
                            let a = $(this);
                            $(`.list_parent_${ profession }`).slideToggle(200, function () {
                                a.toggleClass('ulClose')
                            });
                            return false;
                        }
                    }).appendTo(container);
                }

                parent = $("<ul/>", {
                    "class": `product_list list_parent_${ profession }`,
                    "style": (openList) ? "" : "display: none;"
                }).appendTo(container);


                $.each(recipes, function (product, recipe) {

                    img = model.itemList[product] ? imagePath + model.itemList[product].image : '';
                    selected = (loadedProduct === product) ? 'selected' : '';

                    $("<li/>", {
                        "html": `<span class="list_img img_${ product }" style="background-image: url(${ img })"></span>
                        <span>${ recipe.label }</span>
                        <span class='max_${ product }'></span>`,
                        "data-product": product,
                        "class": selected,
                        "click": function () {
                            model.history = false;
                            model.history = product;
                            view.loadRecipe(product);
                        }
                    }).appendTo(parent);
                });
            });

            this.updateList(data)
        }
    }

    pageSwitch(page) {

        let $main_heading = $('#main_heading');
        let $head_row2 = $('#head_row2');
        let $craft_main = $('.craft_main');
        let $stat_main = $('.stat_main');

        switch (page) {
            case 'craft':

                $head_row2.css('display', 'block');
                $craft_main.css('display', 'grid');
                $stat_main.css('display', 'none');

                let headingClass = model.special ? 'special' : '';

                $main_heading
                    .text(lang(model.workstation))
                    .removeClass('special')
                    .addClass(headingClass)
                    .attr('data-special', model.special);
                break;
            case 'stat':

                $main_heading
                    .text(lang('stat_screen_btn'))
                    .removeClass('special')
                    .removeAttr('data-special');
                $head_row2.css('display', 'none');
                $craft_main.css('display', 'none');
                $stat_main.css('display', 'block');
                break;
        }
    }

    //TIMER

    formatTime(t) {
        let m = Math.floor(t / 60), s = t % 60;
        return `${m}:${s > 9 ? s : '0' + s}`;
    }

    startTimer() {

        let dashArray = Math.round(Math.PI * 2 * 25);
        let timerInterval;
        let elapsedTime = 0;
        let left = 0;
        let time = model.session.productionTime;

        let step = dashArray / time;
        let offset = step.toFixed(2) * 1;

        let $timer = $('.progress_timer');
        let $progress = $('.progress_bar');

        $progress.css({'transition': 'none', 'stroke-dasharray': dashArray, 'stroke-dashoffset': 0});
        $timer.text(this.formatTime(time));
        $progress.hide().show(200);
        $progress.css({'transition': '1s linear stroke-dashoffset', 'stroke-dashoffset': offset});

        timerInterval = setInterval(() => {

            left = time - ++elapsedTime;
            $timer.text(this.formatTime(left));

            if (left > 0) {

                offset = (offset + step).toFixed(2) * 1;
                $progress.css('stroke-dashoffset', offset)
            } else {

                clearInterval(timerInterval);
            }

        }, 1000);
    }

    ongoingItemMarker() {

        let obj = $('#current_craft');

        if (model.session.inProgress) {

            let product = model.session.productName;

            if (obj.length) {

                //restart timer
                this.startTimer();
            } else {

                let itemData = model.itemList[product];
                let imageUrl = imagePath + itemData.image;

                $("<div/>", {
                    "html": `<div class='progress_timer'>0:00</div>\n` +
                    "    <svg width='100%' height='100%' viewBox='0 0 60 60'>\n" +
                    "        <circle cx='50%' cy='50%' r='25' class='progress_base'></circle>\n" +
                    "        <circle cx='50%' cy='50%' r='25' class='progress_bar'></circle>\n" +
                    "    </svg>",
                    "id": "current_craft",
                    "style": `background-image: url(${ imageUrl }); display:none;`,
                    "click": function () {

                        if (model.loadedRecipe.product !== product) {

                            model.history = false;
                            model.history = product;
                            view.loadRecipe(product);
                        }
                    }
                }).prependTo($('.control_container')).fadeIn(800);

                this.startTimer();
            }
        } else {

            if (obj.length) {

                $.when(obj.fadeOut(800)).done(function () {

                    obj.remove();
                });
            }
        }
    }

    popUp(data) {

        let maxLevel = player.maxLevel;
        let display = data.level;
        let color;

        if (data.level === maxLevel) {

            display = "⭐";
            color = computedStyle.getPropertyValue('--lvl-famed-color');
        } else {

            display = data.level;
            color = computedStyle.getPropertyValue(`--lvl-${ data.level }-color`);
        }

        let popup = $("<div/>", {
            "style": `border-color:${ color }; box-shadow: 0 0 3rem ${ color };`,
            "id": "popup_container",
            "html": `<h1>${ lang('level_up') }</h1>
                    <h2>${ lang(data.profession) }</h2>
                    <span class="up_level" style="background-color:${ color };">${ display }</span>
                    <span class="level_name" style="color:${ color };">${ lang('rank' + data.level) }</span>`
        }).appendTo($('body'));

        setTimeout(() => {

            $.when(popup.fadeOut(800)).done(function () {

                popup.remove();
            });
        }, 5000);

    }
}
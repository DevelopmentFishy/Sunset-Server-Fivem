class Model {

    _conditionReport = '';
    _selectedProfession = 'all';
    _orderBy = 'abc';
    _queryString = '';
    _history = [];

    _controlButtonEnabled = true;

    _workstation = 'all';
    _special;

    _recipe = {};
    _loadedRecipe = {};

    set init(data) {

        this._craftData = data.craftData || {};
        this._itemList = data.itemList || {};
        this._weightCap = data.weightCap || 0;
        this._laborCap = data.laborCap || 0;
        this._systemMode = data.systemMode || {};
        this._currency = data.currency || {};
        this._proficiencyCap = data.proficiencyCap || 0;
        this._session = data.session || {};
        this._displayComponent = data.displayComponent || {};

        $.each(this._craftData, function (profession, recipes) {

            $.each(recipes, (k, v) => {

                v.searchLabel = v.label.normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase();
            });
        });
    }

    unloadRecipe() {

        this._queryString = '';
        this._conditionReport = '';
        this._history = [];
        this._loadedRecipe = {};
        this._recipe = {};
        this._selectedProfession = 'all';
    }

    set session(session) {

        $.each(session, (k, v) => {

            this._session[k] = v;
        });
    }

    set zone(data) {

        this._workstation = (data.workstation === 'recipe_collection') ? 'all' : data.workstation;
        this._special = data.special;
        this._selectedProfession = this._workstation
    }

    set recipe(data) {

        if (data.recipe !== undefined) {

            this._recipe = data;
        } else {

            let found = {};
            let product = data.product;
            let noCalc = data.noCalc;

            $.each(model.craftData, function (profession, recipes) {

                if (recipes[product]) {

                    let recipe = recipes[product];

                    if (!noCalc) {

                        recipe = model.calcRecipeData(recipe, profession)
                    }

                    found = {
                        'profession': profession,
                        'product': product,
                        'recipe': recipe,
                    };

                    return false;
                }
            });

            this._recipe = found;
        }
    }

    set loadRecipe(product) {

        this.recipe = {
            product: product
        };
        this._loadedRecipe = this.recipe;
        this._loadedRecipe.maxProduct = model.maxProduct;
    }

    set queryString(string) {

        string = string.trim();

        if (string.length > 0) {

            this._queryString = string.normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase();
        } else {

            this._queryString = '';
        }
    }

    set orderBy(field) {

        this._orderBy = field;
    }

    set controlButtonEnabled(state) {

        this._controlButtonEnabled = state;
    }

    set history(product) {

        if (product === -1) {

            this._history.pop();
            return true;
        }

        if (product) {

            this._history.push(product);
        } else {

            this._history = [];
        }
    }

    get systemMode() {

        return this._systemMode;
    }

    get controlButtonEnabled() {

        return this._controlButtonEnabled;
    }

    get history() {

        return this._history;
    }

    get session() {

        return this._session;
    }

    get special() {

        return this._special
    }

    get craftData() {

        return this._craftData
    }

    get itemList() {

        return this._itemList
    }

    get weightCap() {

        return this._weightCap
    }

    get laborCap() {

        return this._laborCap
    }

    get proficiencyCap() {

        return this._proficiencyCap
    }

    get displayComponent() {

        return this._displayComponent
    }

    get selectedProfession() {

        return this._selectedProfession;
    }

    get queryString() {

        return this._queryString;
    }

    get loadedRecipe() {

        return this._loadedRecipe;
    }

    get filteredCraftData() {

        let q = this.queryString.length > 0 ? this.queryString : false;

        let data = {};
        let result = {};

        if (this.selectedProfession === 'all') {

            data = this.craftData
        } else {

            data[this.selectedProfession] = this.craftData[this.selectedProfession] || {}
        }


        $.each(data, function (profession, recipes) {

            $.each(recipes, function (itemName, recipeData) {

                if (q) {

                    if (recipeData.searchLabel.includes(q)) {

                        if (model.specialAuthorize(recipeData) && model.accessManagement(recipeData)) {

                            if (!result[profession]) {
                                result[profession] = {}
                            }

                            result[profession][itemName] = recipeData;
                        }
                    }
                } else {

                    if (model.specialAuthorize(recipeData) && model.accessManagement(recipeData)) {

                        if (!result[profession]) {
                            result[profession] = {}
                        }

                        result[profession][itemName] = recipeData;
                    }
                }
            });
        });

        return result;
    }

    get workstation() {

        return this._workstation;
    }

    get recipe() {

        return this._recipe
    }

    get maxProduct() {

        let recipe = this.recipe.recipe;
        let inventory = player.inventory;
        let ingredients = recipe.ingredients;


        if (!ingredients || $.isEmptyObject(ingredients)) {
            return 0
        }

        let max = 1000;
        let inventoryAmount = 0;
        let absAmount = 0;

        $.each(ingredients, function (ingredient, amount) {

            absAmount = Math.abs(amount);
            inventoryAmount = inventory[ingredient];

            if (inventoryAmount && inventoryAmount >= absAmount) {

                if (amount > 0) {

                    let result = Math.floor(inventoryAmount / absAmount);
                    max = (result > max) ? max : result;
                }
            } else {

                max = 0;
                return false;
            }
        });


        return max;
    }

    get orderBy() {

        return this._orderBy;
    }

    get conditionReport() {

        return this._conditionReport;
    }

    specialAuthorize(recipe) {

        if (this._workstation === 'all' || !recipe.special) {

            return true
        }

        return recipe.special === this.special
    }

    accessManagement(data) {

        if (data.requiredAcePermission) {

            if (player.aceAllowed[data.requiredAcePermission] !== 1) {

                return false;
            }
        }

        if (!data.exclusive && !data.excluding) {

            return true;
        }

        let authorized = false;
        let level;

        if (data.exclusive) {

            let exclusiveValues = Object.values(data.exclusive);

            authorized = $.inArray(player.job.name, exclusiveValues) !== -1 || $.inArray(player.gang.name, exclusiveValues) !== -1;

            if (!authorized) {

                if (level = data.exclusive[player.job.name]) {

                    authorized = (typeof level !== 'object' || $.isEmptyObject(level)) ? true : $.inArray(player.job.grade.level, level) !== -1;
                }
            }

            if (!authorized) {

                if (level = data.exclusive[player.gang.name]) {

                    authorized = (typeof level !== 'object' || $.isEmptyObject(level)) ? true : $.inArray(player.gang.grade.level, level) !== -1;
                }
            }

        } else if (data.excluding) {

            authorized = $.inArray(player.job.name, data.excluding) === -1 && $.inArray(player.gang.name, data.excluding) === -1;
        }

        return authorized;
    }

    checkConditions(max) {

        let recipeData = this.recipe;
        let profession = recipeData.profession;
        let recipe = recipeData.recipe;

        let calcData = this.calcRecipeData(recipe, profession);

        max = (typeof max === 'undefined') ? this.maxProduct : max;

        if (profession !== this.workstation) {

            this._conditionReport = 'improper_workplace';
            return false;
        } else if (recipe.special && recipe.special !== this.special) {

            this._conditionReport = 'improper_workplace';
            return false;
        } else if (!max || max < 1) {

            this._conditionReport = 'not_enough_materials';
            return false;
        } else if (this.systemMode.profession && player.metadata.proficiency[profession] < recipe.proficiency) {

            this._conditionReport = 'not_enough_proficiency';
            return false;
        } else if (this.systemMode.labor && player.metadata.labor.point < calcData.labor) {

            this._conditionReport = 'not_enough_labor';
            return false;
        } else if (this.systemMode.money && player.money.cash < calcData.price) {

            this._conditionReport = 'not_enough_money';
            return false;
        }

        this._conditionReport = '';
        return true;
    }

    objectSort(obj) {

        let orderBy = this._orderBy;

        let craftDataArray = Object.entries(obj);

        craftDataArray.map(c => {

            c.push(lang(c[0]))
        });

        craftDataArray.sort((a, b) => a[2].localeCompare(b[2]));

        obj = Object.fromEntries(craftDataArray);

        $.each(obj, function (profession, recipes) {

            let recipesArray = Object.entries(recipes);

            if (orderBy === 'proficiency') {

                recipesArray.sort((a, b) => a[1].proficiency - b[1].proficiency);
            } else {

                recipesArray.sort((a, b) => a[1].label.localeCompare(b[1].label));
            }

            obj[profession] = Object.fromEntries(recipesArray);
        });

        return obj;
    }

    /* Randomize array in-place using Durstenfeld shuffle algorithm */
    shuffleArray(array) {
        for (let i = array.length - 1; i > 0; i--) {
            let j = Math.floor(Math.random() * (i + 1));
            let temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }
    }

    formatMoney(amount) {

        amount = numberFormat(amount);
        return this._currency.suffix ? `${amount}${this._currency.symbol}` : `${this._currency.symbol}${amount}`;
    }

    calcRecipeData(recipe, profession) {

        recipe.cLabor = recipe.labor;
        recipe.cTime = recipe.time;
        recipe.cChance = recipe.chance;
        recipe.cPrice = recipe.price;


        //RANK MODIFIER
        let rank = player.ranks[profession];

        if (rank) {

            if (rank.time && rank.time > 0) {

                let time = Math.ceil(recipe.time - (recipe.time / 100) * rank.time);
                recipe.cTime = (time < 2) ? 2 : time;
            }

            if (rank.labor && recipe.labor > 0 && rank.labor > 0) {

                let labor = Math.ceil(recipe.labor - (recipe.labor / 100) * rank.labor);
                recipe.cLabor = (labor < 0) ? 0 : labor;
            }

            if (rank.price && recipe.price > 0 && rank.price > 0) {

                let price = Math.ceil(recipe.price - (recipe.price / 100) * rank.price);
                recipe.cPrice = (price < 0) ? 0 : price;
            }

            if (rank.chance && recipe.chance < 100 && rank.chance > 0) {

                let chance = Math.ceil(recipe.chance + (recipe.chance / 100) * rank.chance);
                recipe.cChance = (chance > 100) ? 100 : chance;
            }
        }

        return recipe
    }
}
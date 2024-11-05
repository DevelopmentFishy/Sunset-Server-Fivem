class Player {

    _inventory = {};
    _inventoryWeight = 0;
    _job = {};
    _gang = {};
    _aceAllowed = {};
    _money = {};
    _metadata = {};
    _ranks = {};

    set init(data) {

        this._rankList = data.ranks || {};
    }

    get inventory() {

        return this._inventory;
    }

    get inventoryWeight() {

        return this._inventoryWeight;
    }

    get metadata() {

        return this._metadata;
    }

    get money() {

        return this._money;
    }

    get job() {

        return this._job;
    }

    get gang() {

        return this._gang;
    }

    get aceAllowed() {

        return this._aceAllowed;
    }

    get ranks() {

        return this._ranks;
    }

    get maxLevel() {

        return this._rankList.length - 1;
    }

    set ranks(metadata) {

        let temp = {};

        $.each(metadata.proficiency, function (profession, proficiency) {

            temp[profession] = player.rankData(proficiency);
        });

        this._ranks = temp;
    }

    set update(playerData) {

        if (typeof playerData.inventory === 'object') {

            this._inventory = playerData.inventory;
        }

        if (typeof playerData.inventoryWeight === 'number') {

            this._inventoryWeight = playerData.inventoryWeight;
        }

        if (typeof playerData.job === 'object') {

            this._job = playerData.job;
        }

        if (typeof playerData.gang === 'object') {

            this._gang = playerData.gang;
        }

        if (typeof playerData.money === 'object') {

            this._money = playerData.money;
        }

        if (typeof playerData.metadata === 'object') {

            this._metadata = playerData.metadata;
            this.ranks = playerData.metadata;
        }

        if (typeof playerData.aceAllowed === 'object') {

            this._aceAllowed = playerData.aceAllowed;
        }
    }

    rankData(proficiency) {

        let numberOfRanks = this._rankList.length;

        if (numberOfRanks === 0 || proficiency === undefined) {

            return false
        }

        let rank = {};

        if (proficiency < this._rankList[0].limit) {

            rank = {...this._rankList[0]};
            rank.level = 0;
            rank.progress = (proficiency > 0) ? Math.floor(proficiency / this._rankList[0].limit * 100) : 0;

            return rank;
        }

        for (let i = 1; i < numberOfRanks; i++) {

            if (this._rankList[i].limit !== undefined && this._rankList[i].limit > proficiency) {
                
                let previous = this._rankList[i - 1];

                let range = this._rankList[i].limit - previous.limit;
                let progress = (proficiency - previous.limit) / range;
                let laborRange = this._rankList[i].labor - previous.labor;
                let timeRange = this._rankList[i].time - previous.time;
                let priceRange = this._rankList[i].price - previous.price;
                let chanceRange = this._rankList[i].chance - previous.chance;

                rank = {...this._rankList[i]};

                rank.progress = Math.floor(progress * 100);
                rank.level = i;
                rank.labor = Math.floor(previous.labor + laborRange * progress);
                rank.time = Math.floor(previous.time + timeRange * progress);
                rank.price = Math.floor(previous.price + priceRange * progress);
                rank.chance = Math.floor(previous.chance + chanceRange * progress);

                return rank
            }
        }

        rank = {...this._rankList[numberOfRanks - 1]};
        rank.level = numberOfRanks - 1;
        rank.progress = 100;

        return rank
    }
}
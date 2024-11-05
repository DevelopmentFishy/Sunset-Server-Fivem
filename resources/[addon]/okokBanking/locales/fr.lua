Locales['fr'] = {

    -- LOCALES LIÉS AU PIN

    ['no_pin'] = {
        title = 'BANKING',
        text = 'Rendez-vous d\'abord dans une banque pour définir un code PIN',
        time = 5000,
        type = 'error'
    },

    ['pin_changed'] = {
        title = 'BANKING',
        text = 'Le code PIN a été remplacé par ${s1}',
        time = 5000,
        type = 'success'
    },

    ['pin_no_money'] = {
        title = 'BANKING',
        text = 'Vous devez disposer de ${s1}€ pour modifier votre code PIN',
        time = 5000,
        type = 'error'
    },

    ['pin_digits'] = {
        title = 'BANKING',
        text = 'Votre code PIN doit comporter 4 chiffres',
        time = 5000,
        type = 'error'
    },

    ['pin_only_numbers'] = {
        title = 'BANKING',
        text = 'Vous ne pouvez utiliser que des chiffres',
        time = 5000,
        type = 'error'
    },


    -- LOCALES LIÉES À L'IBAN

    ['iban_not_exist'] = {
        title = 'BANKING',
        text = 'Cet IBAN n\'existe pas',
        time = 5000,
        type = 'error'
    },

    ['iban_in_use'] = {
        title = 'BANKING',
        text = 'Cet IBAN est déjà utilisé',
        time = 5000,
        type = 'error'
    },

    ['iban_only_numbers'] = {
        title = 'BANKING',
        text = 'Vous ne pouvez utiliser que des chiffres dans votre IBAN',
        time = 5000,
        type = 'error'
    },

    ['iban_changed'] = {
        title = 'BANKING',
        text = 'IBAN changé avec succès en ${s1}',
        time = 5000,
        type = 'success'
    },

    ['iban_no_money'] = {
        title = 'BANKING',
        text = 'Vous devez avoir ${s1}€ pour changer votre IBAN',
        time = 5000,
        type = 'error'
    },


    -- RETIRÉ / DÉPOSÉ / TRANSFÉRÉ / REÇU

    ['deposited'] = {
        title = 'BANKING',
        text = 'Vous avez déposé ${s1}€',
        time = 5000,
        type = 'success'
    },

    ['withdrawn'] = {
        title = 'BANKING',
        text = 'Vous avez retiré ${s1}€',
        time = 5000,
        type = 'success'
    },

    ['received_from'] = {
        title = 'BANKING',
        text = 'Vous avez reçu ${s1}€ de ${s2}',
        time = 5000,
        type = 'success'
    },

    ['transferred_to'] = {
        title = 'BANKING',
        text = 'Vous avez transféré ${s1}€ de ${s2}',
        time = 5000,
        type = 'success'
    },

    ['deposited_to'] = {
        title = 'BANKING',
        text = 'Vous avez déposé ${s1}€ de ${s2}',
        time = 5000,
        type = 'success'
    },

    ['someone_withdrawing'] = {
        title = 'BANKING',
        text = 'Quelqu\'un se retire déjà',
        time = 5000,
        type = 'error'
    },

    ['you_have_withdrawn'] = {
        title = 'BANKING',
        text = 'Vous avez retiré ${s1}€ depuis ${s2}',
        time = 5000,
        type = 'success'
    },


    -- LOCALES GÉNÉRAUX

    ['no_creditcard'] = {
        title = 'BANKING',
        text = 'Vous ne pouvez pas accéder au guichet automatique sans carte de crédit',
        time = 5000,
        type = 'error'
    },

    ['invalid_amount'] = {
        title = 'BANKING',
        text = 'Montant invalide',
        time = 5000,
        type = 'error'
    },

    ['invalid_input'] = {
        title = 'BANKING',
        text = 'Entrée invalide',
        time = 5000,
        type = 'error'
    },

    ['no_money_pocket'] = {
        title = 'BANKING',
        text = 'Vous n\'avez pas beaucoup d\'argent sur vous',
        time = 5000,
        type = 'error'
    },

    ['no_money_bank'] = {
        title = 'BANKING',
        text = 'Vous n\'avez pas beaucoup d\'argent à la banque',
        time = 5000,
        type = 'error'
    },

    ['not_send_yourself'] = {
        title = 'BANKING',
        text = 'Vous ne pouvez pas vous envoyer d\'argent',
        time = 5000,
        type = 'error'
    },

    ['society_no_money'] = {
        title = 'BANKING',
        text = 'Votre société n\'a pas autant d\'argent à la banque',
        time = 5000,
        type = 'error'
    },

    ['not_use_bank'] = {
        title = 'BANKING',
        text = 'Vous ne pouvez pas utiliser la banque pour le moment',
        time = 5000,
        type = 'error'
    },

    ['bought_cc'] = {
        title = 'BANKING',
        text = 'Vous avez acheté une carte de crédit pour ${s1}€',
        time = 5000,
        type = 'success'
    },


    -- TEXTUI LOCALES

    ['open_banking'] = {
        text = '[E] Accéder à la banque',
        color = 'darkblue',
        side = 'left'
    },

    ['open_atm'] = {
        text = '[E] Accéder au ATM',
        color = 'darkblue',
        side = 'left'
    },

    -- QB-TARGET LOCALES

    ['open_banking_target'] = {
        text = 'Accéder à la banque',
    },

    ['open_atm_target'] = {
        text = 'Accéder au ATM',
    },

}
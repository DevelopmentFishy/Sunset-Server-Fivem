Locales['pt'] = {

    -- PIN

    ['no_pin'] = {
        title = 'BANCO',
        text = 'Desloca-te a um banco para definires um código PIN',
        time = 5000,
        type = 'error'
    },

    ['pin_changed'] = {
        title = 'BANCO',
        text = 'Código PIN alterado com sucesso para ${s1}',
        time = 5000,
        type = 'success'
    },

    ['pin_no_money'] = {
        title = 'BANCO',
        text = 'Necessitas de ${s1}€ para alterar o teu código PIN',
        time = 5000,
        type = 'error'
    },

    ['pin_digits'] = {
        title = 'BANCO',
        text = 'O código PIN deve ter 4 dígitos',
        time = 5000,
        type = 'error'
    },

    ['pin_only_numbers'] = {
        title = 'BANCO',
        text = 'Apenas podes usar números',
        time = 5000,
        type = 'error'
    },


    -- IBAN

    ['iban_not_exist'] = {
        title = 'BANCO',
        text = 'Este IBAN não existe',
        time = 5000,
        type = 'error'
    },

    ['iban_in_use'] = {
        title = 'BANCO',
        text = 'Este IBAN já se encontra em uso',
        time = 5000,
        type = 'error'
    },

    ['iban_only_numbers'] = {
        title = 'BANCO',
        text = 'Apenas podes usar números no IBAN',
        time = 5000,
        type = 'error'
    },

    ['iban_changed'] = {
        title = 'BANCO',
        text = 'IBAN alterado com sucesso para ${s1}',
        time = 5000,
        type = 'success'
    },

    ['iban_no_money'] = {
        title = 'BANCO',
        text = 'Necessitas de ${s1}€ para alterar o teu IBAN',
        time = 5000,
        type = 'error'
    },


    -- LEVANTAMENTO / DEPÓSITO / TRANSFERÊNCIA / RECEBIDO

    ['deposited'] = {
        title = 'BANCO',
        text = 'Depositaste ${s1}€',
        time = 5000,
        type = 'success'
    },

    ['withdrawn'] = {
        title = 'BANCO',
        text = 'Levantaste ${s1}€',
        time = 5000,
        type = 'success'
    },

    ['received_from'] = {
        title = 'BANCO',
        text = 'Recebeste ${s1}€ de ${s2}',
        time = 5000,
        type = 'success'
    },

    ['transferred_to'] = {
        title = 'BANCO',
        text = 'Transferiste ${s1}€ para ${s2}',
        time = 5000,
        type = 'success'
    },

    ['deposited_to'] = {
        title = 'BANCO',
        text = 'Depositaste ${s1}€ para ${s2}',
        time = 5000,
        type = 'success'
    },

    ['someone_withdrawing'] = {
        title = 'BANCO',
        text = 'Alguém já está a levantar dinheiro',
        time = 5000,
        type = 'error'
    },

    ['you_have_withdrawn'] = {
        title = 'BANCO',
        text = 'Levantaste ${s1}€ de ${s2}',
        time = 5000,
        type = 'success'
    },


    -- GERAL

    ['no_creditcard'] = {
        title = 'BANCO',
        text = 'Não podes aceder ao multibanco sem um cartão de crédito',
        time = 5000,
        type = 'error'
    },

    ['invalid_amount'] = {
        title = 'BANCO',
        text = 'Valor inválido',
        time = 5000,
        type = 'error'
    },

    ['invalid_input'] = {
        title = 'BANCO',
        text = 'Input inválido',
        time = 5000,
        type = 'error'
    },

    ['no_money_pocket'] = {
        title = 'BANCO',
        text = 'Não tens dinheiro suficiente na mão',
        time = 5000,
        type = 'error'
    },

    ['no_money_bank'] = {
        title = 'BANCO',
        text = 'Não tens dinheiro suficiente no banco',
        time = 5000,
        type = 'error'
    },

    ['not_send_yourself'] = {
        title = 'BANCO',
        text = 'Não podes transferir dinheiro para ti próprio',
        time = 5000,
        type = 'error'
    },

    ['society_no_money'] = {
        title = 'BANCO',
        text = 'A tua organização não tem dinheiro suficiente no banco',
        time = 5000,
        type = 'error'
    },

    ['not_use_bank'] = {
        title = 'BANCO',
        text = 'Não podes usar o banco neste momento',
        time = 5000,
        type = 'error'
    },

    ['bought_cc'] = {
        title = 'BANCO',
        text = 'Compraste um cartão de crédito por ${s1}€',
        time = 5000,
        type = 'success'
    },


    -- TEXTUI

    ['open_banking'] = {
        text = '[E] Aceder ao Banco',
        color = 'darkblue',
        side = 'left'
    },

    ['open_atm'] = {
        text = '[E] Aceder à ATM',
        color = 'darkblue',
        side = 'left'
    },

    -- QB-TARGET LOCALES

    ['open_banking_target'] = {
        text = 'Aceder ao Banco',
    },

    ['open_atm_target'] = {
        text = 'Aceder à ATM',
    },

}
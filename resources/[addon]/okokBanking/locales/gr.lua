Locales['gr'] = {

    -- ΣΧΕΤΙΚΟ ΤΟ PIN ΜΕΤΑΦΡΑΣΕΙΣ

    ['no_pin'] = {
        title = 'BANKING',
        text = 'Απευθυνθείτε πρώτα σε μια τράπεζα για να ορίσετε έναν κωδικό PIN',
        time = 5000,
        type = 'error'
    },

    ['pin_changed'] = {
        title = 'BANKING',
        text = 'Το PIN άλλαξε με επιτυχία σε ${s1}',
        time = 5000,
        type = 'success'
    },

    ['pin_no_money'] = {
        title = 'BANKING',
        text = 'Πρέπει να έχετε ${s1}€ για να αλλάξετε το PIN σας',
        time = 5000,
        type = 'error'
    },

    ['pin_digits'] = {
        title = 'BANKING',
        text = 'Το PIN σας πρέπει να αποτελείται από 4 ψηφία',
        time = 5000,
        type = 'error'
    },

    ['pin_only_numbers'] = {
        title = 'BANKING',
        text = 'Μπορείτε να χρησιμοποιήσετε μόνο αριθμούς',
        time = 5000,
        type = 'error'
    },


    -- ΣΧΕΤΙΚΟ IBAN ΜΕΤΑΦΡΑΣΕΙΣ

    ['iban_not_exist'] = {
        title = 'BANKING',
        text = 'Αυτό το IBAN δεν υπάρχει',
        time = 5000,
        type = 'error'
    },

    ['iban_in_use'] = {
        title = 'BANKING',
        text = 'Αυτό το IBAN χρησιμοποιείται ήδη',
        time = 5000,
        type = 'error'
    },

    ['iban_only_numbers'] = {
        title = 'BANKING',
        text = 'Μπορείτε να χρησιμοποιήσετε μόνο αριθμούς στον IBAN σας',
        time = 5000,
        type = 'error'
    },

    ['iban_changed'] = {
        title = 'BANKING',
        text = 'Το IBAN άλλαξε με επιτυχία σε ${s1}',
        time = 5000,
        type = 'success'
    },

    ['iban_no_money'] = {
        title = 'BANKING',
        text = 'Πρέπει να έχετε ${s1}€ για να αλλάξετε τον IBAN σας',
        time = 5000,
        type = 'error'
    },


    -- ΑΝΑΛΗΨΗ / ΚΑΤΑΘΕΣΗ / ΜΕΤΑΒΙΒΑΣΗ / ΛΗΨΗ

    ['deposited'] = {
        title = 'BANKING',
        text = 'Έχετε καταθέσει ${s1}€',
        time = 5000,
        type = 'success'
    },

    ['withdrawn'] = {
        title = 'BANKING',
        text = 'Έχετε αποσυρθεί ${s1}€',
        time = 5000,
        type = 'success'
    },

    ['received_from'] = {
        title = 'BANKING',
        text = 'Έχετε λάβει ${s1}€ από ${s2}',
        time = 5000,
        type = 'success'
    },

    ['transferred_to'] = {
        title = 'BANKING',
        text = 'Έχετε μεταφέρει ${s1}€ στο ${s2}',
        time = 5000,
        type = 'success'
    },

    ['deposited_to'] = {
        title = 'BANKING',
        text = 'Έχετε καταθέσει ${s1}€ στο ${s2}',
        time = 5000,
        type = 'success'
    },

    ['someone_withdrawing'] = {
        title = 'BANKING',
        text = 'Κάποιος ήδη αποσύρεται',
        time = 5000,
        type = 'error'
    },

    ['you_have_withdrawn'] = {
        title = 'BANKING',
        text = 'Έχετε κάνει ανάληψη ${s1}€ από ${s2}',
        time = 5000,
        type = 'success'
    },


    -- ΓΕΝΙΚΕΣ ΜΕΤΑΦΡΑΣΕΙΣ

    ['no_creditcard'] = {
        title = 'BANKING',
        text = 'Δεν μπορείτε να έχετε πρόσβαση στο ΑΤΜ χωρίς πιστωτική κάρτα.',
        time = 5000,
        type = 'error'
    },

    ['invalid_amount'] = {
        title = 'BANKING',
        text = 'Μη έγκυρο ποσό',
        time = 5000,
        type = 'error'
    },

    ['invalid_input'] = {
        title = 'BANKING',
        text = 'Μη έγκυρη εισαγωγή',
        time = 5000,
        type = 'error'
    },

    ['no_money_pocket'] = {
        title = 'BANKING',
        text = 'Δεν έχεις τόσα χρήματα πάνω σου',
        time = 5000,
        type = 'error'
    },

    ['no_money_bank'] = {
        title = 'BANKING',
        text = 'Δεν έχεις τόσα χρήματα στην τράπεζα',
        time = 5000,
        type = 'error'
    },

    ['not_send_yourself'] = {
        title = 'BANKING',
        text = 'Δεν μπορείτε να στείλετε χρήματα στον εαυτό σας',
        time = 5000,
        type = 'error'
    },

    ['society_no_money'] = {
        title = 'BANKING',
        text = 'Η κοινωνία σας δεν έχει τόσα χρήματα στην τράπεζα',
        time = 5000,
        type = 'error'
    },

    ['not_use_bank'] = {
        title = 'BANKING',
        text = 'Δεν μπορείτε να χρησιμοποιήσετε την τράπεζα αυτή τη στιγμή',
        time = 5000,
        type = 'error'
    },

    ['bought_cc'] = {
        title = 'BANKING',
        text = 'Αγοράσατε μια πιστωτική κάρτα για ${s1}€',
        time = 5000,
        type = 'success'
    },


    -- TEXTUI ΜΕΤΑΦΡΑΣΕΙΣ

    ['open_banking'] = {
        text = '[E] Να ανοίξω την τράπεζα',
        color = 'darkblue',
        side = 'left'
    },

    ['open_atm'] = {
        text = '[E] Aνοίξτε το ΑΤΜ',
        color = 'darkblue',
        side = 'left'
    },

    -- QB-TARGET ΜΕΤΑΦΡΑΣΕΙΣ

    ['open_banking_target'] = {
        text = 'Να ανοίξω την τράπεζα',
    },

    ['open_atm_target'] = {
        text = 'Aνοίξτε το ΑΤΜ',
    },

}
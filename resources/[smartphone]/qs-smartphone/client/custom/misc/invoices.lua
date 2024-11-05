function PayInvoice(invoiceId)
    if Config.Framework == 'esx' then
        if Config.billingSystem == 'default' then 
            ESX.TriggerServerCallback(Config.billingpayBillEvent, function()
                TriggerServerCallback('qs-smartphone:server:GetInvoices', function(Invoices)
                    PhoneData.Invoices = Invoices
                end)
            end, invoiceId)
        elseif Config.billingSystem == 'okokBilling' then
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        elseif Config.billingSystem == 'billing_ui' then
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        elseif Config.billingSystem == 'rcore_billing' then
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        elseif Config.billingSystem == 'codem-billing' then
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        else 
            -- Add your own code here
        end
    elseif Config.Framework == 'qb' then
        if Config.billingSystem == 'default' then 
            TriggerServerCallback('qs-smartphone:server:PayInvoice', function()
            end, invoiceId)
        elseif Config.billingSystem == 'billing_ui' then 
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        elseif Config.billingSystem == 'okokBilling' then
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        elseif Config.billingSystem == 'jim-payments' then
            TriggerServerCallback('qs-smartphone:server:PayInvoice', function()
            end, invoiceId)
        elseif Config.billingSystem == 'codem-billing' then
            TriggerServerEvent(Config.billingpayBillEvent, invoiceId)
        else 
            -- Add your own code here
        end
    end
end
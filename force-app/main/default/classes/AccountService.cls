/**
 * @File Name          : AccountService.cls
 * @Description        : 
 * @Author             : Nishant Arora
 * @Group              : 
 * @Last Modified By   : Nishant Arora
 * @Last Modified On   : 18/12/2019, 3:27:08 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    18/12/2019   Nishant Arora     Initial Version
**/
public with sharing class AccountService {
    public Account createAccount( String accountName, String accountNumber, String tickerSymbol ) {
        Account newAcct = new Account(
            Name = accountName,
            AccountNumber = accountNumber,
            TickerSymbol = accountNumber
        );
        return newAcct;
    }
}
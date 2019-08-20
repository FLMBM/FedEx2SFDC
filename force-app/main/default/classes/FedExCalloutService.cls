public with sharing class FedExCalloutService {
    public FedExCalloutService() {
        
    }

    public static void trackPackages(List<Package__c> packageList) {
        try {
            FedEx_Account__mdt	fedexAccount = [SELECT Client_Account_Number__c, Client_Integrator_Id__c, Client_Meter_Number__c, FedEx_Key__c, FedEx_Password__c FROM FedEx_Account__mdt WHERE DeveloperName = 'FedEx'];
            FedexSfdcIntegratorV16.TrackServicePort service = new FedexSfdcIntegratorV16.TrackServicePort();
            FedexSfdcIntegratorV16.TrackReply response = service.track(createWebAuthDetails(fedexAccount), 
                                                                  createClientDetails(fedexAccount), 
                                                                  createTransactionDetails(), 
                                                                  getVersionId(), 
                                                                  createTrackSelectionDetails(packageList), 
                                                                  12000, 
                                                                  new List<String>());
            
            
		updateStatus(response, packageList);	
           
        } catch(Exception e) {
            system.debug(e.getStackTraceString());
        }
        
    }

    private static void updateStatus(FedexSfdcIntegratorV16.TrackReply response, List<Package__c> packageList) {
        Map<String, String> statusMap = getUpdatedStatusMap(response);
        Map<String, Package__c> packageMap = getPackageMap(packageList);
        for(String trackingNumber : statusMap.keySet()) {
             packageMap.get(trackingNumber).Status_Description__c = statusMap.get(trackingNumber);   
        }
        update packageMap.values();
    }

    private static Map<String, Package__c> getPackageMap(List<Package__c> packageList) {
        Map<String, Package__c> packageMap = new Map<String, Package__c>();
        for(Package__c fedexPackage : packageList) {
            packageMap.put(fedexPackage.Tracking_Number__c, fedexPackage);
        }
        return packageMap;
    } 

    private static Map<String, String> getUpdatedStatusMap(FedexSfdcIntegratorV16.TrackReply trackReply) {
        List<FedexSfdcIntegratorV16.CompletedTrackDetail> completedTrackDetailList = trackReply.CompletedTrackDetails;
        system.debug(completedTrackDetailList.size());
        List<FedexSfdcIntegratorV16.TrackDetail> trackDetailList = new List<FedexSfdcIntegratorV16.TrackDetail>();
        for(FedexSfdcIntegratorV16.CompletedTrackDetail completedTrackDetail : completedTrackDetailList) {
            trackDetailList.addAll(completedTrackDetail.TrackDetails);
        }

        system.debug(trackDetailList.size());

        Map<String, String> statusMap = new Map<String, String>();
        for(FedexSfdcIntegratorV16.TrackDetail trackDetail : trackDetailList) {
            FedexSfdcIntegratorV16.TrackStatusDetail trackStatusDetail = trackDetail.StatusDetail;
            if(trackStatusDetail <> NULL) {
                statusMap.put(trackDetail.TrackingNumber, trackStatusDetail.Description);
            }
        }
        return statusMap;
    }

    private static FedexSfdcIntegratorV16.WebAuthenticationDetail createWebAuthDetails(FedEx_Account__mdt fedexAccount) {
        FedexSfdcIntegratorV16.WebAuthenticationCredential userCreds = new FedexSfdcIntegratorV16.WebAuthenticationCredential();
        userCreds.Password = fedexAccount.FedEx_Password__c;
        userCreds.Key = fedexAccount.FedEx_Key__c;
        FedexSfdcIntegratorV16.WebAuthenticationDetail webAuthDetails = new FedexSfdcIntegratorV16.WebAuthenticationDetail();
        webAuthDetails.UserCredential = userCreds;
        return webAuthDetails;
    }

    private static FedexSfdcIntegratorV16.ClientDetail createClientDetails(FedEx_Account__mdt fedexAccount) {
        FedexSfdcIntegratorV16.ClientDetail clientDetails = new FedexSfdcIntegratorV16.ClientDetail();
        clientDetails.AccountNumber = fedexAccount.Client_Account_Number__c;
        clientDetails.MeterNumber = fedexAccount.Client_Meter_Number__c;
        clientDetails.IntegratorId = fedexAccount.Client_Integrator_Id__c;
        clientDetails.Localization = getLocalization();
        return clientDetails;
    }

    private static FedexSfdcIntegratorV16.TransactionDetail createTransactionDetails() {
        FedexSfdcIntegratorV16.TransactionDetail transactionDetails = new FedexSfdcIntegratorV16.TransactionDetail();
        transactionDetails.Localization = getLocalization();
        return transactionDetails;
    }

    private static FedexSfdcIntegratorV16.VersionId getVersionId() {
        FedexSfdcIntegratorV16.VersionId versionId = new FedexSfdcIntegratorV16.VersionId();
        versionId.ServiceId = 'trck';
        versionId.Major = 16;
        versionId.Minor = 0;
        versionId.Intermediate = 0;
        return versionId;
    }

    private static FedexSfdcIntegratorV16.TrackSelectionDetail[] createTrackSelectionDetails(List<Package__c> packageList) {
        List<FedexSfdcIntegratorV16.TrackSelectionDetail> selectionDetails = new List<FedexSfdcIntegratorV16.TrackSelectionDetail>();
    
        for(Package__c fedexPackage : packageList) {
            FedexSfdcIntegratorV16.TrackSelectionDetail selectionItem = new FedexSfdcIntegratorV16.TrackSelectionDetail();
            FedexSfdcIntegratorV16.TrackPackageIdentifier packageIdentifier = new FedexSfdcIntegratorV16.TrackPackageIdentifier();
            packageIdentifier.Type_x = 'TRACKING_NUMBER_OR_DOORTAG';
            packageIdentifier.Value = fedexPackage.Tracking_Number__c;
            selectionItem.PackageIdentifier = packageIdentifier;
            selectionDetails.add(selectionItem);
        }
        return selectionDetails;
    }

    private static String[] getProcessingOptions() {
        return null;
    }
    
    private static FedexSfdcIntegratorV16.Localization getLocalization() {
        FedexSfdcIntegratorV16.Localization localization = new FedexSfdcIntegratorV16.Localization();
        localization.LanguageCode = 'en';
        return localization;
    } 
}
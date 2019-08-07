public with sharing class FedExCalloutService {
    public FedExCalloutService() {
        
    }

    public static void trackPackages(List<Package__c> packageList) {
        try {
            FedexSfdcIntegratorV16.TrackServicePort service = new FedexSfdcIntegratorV16.TrackServicePort();
            FedexSfdcIntegratorV16.TrackReply response = service.track(createWebAuthDetails(), 
                                                                  createClientDetails(), 
                                                                  createTransactionDetails(), 
                                                                  getVersionId(), 
                                                                  createTrackSelectionDetails(), 
                                                                  12000, 
                                                                  new List<String>());
            
            
			Map<String, String> statusMap = updateStatus(response);
           
        } catch(Exception e) {
            system.debug(e);
        }
        
    }

    private static Map<String, String> updateStatus(FedexSfdcIntegratorV16.TrackReply trackReply) {
        List<FedexSfdcIntegratorV16.CompletedTrackDetail> completedTrackDetailList = trackReply.CompletedTrackDetails;
        List<FedexSfdcIntegratorV16.TrackDetail> trackDetailList = new List<FedexSfdcIntegratorV16.TrackDetail>();
        for(FedexSfdcIntegratorV16.CompletedTrackDetail completedTrackDetail : completedTrackDetailList) {
            trackDetailList = completedTrackDetail.TrackDetails;
        }

        Map<String, String> statusMap = new Map<String, String>();
        for(FedexSfdcIntegratorV16.TrackDetail trackDetail : trackDetailList) {
            FedexSfdcIntegratorV16.TrackStatusDetail trackStatusDetail = trackDetail.StatusDetail;
            if(trackStatusDetail <> NULL) {
                statusMap.put(trackDetail.TrackingNumber, trackStatusDetail.Description);
            }
        }
        return statusMap;
    }

    private static FedexSfdcIntegratorV16.WebAuthenticationDetail createWebAuthDetails() {
        FedexSfdcIntegratorV16.WebAuthenticationCredential userCreds = new FedexSfdcIntegratorV16.WebAuthenticationCredential();
        userCreds.Password = 'Vq3NvMS9rnbQiX9f9dy0EHNVP';
        userCreds.Key = 'j0xrzzuhynb7kSCa';
        FedexSfdcIntegratorV16.WebAuthenticationDetail webAuthDetails = new FedexSfdcIntegratorV16.WebAuthenticationDetail();
        webAuthDetails.UserCredential = userCreds;
        return webAuthDetails;
    }

    private static FedexSfdcIntegratorV16.ClientDetail createClientDetails() {
        FedexSfdcIntegratorV16.ClientDetail clientDetails = new FedexSfdcIntegratorV16.ClientDetail();
        clientDetails.AccountNumber = '510087720';
        clientDetails.MeterNumber = '113991026';
        clientDetails.IntegratorId = '123';
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

    private static FedexSfdcIntegratorV16.TrackSelectionDetail[] createTrackSelectionDetails() {
        List<FedexSfdcIntegratorV16.TrackSelectionDetail> selectionDetails = new List<FedexSfdcIntegratorV16.TrackSelectionDetail>();
        FedexSfdcIntegratorV16.TrackSelectionDetail selectionItem = new FedexSfdcIntegratorV16.TrackSelectionDetail();
        //selectionItem.TrackingNumberUniqueIdentifier = '449044304137821';
        //selectionItem.ShipmentAccountNumber = '510088000';
        FedexSfdcIntegratorV16.TrackPackageIdentifier packageIdentifier = new FedexSfdcIntegratorV16.TrackPackageIdentifier();
        packageIdentifier.Type_x = 'TRACKING_NUMBER_OR_DOORTAG';
        packageIdentifier.Value = '449044304137821';
        selectionItem.PackageIdentifier = packageIdentifier;
        selectionDetails.add(selectionItem);
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
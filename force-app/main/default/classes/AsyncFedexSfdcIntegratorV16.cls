//Generated by wsdl2apex

public class AsyncFedexSfdcIntegratorV16 {
    public class GetTrackingDocumentsReplyFuture extends System.WebServiceCalloutFuture {
        public fedexSfdcIntegratorV16.GetTrackingDocumentsReply getValue() {
            fedexSfdcIntegratorV16.GetTrackingDocumentsReply response = (fedexSfdcIntegratorV16.GetTrackingDocumentsReply)System.WebServiceCallout.endInvoke(this);
            return response;
        }
    }
    public class TrackReplyFuture extends System.WebServiceCalloutFuture {
        public fedexSfdcIntegratorV16.TrackReply getValue() {
            fedexSfdcIntegratorV16.TrackReply response = (fedexSfdcIntegratorV16.TrackReply)System.WebServiceCallout.endInvoke(this);
            return response;
        }
    }
    public class SendNotificationsReplyFuture extends System.WebServiceCalloutFuture {
        public fedexSfdcIntegratorV16.SendNotificationsReply getValue() {
            fedexSfdcIntegratorV16.SendNotificationsReply response = (fedexSfdcIntegratorV16.SendNotificationsReply)System.WebServiceCallout.endInvoke(this);
            return response;
        }
    }
    public class AsyncTrackServicePort {
        public String endpoint_x = 'https://wsbeta.fedex.com:443/web-services/track';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://fedex.com/ws/track/v16', 'fedexSfdcIntegratorV16'};
        public AsyncFedexSfdcIntegratorV16.GetTrackingDocumentsReplyFuture beginGetTrackingDocuments(System.Continuation continuation,fedexSfdcIntegratorV16.WebAuthenticationDetail WebAuthenticationDetail,fedexSfdcIntegratorV16.ClientDetail ClientDetail,fedexSfdcIntegratorV16.TransactionDetail TransactionDetail,fedexSfdcIntegratorV16.VersionId Version,fedexSfdcIntegratorV16.TrackSelectionDetail[] SelectionDetails,fedexSfdcIntegratorV16.TrackingDocumentSpecification TrackingDocumentSpecification) {
            fedexSfdcIntegratorV16.GetTrackingDocumentsRequest request_x = new fedexSfdcIntegratorV16.GetTrackingDocumentsRequest();
            request_x.WebAuthenticationDetail = WebAuthenticationDetail;
            request_x.ClientDetail = ClientDetail;
            request_x.TransactionDetail = TransactionDetail;
            request_x.Version = Version;
            request_x.SelectionDetails = SelectionDetails;
            request_x.TrackingDocumentSpecification = TrackingDocumentSpecification;
            return (AsyncFedexSfdcIntegratorV16.GetTrackingDocumentsReplyFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncFedexSfdcIntegratorV16.GetTrackingDocumentsReplyFuture.class,
              continuation,
              new String[]{endpoint_x,
              'http://fedex.com/ws/track/v16/getTrackingDocuments',
              'http://fedex.com/ws/track/v16',
              'GetTrackingDocumentsRequest',
              'http://fedex.com/ws/track/v16',
              'GetTrackingDocumentsReply',
              'fedexSfdcIntegratorV16.GetTrackingDocumentsReply'}
            );
        }
        public AsyncFedexSfdcIntegratorV16.TrackReplyFuture beginTrack(System.Continuation continuation,fedexSfdcIntegratorV16.WebAuthenticationDetail WebAuthenticationDetail,fedexSfdcIntegratorV16.ClientDetail ClientDetail,fedexSfdcIntegratorV16.TransactionDetail TransactionDetail,fedexSfdcIntegratorV16.VersionId Version,fedexSfdcIntegratorV16.TrackSelectionDetail[] SelectionDetails,Integer TransactionTimeOutValueInMilliseconds,String[] ProcessingOptions) {
            fedexSfdcIntegratorV16.TrackRequest request_x = new fedexSfdcIntegratorV16.TrackRequest();
            request_x.WebAuthenticationDetail = WebAuthenticationDetail;
            request_x.ClientDetail = ClientDetail;
            request_x.TransactionDetail = TransactionDetail;
            request_x.Version = Version;
            request_x.SelectionDetails = SelectionDetails;
            request_x.TransactionTimeOutValueInMilliseconds = TransactionTimeOutValueInMilliseconds;
            request_x.ProcessingOptions = ProcessingOptions;
            return (AsyncFedexSfdcIntegratorV16.TrackReplyFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncFedexSfdcIntegratorV16.TrackReplyFuture.class,
              continuation,
              new String[]{endpoint_x,
              'http://fedex.com/ws/track/v16/track',
              'http://fedex.com/ws/track/v16',
              'TrackRequest',
              'http://fedex.com/ws/track/v16',
              'TrackReply',
              'fedexSfdcIntegratorV16.TrackReply'}
            );
        }
        public AsyncFedexSfdcIntegratorV16.SendNotificationsReplyFuture beginSendNotifications(System.Continuation continuation,fedexSfdcIntegratorV16.WebAuthenticationDetail WebAuthenticationDetail,fedexSfdcIntegratorV16.ClientDetail ClientDetail,fedexSfdcIntegratorV16.TransactionDetail TransactionDetail,fedexSfdcIntegratorV16.VersionId Version,String TrackingNumber,Boolean MultiPiece,String PagingToken,String TrackingNumberUniqueId,Date ShipDateRangeBegin,Date ShipDateRangeEnd,String SenderEMailAddress,String SenderContactName,fedexSfdcIntegratorV16.ShipmentEventNotificationDetail EventNotificationDetail) {
            fedexSfdcIntegratorV16.SendNotificationsRequest request_x = new fedexSfdcIntegratorV16.SendNotificationsRequest();
            request_x.WebAuthenticationDetail = WebAuthenticationDetail;
            request_x.ClientDetail = ClientDetail;
            request_x.TransactionDetail = TransactionDetail;
            request_x.Version = Version;
            request_x.TrackingNumber = TrackingNumber;
            request_x.MultiPiece = MultiPiece;
            request_x.PagingToken = PagingToken;
            request_x.TrackingNumberUniqueId = TrackingNumberUniqueId;
            request_x.ShipDateRangeBegin = ShipDateRangeBegin;
            request_x.ShipDateRangeEnd = ShipDateRangeEnd;
            request_x.SenderEMailAddress = SenderEMailAddress;
            request_x.SenderContactName = SenderContactName;
            request_x.EventNotificationDetail = EventNotificationDetail;
            return (AsyncFedexSfdcIntegratorV16.SendNotificationsReplyFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncFedexSfdcIntegratorV16.SendNotificationsReplyFuture.class,
              continuation,
              new String[]{endpoint_x,
              'http://fedex.com/ws/track/v16/sendNotifications',
              'http://fedex.com/ws/track/v16',
              'SendNotificationsRequest',
              'http://fedex.com/ws/track/v16',
              'SendNotificationsReply',
              'fedexSfdcIntegratorV16.SendNotificationsReply'}
            );
        }
    }
}
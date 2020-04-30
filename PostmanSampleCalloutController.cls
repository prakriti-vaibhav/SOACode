public class PostmanSampleCalloutController {
    public static HttpResponse postmanSampleCallout() {
        try{
            Http httpProtocol = new Http();
            HttpRequest request= new HttpRequest();
            String requestBody;
            String url = 'https://postman-echo.com/get?foo1=bar1&foo2=bar2';
            request.setEndpoint(url);
            request.setMethod('GET');
            request.setHeader('Content-Type','application/json');
            HttpResponse response = new Http().send(request);
            system.debug('value of final res -->' + response.getBody()); 
            if(response != null && response.getStatusCode() == 200){
                JSONParser parser = JSON.createParser(response.getBody());
                while (parser.nextToken()!= null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                        String fieldName = parser.getText();
                        parser.nextToken();
                        if(parser.getText() != null) {
                            system.debug('field value is'+parser.getText());
                        }
                    }
                }
            }
        }catch(Exception e){System.debug(e);}  
        return null;
    }
}
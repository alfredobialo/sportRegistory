/**
 * Created by USER on 4/2/2016.
 */
(function(ng,window){
  var fileUpload  = ng.module("fileUploadModule", [] )
    .factory("FileUploadService", ["$http",FileUploadService]);

  function FileUploadService($http)
  {
    function iframeLoaded(iframe, callback)
    {
      //var body  = $(iframe).get(0).contentWindow.document.body;
      //$(body).text("");
      $(iframe).one("load", function (evt) {
        try {
          var frameWnd = $(this).get(0).contentWindow;

          var doc = $(frameWnd.document.body);
          var content = doc.text();
          var rawJson = angular.fromJson(content);
          // let's clear the iframe here

          doc.empty();
          //   console.dir(rawJson,true);
          // console.log(doc.get(0));
          callback(rawJson);
        }
        catch (err)
        {

        }


      });
    }
    function onFileChange(obj, callback) {

      var form = obj.form;

      form.on("submit", function (evt) {
        iframeLoaded(obj.iframe, callback);
        // re create the file upload
        // var oldElem  =  $(obj.fileInput);
        // var clone  = oldElem.clone();
        //  obj.fileInput  = clone.get(0);


      });
      form.submit();



    }
    return {
      iframeLoaded  : iframeLoaded,
      onFileUploadChange : onFileChange

    };
  }

})(angular,window);

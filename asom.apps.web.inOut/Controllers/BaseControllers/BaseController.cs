using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using asom.apps.web.inOut.Models;
using asom.apps.web.inOut.Models.Settings;
using itrex.businessObjects.model.core;
using itrex.businessObjects.model.core.util;
using Microsoft.Reporting.WebForms;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace asom.apps.web.inOut.Controllers.BaseControllers
{ //[OutputCache(Duration = 7400)]
    public abstract class BaseController : Controller
    {
        public Task<ActionResult> AuthenticationRequiredActionAsync
        {

            get
            {
                return FailedActionAsync("You must login to continue");
            }


        }
        protected LocalReport PrepareReport(string virtualPath)
        {
            LocalReport rv = new LocalReport();
            string path = Server.MapPath("~/" + virtualPath + ".rdlc");
            if (System.IO.File.Exists(path))
            {
                rv.EnableExternalImages = true;

                rv.ReportPath = path;
                rv = SetRequiredDataSources(rv);
            }

            return rv;
        }

        protected LocalReport SetRequiredDataSources(LocalReport rv)
        {
            rv.DataSources.Add(new ReportDataSource("companyInfoDs", new List<CompanyInfoModel> { CompanyInfoModel.Get }));
            rv.DataSources.Add(new ReportDataSource("appInfoDs", new List<AppInfo> { AppInfo.Get }));
            rv.DataSources.Add(new ReportDataSource("companySettingsDs", SettingModel.GetSettingAppList()));
            return rv;
        }
        protected void GenerateReport(LocalReport rpt, string format="WORD", string pageWidth="10.27", string pageHeight="11.69", string outputFileName = "Report")
        {

            string deviceInfo = @"
                        <DeviceInfo>
                        <ColorDepth>32</ColorDepth>
                        <DpiX>400</DpiX>
                        <DpiY>400</DpiY>
                        
                        <OutputFormat>" + format + @"</OutputFormat>
                        <PageHeight>"+pageHeight+@"in</PageHeight>
                        <PageWidth>"+pageWidth+@"in</PageWidth>
                        <LeftMargin>0.4274in</LeftMargin>
                        <RightMargin>0.4274in</RightMargin>
                        <TopMargin>0.5874in</TopMargin>
                        <BottomMargin>0.5874in</BottomMargin>
                         </DeviceInfo>";
            Warning[] warnings;
            string[] streams;
            string mimeType, encoding, fileExt;
            byte[] output;

            output = rpt.Render(format, deviceInfo, out mimeType, out encoding, out fileExt, out streams, out warnings);
            Response.Buffer = true;
            Response.OutputStream.Write(output, 0, output.Length);
            Response.ContentType = mimeType;
            Response.AddHeader("content-disposition", "attachment; filename=" + outputFileName + "." + fileExt);
            Response.Flush();
            Response.End();
        }
        protected void GenerateReport(LocalReport rpt, string format, string outputFileName = "Report")
        {
//            GenerateReport(rpt, format, "10.27", "11.69", outputFileName);
            string deviceInfo = @"
                        <DeviceInfo>
                        <ColorDepth>32</ColorDepth>
                        <DpiX>400</DpiX>
                        <DpiY>400</DpiY>
                        
                        <OutputFormat>" + format + @"</OutputFormat>
                        <PageHeight>11.69in</PageHeight>
                        <PageWidth>10.27in</PageWidth>
                        <LeftMargin>0.4274in</LeftMargin>
                        <RightMargin>0.4274in</RightMargin>
                        <TopMargin>0.5874in</TopMargin>
                        <BottomMargin>0.5874in</BottomMargin>
                         </DeviceInfo>";
            Warning[] warnings;
            string[] streams;
            string mimeType, encoding, fileExt;
            byte[] output;
            
            output = rpt.Render(format, deviceInfo, out mimeType, out encoding, out fileExt, out streams, out warnings);
            Response.Buffer = true;
            Response.OutputStream.Write(output, 0, output.Length);
            Response.ContentType = mimeType;
            Response.AddHeader("content-disposition", "attachment; filename=" + outputFileName + "." + fileExt);
            Response.Flush();
            Response.End();
        }
        protected string GenerateReportStream(LocalReport rpt, string format = "WORD", string pageWidth = "10.27", string pageHeight = "11.69", string outputFileName = "Report")
        {

            string deviceInfo = @"
                        <DeviceInfo>
                        <ColorDepth>32</ColorDepth>
                        <DpiX>400</DpiX>
                        <DpiY>400</DpiY>
                        
                        <OutputFormat>" + format + @"</OutputFormat>
                        <PageHeight>" + pageHeight + @"in</PageHeight>
                        <PageWidth>" + pageWidth + @"in</PageWidth>
                        <LeftMargin>0.4274in</LeftMargin>
                        <RightMargin>0.4274in</RightMargin>
                        <TopMargin>0.5874in</TopMargin>
                        <BottomMargin>0.5874in</BottomMargin>
                         </DeviceInfo>";
            Warning[] warnings;
            string[] streams;
            string mimeType, encoding, fileExt;
            byte[] output;

            output = rpt.Render(format, deviceInfo, out mimeType, out encoding, out fileExt, out streams, out warnings);
            MemoryStream ms  =  new MemoryStream(output);
            string id =/* User.Identity.IsAuthenticated ? User.Identity.Name + "_Report" :*/ Guid.NewGuid().ToString();
            string result  = CreateFileOnServer(ms,"all_reports",id, fileExt);
            ms.Close();
            return result;
        }
        protected string GenerateReportStream(LocalReport rpt, string format = "WORD",  string outputFileName = "Report")
        {

            string deviceInfo = @"
                        <DeviceInfo>
                        <ColorDepth>32</ColorDepth>
                        <DpiX>400</DpiX>
                        <DpiY>400</DpiY>
                        
                        <OutputFormat>" + format + @"</OutputFormat>
                        <PageHeight>11.69in</PageHeight>
                        <PageWidth>10.27in</PageWidth>
                        <LeftMargin>0.4274in</LeftMargin>
                        <RightMargin>0.4274in</RightMargin>
                        <TopMargin>0.5874in</TopMargin>
                        <BottomMargin>0.5874in</BottomMargin>
                         </DeviceInfo>";
            Warning[] warnings;
            string[] streams;
            string mimeType, encoding, fileExt;
            byte[] output;

            output = rpt.Render(format, deviceInfo, out mimeType, out encoding, out fileExt, out streams, out warnings);
            MemoryStream ms  =  new MemoryStream(output);
            string id =/* User.Identity.IsAuthenticated ? User.Identity.Name + "_Report" :*/ Guid.NewGuid().ToString();
            string result  = CreateFileOnServer(ms,"all_reports",id, fileExt);
            ms.Close();
            return result;
        }

        public  ActionResult FailedAction(string message, List<ValidationErrorLog> logs)
        {
            var error = new
            {
                message = message,
                success = false,
                errorLogs = logs

            };

            string jsonRes = JsonConvert.SerializeObject(error, MyConfig.DefaultJsonSettings);
            return MyConfig.DefaultJsonResult(jsonRes);
        }
        public  ActionResult FailedAction(string message)
        {
            var error = new
            {
                message = message,
                success = false,
                

            };

            string jsonRes = JsonConvert.SerializeObject(error, MyConfig.DefaultJsonSettings);
            return Content(jsonRes);
        }
        public ActionResult AuthenticationRequiredAction
        {
        
            get
            {
                return FailedAction("Your Login Session has Exipired, Please Login to recreate your session!"); 
            }
       
            
        }


        public ActionResult CrudOperaResult<T>(CrudOperationResult<T> crud, dynamic model )
        {
            var server = ServerResponseModel.From(crud);
            server.Data = model;
            string result = JsonConvert.SerializeObject(server, MyConfig.DefaultJsonSettings);
            return Content(result);
        }
        public Task<ActionResult> CrudOperaResultAsync(ServerResponseModel model)
        {
            Task<ActionResult> task = Task.Factory.StartNew(() =>
            {
                return CrudOperaResult(model);
            });
            return task;
        }
        public Task<ActionResult> FailedActionAsync(string message, List<ValidationErrorLog> logs)
        {
            Task<ActionResult> task = Task.Factory.StartNew(() =>
            {
                return FailedAction(message, logs);
            });
            return task;
        }
        public Task<ActionResult> SuccessActionAsync(string message)
        {
            Task<ActionResult> task = Task.Factory.StartNew(() =>
            {
                return SuccessAction(message);
            });
            return task;
        }
        public Task<ActionResult> FailedActionAsync(string message)
        {
            Task<ActionResult> task = Task.Factory.StartNew(() =>
            {
                return FailedAction(message);
            });
            return task;
        }
        public ActionResult CrudOperaResult(ServerResponseModel model )
        {
            var server = model;
            string result = JsonConvert.SerializeObject(server, MyConfig.DefaultJsonSettings);
            return Content(result);
        }
        public ActionResult AccessDeniedAction
        {
            get
            {
                string res = "Access Denied! You may need to Login.";
                return Content(JsonConvert.SerializeObject(new
                {
                    success = false,
                    message = res

                }, MyConfig.DefaultJsonSettings));

            }
        }
        public ActionResult AccessDeniedView
        {
            get
            {
                string res = "ui/_partials/_access_denied";
                return PartialView(res);

            }
        }
        public ActionResult AuthenticationRequiredView
        {
            get
            {
                string res = "ui/_login_ui_padded";
                return PartialView(res);

            }
        }
        public ActionResult SuccessAction(string message, object data=null)
        {
            var error = new
            {
                message = message,
                success = true,
                data = data

            };

            string jsonRes = JsonConvert.SerializeObject(error, MyConfig.DefaultJsonSettings);
            return Content(jsonRes);
        }
        public static JsonResult JsResult()
        {
            JsonResult json = new JsonResult();
            json.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            json.ContentType = "application/json";
            return json;
        }

        protected string CreateFileOnServer(Stream fileStream, string directoryPath, string fileName,string fileExtension)
        {
            string loc = "generated_files/" + directoryPath + "/",
                serverPath = "~/generated_files/" + directoryPath + "/";
            Stream fs = fileStream;
            byte[] fileByte = new byte[(int)fs.Length];
            fs.Read(fileByte, 0, (int)fs.Length);
            fs.Close();
            
            // create a new File with the new fileByte
            string sPath = Server.MapPath(serverPath), id = fileName;
            if (!Directory.Exists(sPath))
            {
                Directory.CreateDirectory(sPath);
            }
            string path = sPath + id + "."+fileExtension;
            string fNPath = loc + id + "."+fileExtension;
            FileStream nfs = System.IO.File.Create(path);
            nfs.Write(fileByte, 0, fileByte.Length);
            nfs.Flush();
            nfs.Close();
            string result = MyConfig.GenerateUrlWithDomainName(fNPath);
            return result;
        }
        public ActionResult UploadFileToServer(string directoryPath, string allowedExtensions, string fixedName  =null )
        {
            //Thread.Sleep(6000);

            string loc = "uploaded_files/" + directoryPath + "/",
                serverPath = "~/uploaded_files/" + directoryPath + "/";
            UploadedFileResult ufr = new UploadedFileResult();
            ufr.allowedExtensions = allowedExtensions.Split(new string[] {" "}, StringSplitOptions.RemoveEmptyEntries).ToList();//
            var files = Request.Files;
            // upload File
            try
            {

                if (files != null & files.Count > 0)
                {
                    for (int i = 0; i < files.Count; i++)
                    {


                        HttpPostedFileBase file = Request.Files[i] as HttpPostedFileBase;

                        if (file != null)
                        {
                            UploadedFile uf = new UploadedFile();
                            string extType = Path.GetExtension(file.FileName);
                            if (AllowedExtensionsConstant.ALL_FILE_EXTENSION ==  allowedExtensions  ||  (ufr.allowedExtensions.Any(x => x.ToLower() == extType.ToLower())))
                            {
                                Stream fs = file.InputStream;
                                byte[] fileByte = new byte[(int)fs.Length];
                                fs.Read(fileByte, 0, (int)fs.Length);
                                // check if is a valid file
                                if (file.ContentType.ToLower().Contains("image"))
                                {


                                    fileByte = ImageResizer.ResizeImageToFit_LAB(fileByte, MyConfig.Image550_350Size, ImageResizer.ImageQuality.Q70);

                                    fs.Close();
                                    ufr.tag = uf.tag = "image";
                                    

                                }

                                // create a new File with the new fileByte
                                string sPath = Server.MapPath(serverPath), id = string.IsNullOrEmpty(fixedName)  ? Guid.NewGuid().ToString()  : fixedName;
                                if (!Directory.Exists(sPath))
                                {
                                    Directory.CreateDirectory(sPath);
                                }
                                string path = sPath + id + Path.GetExtension(file.FileName);
                                string fNPath = loc + id + Path.GetExtension(file.FileName);
                                FileStream nfs = System.IO.File.Create(path);
                                nfs.Write(fileByte, 0, fileByte.Length);

                                // Create new Upload File Object;
                                uf.tag2 = "";
                                uf.name = (fNPath);  //ChatUserModel.GenerateFileUrl
                                uf.autoFileUrl = MyConfig.GenerateUrlWithDomainName(fNPath);


                                uf.size = nfs.Length.ToString();
                                uf.mime = file.ContentType;

                                nfs.Flush();
                                nfs.Dispose();
                                ufr.AddFile(uf);
                            }
                            else
                            {
                                ufr.hasFailedUploads = true;
                                ufr.errorMessage = "Not a valid file format, valid file extensions are :" + allowedExtensions;
                                ufr.success = false;
                                return Content(ufr.Serialize());
                            }
                            

                        }
                    }
                }


            }
            catch (Exception err)
            {
                ufr.hasFailedUploads = true;
                ufr.success = false;
                ufr.errorMessage = "Not a valid file : Error" + err.Message + " : Stack Trace  : " + err.StackTrace;
            }
            ufr.hasFailedUploads = false;
            string result = ufr.Serialize();
            // //.Sleep(5773);
            return Content(result);
        }
        public ActionResult UploadImageToServer(string directoryPath, string allowedExtensions,int width= 680, int height= 400, string fixedName = null)
        {
            //Thread.Sleep(6000);

            string loc = "uploaded_files/" + directoryPath + "/",
                serverPath = "~/uploaded_files/" + directoryPath + "/";
            UploadedFileResult ufr = new UploadedFileResult();
            ufr.allowedExtensions = allowedExtensions.Split(new string[] { " " }, StringSplitOptions.RemoveEmptyEntries).ToList();//
            var files = Request.Files;
            // upload File
            try
            {

                if (files != null & files.Count > 0)
                {
                    for (int i = 0; i < files.Count; i++)
                    {


                        HttpPostedFileBase file = Request.Files[i] as HttpPostedFileBase;

                        if (file != null)
                        {
                            UploadedFile uf = new UploadedFile();
                            string extType = Path.GetExtension(file.FileName);
                            if (AllowedExtensionsConstant.ALL_FILE_EXTENSION == allowedExtensions || (ufr.allowedExtensions.Any(x => x.ToLower() == extType.ToLower())))
                            {
                                Stream fs = file.InputStream;
                                byte[] fileByte = new byte[(int)fs.Length];
                                fs.Read(fileByte, 0, (int)fs.Length);
                                // check if is a valid file
                                if (file.ContentType.ToLower().Contains("image"))
                                {


                                    fileByte = ImageResizer.ResizeImageToFit_LAB(fileByte, new Size(width,height), ImageResizer.ImageQuality.Q90);

                                    fs.Close();
                                    ufr.tag = uf.tag = "image";


                                }

                                // create a new File with the new fileByte
                                string sPath = Server.MapPath(serverPath), id = string.IsNullOrEmpty(fixedName) ? Guid.NewGuid().ToString() : fixedName;
                                if (!Directory.Exists(sPath))
                                {
                                    Directory.CreateDirectory(sPath);
                                }
                                string path = sPath + id + Path.GetExtension(file.FileName);
                                string fNPath = loc + id + Path.GetExtension(file.FileName);
                                FileStream nfs = System.IO.File.Create(path);
                                nfs.Write(fileByte, 0, fileByte.Length);

                                // Create new Upload File Object;
                                uf.tag2 = "";
                                uf.name = (fNPath);  //ChatUserModel.GenerateFileUrl
                                uf.autoFileUrl = MyConfig.GenerateUrlWithDomainName(fNPath);


                                uf.size = nfs.Length.ToString();
                                uf.mime = file.ContentType;

                                nfs.Flush();
                                nfs.Dispose();
                                ufr.AddFile(uf);
                            }
                            else
                            {
                                ufr.hasFailedUploads = true;
                                ufr.errorMessage = "Not a valid file format, valid file extensions are :" + allowedExtensions;
                                ufr.success = false;
                                return Content(ufr.Serialize());
                            }


                        }
                    }
                }


            }
            catch (Exception err)
            {
                ufr.hasFailedUploads = true;
                ufr.success = false;
                ufr.errorMessage = "Not a valid file : Error" + err.Message + " : Stack Trace  : " + err.StackTrace;
            }
            ufr.hasFailedUploads = false;
            string result = ufr.Serialize();
            // //.Sleep(5773);
            return Content(result);
        }
        public ActionResult UploadBanner(string directoryPath, int width = 300, int height=300, int quality = 70)
        {
            //Thread.Sleep(6000);

            string loc = "uploaded_files/" + directoryPath + "/",
                serverPath = "~/uploaded_files/" + directoryPath + "/";
            UploadedFileResult ufr = new UploadedFileResult();
            ufr.allowedExtensions = AllowedExtensionsConstant.IMAGE_FILE_EXTENSION.Split(new string[] { " " }, StringSplitOptions.RemoveEmptyEntries).ToList();//
            var files = Request.Files;
            // upload File
            try
            {

                if (files != null & files.Count > 0)
                {
                    for (int i = 0; i < files.Count; i++)
                    {


                        HttpPostedFileBase file = Request.Files[i] as HttpPostedFileBase;

                        if (file != null)
                        {
                            UploadedFile uf = new UploadedFile();
                            string extType = Path.GetExtension(file.FileName);
                            if ( (ufr.allowedExtensions.Any(x => x.ToLower() == extType.ToLower())))
                            {
                                Stream fs = file.InputStream;
                                byte[] fileByte = new byte[(int)fs.Length];
                                fs.Read(fileByte, 0, (int)fs.Length);
                                // check if is a valid file
                                if (file.ContentType.ToLower().Contains("image"))
                                {


                                    fileByte = ImageResizer.ResizeImageToFit_LAB(fileByte, new Size(width, height), (ImageResizer.ImageQuality) quality);

                                    fs.Close();
                                    ufr.tag = uf.tag = "image";


                                }

                                // create a new File with the new fileByte
                                string sPath = Server.MapPath(serverPath), id =  Guid.NewGuid().ToString();
                                if (!Directory.Exists(sPath))
                                {
                                    Directory.CreateDirectory(sPath);
                                }
                                string path = sPath + id + Path.GetExtension(file.FileName);
                                string fNPath = loc + id + Path.GetExtension(file.FileName);
                                FileStream nfs = System.IO.File.Create(path);
                                nfs.Write(fileByte, 0, fileByte.Length);

                                // Create new Upload File Object;
                                uf.tag2 = "";
                                uf.name = (fNPath);  //ChatUserModel.GenerateFileUrl
                                uf.autoFileUrl = MyConfig.GenerateUrlWithDomainName(fNPath);


                                uf.size = nfs.Length.ToString();
                                uf.mime = file.ContentType;

                                nfs.Flush();
                                nfs.Dispose();
                                ufr.AddFile(uf);
                            }
                            else
                            {
                                ufr.hasFailedUploads = true;
                                ufr.errorMessage = "Not a valid Image file, valid file extensions are :" + AllowedExtensionsConstant.IMAGE_FILE_EXTENSION;
                                ufr.success = false;
                                return Content(ufr.Serialize());
                            }


                        }
                    }
                }


            }
            catch (Exception err)
            {
                ufr.hasFailedUploads = true;
                ufr.success = false;
                ufr.errorMessage = "Not a valid file : Error" + err.Message + " : Stack Trace  : " + err.StackTrace;
            }
            ufr.hasFailedUploads = false;
            string result = ufr.Serialize();
            // //.Sleep(5773);
            return Content(result);
        }
        public ActionResult UploadPubPicture()
        {
         
            string loc = "11081980_27092014_05101990/00pub/dpub/", serverPath = "~/11081980_27092014_05101990/00pub/dpub/";
            UploadedFileResult ufr = new UploadedFileResult();
            ufr.allowedExtensions = new List<string>() { ".jpg", ".jpeg", ".png", ".bmp", ".gif" };//
            var files = Request.Files;
            // upload File
            try
            {

                if (files != null & files.Count > 0)
                {
                    for (int i = 0; i <files.Count ; i++)
                    {
                        
                    
                        HttpPostedFileBase file = Request.Files[i] as HttpPostedFileBase;

                        if (file != null)
                        {
                            UploadedFile uf = new UploadedFile();
                            string extType = Path.GetExtension(file.FileName);
                            Stream fs = file.InputStream;
                            byte[] fileByte = new byte[(int)fs.Length];
                            fs.Read(fileByte, 0, (int)fs.Length);
                            // check if is a valid file
                            if (file.ContentType.ToLower().Contains("image"))
                            {
                                // we are working with an image file;

                                // Validate supported extentions

                                if (ufr.allowedExtensions.Any(x => x.ToLower() == extType.ToLower()))
                                {
                               
                                    fileByte = ImageResizer.ResizeImageToFit_LAB(fileByte, MyConfig.Image550_350Size,ImageResizer.ImageQuality.Q70);

                                    fs.Close();
                                    ufr.tag = uf.tag = "image";
                                }
                                else
                                {
                                    ufr.hasFailedUploads = true;
                                    ufr.errorMessage = "Not a valid file format";
                                    ufr.success = false;
                                    return Content(ufr.Serialize());
                                }
                            }
                            else
                            {



                                ufr.hasFailedUploads = true;
                                ufr.success = false;
                                ufr.errorMessage = "Not a valid file format";
                                return Content(ufr.Serialize());


                            }

                            //generate a new File from the stream
                            // but resize the file in memory first

                            // create a new File with the new fileByte
                            string sPath = Server.MapPath(serverPath), id = Guid.NewGuid().ToString();
                            if (!Directory.Exists(sPath))
                            {
                                Directory.CreateDirectory(sPath);
                            }
                            string path = sPath + id + Path.GetExtension(file.FileName);
                            string fNPath = loc + id + Path.GetExtension(file.FileName);
                            FileStream nfs = System.IO.File.Create(path);
                            nfs.Write(fileByte, 0, fileByte.Length);

                            // Create new Upload File Object;
                            uf.tag2 = "";
                            uf.name = (fNPath);  //ChatUserModel.GenerateFileUrl
                            uf.autoFileUrl = MyConfig.GenerateFileUrl(fNPath);


                            uf.size = nfs.Length.ToString();
                            uf.mime = file.ContentType;

                            nfs.Flush();
                            nfs.Dispose();
                            ufr.AddFile(uf);

                        }
                    }
                }


            }
            catch (Exception err)
            {
                ufr.hasFailedUploads = true;
                ufr.success = false;
                ufr.errorMessage = "Not a valid image file : Error" + err.Message + " : Stack Trace  : " + err.StackTrace;
            }

            string result = ufr.Serialize();
            // //.Sleep(5773);
            return Content(result);
        }
        public ActionResult UploadPicture(bool isBanner = false)
        {
           
            string loc = "11081980_27092014_05101990/000bner/00upl/", 
                serverPath = "~/11081980_27092014_05101990/000bner/00upl/";
            UploadedFileResult ufr = new UploadedFileResult();
            ufr.allowedExtensions = new List<string>() { ".jpg", ".jpeg", ".png", ".bmp", ".gif" };//
            var files = Request.Files;
            // upload File
            try
            {

                if (files != null & files.Count > 0)
                {
                    //for (int i = 0; i < 1; i++)
                    //{
                    HttpPostedFileBase file = Request.Files[0] as HttpPostedFileBase;

                    if (file != null)
                    {
                        UploadedFile uf = new UploadedFile();
                        string extType = Path.GetExtension(file.FileName);
                        Stream fs = file.InputStream;
                        byte[] fileByte = new byte[(int)fs.Length];
                        fs.Read(fileByte, 0, (int)fs.Length);
                        // check if is a valid file
                        if (file.ContentType.ToLower().Contains("image"))
                        {
                            // we are working with an image file;

                            // Validate supported extentions

                            if (ufr.allowedExtensions.Any(x => x.ToLower() == extType.ToLower()))
                            {  
                                
                                Image sourceImg  =  Image.FromStream(new MemoryStream(fileByte));
                                if(isBanner)
                                {
                                    /// perform a zoom on the image specified 
                                    /// if size is an issue then rewrite algorithm
                                    /// Lets create the image
                                    /// 



                                    Point pt = new Point(sourceImg.Width > 1400 + 100 ? 10 : 0
                                        , sourceImg.Height > 3400
                                            ? 100
                                            : (sourceImg.Height > 2000
                                                ? 90
                                                : (sourceImg.Height > 1200 + 300
                                                    ? 80
                                                    : (sourceImg.Height > 700 ? 50 : 0))));
                                    Image newImg = ImageResizer.ZoomImage(sourceImg,
                                        new Rectangle(pt,
                                            new Size(sourceImg.Width > 1300 ? 1300 : sourceImg.Width, sourceImg.Height > 500 ? 390 : (sourceImg.Height > 400 ? 350 : (sourceImg.Height < 320 ? 320 : sourceImg.Height)))),
                                        MyConfig.ImageBannerSize2, out fileByte);
                                    //fileByte = ImageResizer.ResizeImageToFit_LAB(fileByte, new Size() { Width = 1110, Height = 300 }, ImageResizer.ImageQuality.Q30);
                                    //ImageResizer.ResizeImageToFit(fileByte, MyConfig.ImageBannerSizeLarge, out fileByte);
                                }
                                else
                                {

                                    //Image sourceImgw = Image.FromStream(new MemssoryStream(fileByte));
                                    //Size sz  =  new Size(300,300);
                                    //if (sourceImgw.Width > sourceImgw.Height)
                                    //{
                                        
                                    //}
                                    //else
                                    //{
                                        
                                    //}
                                    fileByte  =  ImageResizer.ResizeImageToFit_LAB(fileByte, MyConfig.Image550_350Size,ImageResizer.ImageQuality.Q85);
                                }
                                
                                fs.Close();
                                ufr.tag = uf.tag = "image";
                            }
                            else
                            {
                                ufr.hasFailedUploads = true;
                                ufr.errorMessage = "Not a valid file format";
                                ufr.success = false;
                                return Content(ufr.Serialize());
                            }
                        }
                        else
                        {



                            ufr.hasFailedUploads = true;
                            ufr.success = false;
                            ufr.errorMessage = "Not a valid file format";
                            return Content(ufr.Serialize());


                        }

                        //generate a new File from the stream
                        // but resize the file in memory first

                        // create a new File with the new fileByte
                        string sPath = Server.MapPath(serverPath), id = Guid.NewGuid().ToString();
                        if (!Directory.Exists(sPath))
                        {
                            Directory.CreateDirectory(sPath);
                        }
                        string path = sPath + id + Path.GetExtension(file.FileName);
                        string fNPath = loc + id + Path.GetExtension(file.FileName);
                        FileStream nfs = System.IO.File.Create(path);
                        nfs.Write(fileByte, 0, fileByte.Length);

                        // Create new Upload File Object;
                        uf.tag2 = "";
                        uf.name = (fNPath);  //ChatUserModel.GenerateFileUrl
                        uf.autoFileUrl = MyConfig.GenerateUrlWithDomainName(fNPath);


                        uf.size = nfs.Length.ToString();
                        uf.mime = file.ContentType;

                        nfs.Flush();
                        nfs.Dispose();
                        ufr.AddFile(uf);

                    }
                }
                //}


            }
            catch (Exception err)
            {
                ufr.hasFailedUploads = true;
                ufr.success = false;
                ufr.errorMessage = "Not a valid image file : Error" + err.Message + " : Stack Trace  : " + err.StackTrace ;
            }
          
            string result = ufr.Serialize();
            // //.Sleep(5773);
            return Content(result);
        }
//        protected AuthInfo AuthAccount
//        {
//            get
//            {
//                AuthInfo res = AuthSession.GetAuthAccountOrCreate();//null;
//                
//                return res;
//            }
//        }
        public static JsonSerializerSettings JsonSetting()
        {
            return new JsonSerializerSettings() { ContractResolver = new CamelCasePropertyNamesContractResolver() };
        }

      
    }

    public static class AllowedExtensionsConstant
    {
//        public const  string ALL_FILE_EXTENSION= "ALL";
//        public const  string IMAGE_FILE_EXTENSION= "IMAGES";
//        public const  string VIDEO_FILE_EXTENSION= "VIDEO";
//        public const  string DOCUMENT_FILE_EXTENSION= "DOCUMENTS";
//        public const  string ASOM_LICENSE_FILE_EXTENSION= "LICENSE_FILE";
//        public const  string PDF_FILE_EXTENSION= "LICENSE_FILE";
        public const  string ALL_FILE_EXTENSION= "*";
        public const  string IMAGE_FILE_EXTENSION= ".jpg .jpeg .png .bmp .gif";
        public const  string VIDEO_FILE_EXTENSION= ".mp4 .mkv .wmv .avi";
        public const  string DOCUMENT_FILE_EXTENSION= ".txt .doc .docx .pdf .rtf .csv .sql .xls .xlsx .ppt .pptx";
        public const  string ASOM_LICENSE_FILE_EXTENSION= ".asomlic .asomext";
        public const  string OLD_LICENSE_FILE_EXTENSION= ".csdlicense";
        public const  string PDF_FILE_EXTENSION= ".pdf";
        public const  string DATABASE_FILE_EXTENSION= ".mdf .ldf .sdf .mdb .db";
        public const  string WINDOWS_EXECUTABLES_FILE_EXTENSION= ".exe .bat";
        public const  string COMPRESSED_FILE_EXTENTION= ".rar .zip .7z .iso";
        public const  string PROGRAMMING_FILE_EXTENSION= ".cs .vb .js .asm .java .c .cpp .json .php .asp .aspx .cshtml .vbhtml .html .htm .css .ts";
    }
    public class UploadedFile
    {

        public string tag { get; set; }
        public string name { get; set; }
        string sze = "";
        public string size
        {
            get
            {

                return sze;
            }
            set
            {
                string ze = Bytes.GetSize(double.Parse(value));
                sze = ze;
            }
        }
        public string mime { get; set; }




        public string autoFileUrl { get; set; }

        public string tag2 { get; set; }
    }

    public class UploadedFileResult
    {
        public string tag { get; set; }
        public UploadedFileResult()
        {
            hasFailedUploads = false;

        }
        List<UploadedFile> fls = new List<UploadedFile>();
        public List<UploadedFile> files
        {
            get
            {
                return fls;
            }
            internal set
            {
                fls = value;

            }
        }

        //public const string ALL_FILES = "*";
        public void AddFile(UploadedFile file)
        {
            // validate file
            //get file Extension
            string exten = Path.GetExtension(file.name).ToLower();
            if (allowedExtensions.Count == 1 && allowedExtensions[0] == "*")
            {
                files.Add(file);
                return;
            }
            foreach (var item in allowedExtensions)
            {
                
                if (exten == item.ToLower())
                {
                    //pass  
                    files.Add(file);
                    success = true;
                    break;
                }
                else
                {
                    hasFailedUploads = true;
                }
            }
        }
        public bool success { get; set; }
        public bool hasFailedUploads { get; set; }
        public string errorMessage { get; set; }
        public List<string> allowedExtensions { get; set; }

        public string Serialize()
        {
            string result = JsonConvert.SerializeObject(this, Formatting.Indented);
            return result;
        }

    }
    [JsonObject(MemberSerialization = MemberSerialization.OptOut)]
    public class AsyncDataResponse<T>
    {
        public AsyncDataResponse()
        {
            IsArray = true;
        }

        public IEnumerable<T> Data
        {
            get;
            set;
        }
        public bool IsArray { get; set; }
        public Criteria Criteria
        {
            get;
            set;
        }

        public bool Success { get; set; }
        public string Message { get; set; }

        public string CallerId { get; set; }
        public string Serialize()
        {
            return JsonConvert.SerializeObject(this, MyConfig.DefaultJsonSettings);

        }
    }

    public class MyConfig
    {
        public static string GenerateResourceUrl(string targetRouteName, string controllerName, string actionName, RouteValueDictionary routeParams, RouteCollection routeTable)
        {

            string res = "";
            if (string.IsNullOrEmpty(targetRouteName))
            {
                return res;
            }
            HttpContext ctx = HttpContext.Current;

            try
            {

                HttpContextWrapper hctx = new HttpContextWrapper(ctx);
                res = UrlHelper.GenerateUrl(targetRouteName,
                    actionName,
                    controllerName,
                    routeParams,
                    routeTable,
                    hctx.Request.RequestContext,
                    false
                    );
            }
            catch (Exception err)
            {


            }

            return res.ToLower();

        }
        public static string GenerateResourceUrlWithDomainName(string targetRouteName, string controllerName, string actionName, RouteValueDictionary routeParams, RouteCollection routeTable)
        {

            string res = GetDomainName() + GenerateResourceUrl(targetRouteName, controllerName, actionName, routeParams, routeTable);


            return res.ToLower();

        }
        public static string GetDefaultUrlIfEmpty(string url, string defaultUrl)
        {
            if (string.IsNullOrEmpty(GenerateFileUrl(url)))
            {
                return defaultUrl;
            }
            return GenerateFileUrl(url);
        }

        public static string GetDefaultUrlWithDomainNameIfEmpty(string url, string defaultUrl)
        {
            if (string.IsNullOrEmpty(GenerateFileUrl(url)))
            {
                return defaultUrl;
            }
            return GenerateUrlWithDomainName(url);
        }
        public static Size Image650_350Size
        {
            get
            {
                return new Size(650, 350);
            }
        }

        public static string DefaultFolderAbsolutePath
        {
            get
            { 
                HttpContext ctx = HttpContext.Current;
                // if folder is not found, create it
                string path = ctx.Server.MapPath("~/11081980_27092014_05101990");
                if(!Directory.Exists(path))
                {
                    // create it 
                    Directory.CreateDirectory(path);

                }
                return path;
            }
        }

        public static string GetDomainName()
        { /// In other to generate a better Url for our images we should append domain info
            ///  eg http://www.skoologic.com/+ image url from source
            ///IdnHost
            HttpContext ctx = HttpContext.Current; 
            string domain = ctx.Request.Url.Scheme+"://"+ctx.Request.Url.Host+ ((ctx.Request.Url.Port > 0) ? ":" + ctx.Request.Url.Port :"").ToLower();
            // string domain = ctx.Request.Url.IdnHost;
            return domain;
        } 
        
        public static string RemoveDomainName(string urlWithDomain)
        {
            urlWithDomain = string.IsNullOrEmpty(urlWithDomain) ? "" : urlWithDomain;
            HttpContext ctx = HttpContext.Current;
            string domain = GetDomainName();
            urlWithDomain = urlWithDomain.ToLower();
            urlWithDomain = urlWithDomain.Replace(domain,"");
            return urlWithDomain;
        }
        public static string GenerateUrlWithDomainName(string urlPath)
        {

            string res = GetDomainName() + GenerateFileUrl(urlPath);

            return res;

        } 
        public static string GenerateFileUrl(string urlPath)
        {
           
            string res = "";
            if(string.IsNullOrEmpty(urlPath))
            {
                return res;
            }
            HttpContext ctx = HttpContext.Current;
           
            try
            { 
               
                HttpContextWrapper hctx = new HttpContextWrapper(ctx);
                if (File.Exists(ctx.Server.MapPath("~/" + urlPath)))
                {
                    string url = UrlHelper.GenerateContentUrl("~/" + urlPath, hctx);
                    res = url;

                }
            }
            catch (Exception err)
            {
                
                
            } 
           
            
            //HttpContextWrapper hctx = new HttpContextWrapper(ctx);
            //if (File.Exists(ctx.Server.MapPath("~/" + urlPath)))
            //{
            //    string url = domain+UrlHelper.GenerateContentUrl("~/" + urlPath, hctx);
            //    res = url;

            //}

            return res.ToLower();

        } 
      
        public static string GenerateFileUrl(string urlPath,HttpContextBase ctx)
        {
            string res = "";
            if (string.IsNullOrEmpty(urlPath))
            {
                return res;
            }
           
           
            if (File.Exists(ctx.Server.MapPath("~/" + urlPath)))
            {
                string url = UrlHelper.GenerateContentUrl("~/" + urlPath, ctx);
                res = url;

            }

            return res;

        }
        public static string GetDefaultProfilePicture(string gender)
        {
            string res = GenerateUrlWithDomainName("images/male.png");
           
          
//            if(gender.ToLower()  == Gender.Female.ToString().ToLower())
//            {
//                res = MyConfig.GenerateUrlWithDomainName("images/female.png");
//            }

            return res;
        } 
        public static JsonResult DefaultJsonResult(object data, JsonRequestBehavior jsBehavior)
        {
            JsonResult js = new JsonResult();
            js.ContentType = "application/json";
            js.JsonRequestBehavior = jsBehavior;
            js.Data = data;
            return js;
        }
        public static JsonResult DefaultJsonResult(object data)
        {
            return DefaultJsonResult(data, JsonRequestBehavior.AllowGet);
        }
        public static Size SmallestImageSize
        {
            get
            {
                return new Size(70, 70);
            }
        }
        public static Size Image300_350Size
        {
            get
            {
                return new Size(300, 350);
            }
        } 
        
        public static Size Image550_350Size
        {
            get
            {
                return new Size(550, 350);
            }
        } 
        public static Size ImageBannerSize
        {
            get
            {
                return new Size(1000, 300);
            }
        }
        
        public static Size ImageBannerSize2
        {
            get
            {
                return new Size(1200, 430);
            }
        }
        public static Size ImageBannerSizeMobile
        {
            get
            {
                return new Size(550, 100);
            }
        }
        public static Size ImageBannerSizeLarge
        {
            get
            {
                return new Size(1900, 750);
            }
        }
        public static Size LargeImageSize
        {
            get
            {
                return new Size(670, 670);
            }
        }
        public static Size SmallImageSize
        {
            get
            {
                return new Size(120, 120);
            }
        } 
        public static Size Image200Size
        {
            get
            {
                return new Size(200, 200);
            }
        }
        public static Size Image200_250Size
        {
            get
            {
                return new Size(200,350);
            }
        }
        public static Size MediumImageSize
        {
            get
            {
                return new Size(450, 450);
            }
        }
        public static Size FullHdImageSize
        {
            get
            {
                return new Size(1920, 1080);
            }
        }
        public static Size HdImageSize
        {
            get
            {
                return new Size(1020, 720);
            }
        }

        public static string ImageStoragePath
        {
            get
            {
                HttpContext ctx = HttpContext.Current;
                string res = "~/content/app/images/";
                if (ctx.Request.ApplicationPath == "/")
                {

                }
                string path = ctx.Server.MapPath(res);
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                return path;
            }
        }
        public static JsonSerializerSettings DefaultJsonSettings
        {
            get
            {
                JsonSerializerSettings js = new JsonSerializerSettings()
                {
                    ContractResolver = new CamelCasePropertyNamesContractResolver(),
                    DateFormatHandling = DateFormatHandling.IsoDateFormat,
                    NullValueHandling = NullValueHandling.Include,
                    TypeNameHandling =  TypeNameHandling.None,
                    DateTimeZoneHandling =  DateTimeZoneHandling.Utc,
                    ConstructorHandling = ConstructorHandling.Default,
//                    DefaultValueHandling = DefaultValueHandling.Ignore,
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
                   
                };

                return js;
            }
        }

        
    }
}
using System;
using System.Threading.Tasks;
using itrex.businessObjects.model.core.util;

namespace asom.apps.inOut.core
{

//    public static class UniqueCodeGenerator
//    {
//        public static string GetCode()
//        {
////            Thread.Sleep(50);
//            string res = Guid.NewGuid().ToString().Substring(0,5) + DateTime.Now.Second+DateTime.Now.Minute;
//           
//            return res.ToUpper();
//
//        }
//
//        public static string GetActivationCode()
//        {
//
//            Task.Delay(TimeSpan.FromMilliseconds(15));
//            string res =
//                $"{DateTime.Now.Millisecond}{(Guid.NewGuid().ToString().Substring(2, 8).ToUpper())}" +
//                $"-{Guid.NewGuid().ToString().ToUpper().Substring(2,5)}{new Random().Next(1, 1000)}";
//                
//           return res;
//
//        }
//    }

  public static class UniqueCodeGenerator
  {
    public static string GetCode()
    {
      //            Thread.Sleep(50);
      string res = Guid.NewGuid().ToString().Substring(0, 5) + DateTime.Now.Second + DateTime.Now.Minute + Util.RightString(Guid.NewGuid().ToString(), 5);

      return res.ToUpper();

    }

    public static string GetActivationCode()
    {

      Task.Delay(TimeSpan.FromMilliseconds(15));
      string res =
        $"{DateTime.Now.Millisecond}{(Guid.NewGuid().ToString().Substring(2, 8).ToUpper())}" +
        $"-{Guid.NewGuid().ToString().ToUpper().Substring(2, 5)}{new Random().Next(1, 1000)}";

      return res;

    }

    public static string NewRandomPassword()
    {
      string res = Guid.NewGuid().ToString().Substring(0, 9).Replace("-", "");

      return res.ToLower();

    }
  }



  public static class AppConstants
    {
        public const string TICKET_BACKDOOR_ENGINE  = "BACKDOOR_ENGINE";
        public const string TICKET_MANUAL_ENGINE  = "MANUAL_ENGINE";
        public const string TICKET_AUTO_ENGINE  = "AUTO_ENGINE";
        public const string TICKET_STATUS_PATIALLY_CONFIRMED  ="PATIALLY_CONFIRMED" ;
        public const string REGISTERED_USER  = "REGISTED_USER";
        public const string MESSAGE_DIRECRED_TO_GROUP = "MESSAGE_GROUP";
        public const string MESSAGE_DIRECRED_TO_CHANNEL = "MESSAGE_CHANNEL";
        public const string MESSAGE_DIRECRED_TO_USER = "MESSAGE_USER";
        public const string MESSAGET= "MESSAGE";
        public const string MESSAGE_COMMENT= "MESSAGE_COMMENT";
        public const string MESSAGE_COMMENT_REPLY= "MESSAGE_COMMENT_REPLY";
        public const string TICKET_GROUP_BTC="BITCOIN";
        public const string TICKET_GROUP_CASH="CASH";
        
        public const string TICKET_STATUS_PENDING  = "PENDING";  // When Queued and not yet merged with a Payer or Receiver
        public const string TICKET_STATUS_COMPLETE  = "COMPLETE"; // When the Transaction is Sealed
        public const string TICKET_STATUS_APPROVED  = "APPROVED"; // When Approved and due for Receiving
        public const string TICKET_STATUS_CANCELLED  = "CANCELLED"; // Cancelled TICKET
        public const string TICKET_STATUS_PATIALLY_COMPLETE  = "PATIALLY_COMPLETE"; // When Approved and due for Receiving
        public const string TICKET_STATUS_PAIRED  = "PAIRED"; // TICKET Paired with Reciever or Payer
        public const string TICKET_STATUS_CONFIRMED  = "CONFIRMED";
        public const string TICKET_STATUS_DUE_TO_RECEIVE  = "DUE TO RECIEVE";
        public const byte TICKET_TYPE_GET_HELP  = 1;
        public const byte TICKET_TYPE_PROVIDE_HELP  = 2;
        public const string SYS_USER_MANAGER_ACCOUNT  = "USER_MANAGER";


        
        public const string NAIRA = "₦";//U+20A6
        public const string SYS_ADMIN_ACCOUNT="SYSADMIN";
        public const string SYS_USER_ACCOUNT = "SYSUSER";
        public const string SYS_CHANNEL_ACCOUNT = "SYSCHANNEL";
        public const string SYS_CUSTOMER_ACCOUNT = "SYSCUSTOMER";


        public const string INVENTORY_ITEM_TYPE_PRODUCT = "PROD.";
        public const string INVENTORY_ITEM_TYPE_SERVICE = "SERV";
        public const string CUSTOMER_TYPE_WHOLESALE = "WHOLESALE";
        public const string CUSTOMER_TYPE_RETAIL = "RETAIL";
        public const string CUSTOMER_TYPE_DISTRIBUTOR = "DISTRIBUTOR";


        public const string GENDER_MALE = "MALE";
        public const string GENDER_FEMALE = "FEMALE";

        public const string MARITAL_STATUS_MARRIED = "MARRIED";
        public const string MARITAL_STATUS_SINGLE = "SINGLE";
        public const string MARITAL_STATUS_SEPERATED = "SEPERATED";
        public const string MARITAL_STATUS_DIVORCED = "DIVORCED";
        
        public const string INVOICE_STATUS_INVOICED= "INVOICED";
        public const string INVOICE_STATUS_OPEN = "OPEN";
        public const string INVOICE_STATUS_CANCELED = "CANCELED";
        public const string INVOICE_STATUS_PENDING = "PENDING";
        public const string INVOICE_STATUS_PAYMENT_OVERDUE = "OVERDUE";

        public const string DELIVERY_STATUS_NOT_DELIVERED = "NOT DELIVERED";
        public const string DELIVERY_STATUS_DELIVERED = "DELIVERED";


        public const string SALES_ITEMS_DISPATCH_TYPE_WAREHOUSE = "WAREHOUSE";
        public const string SALES_ITEMS_DISPATCH_TYPE_CHANNEL = "CHANNEL";

       
        public const string UI_TEMPLATE_1 = "1";//U+20A6
        public const string UI_TEMPLATE_2 = "2";
        public const string UI_TEMPLATE_3 = "3";
        public const string UI_TEMPLATE_4 = "4";
        public const string UI_TEMPLATE_5 = "5";//U+20A6
        public const string UI_TEMPLATE_6 = "6";
        public const string UI_TEMPLATE_7 = "7";

        
    }
}

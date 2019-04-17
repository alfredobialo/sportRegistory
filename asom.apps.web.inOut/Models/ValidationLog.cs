using System.Collections.Generic;

namespace asom.apps.web.Effectv.Models
{
    public class ValidationLog
    {
        public string FieldName { get; set; }
        public string FieldValue { get; set; }
        public string Message { get; set; }
        List<ValidationLog> logs = new List<ValidationLog>();
        public ValidationLog()
        {

        }

        public ValidationLog(string fieldName, string fieldValue, string message)
        {
            FieldName = fieldName;
            FieldValue = fieldValue;
            Message = message;
        }

        public void AddLog(string fieldName, string fieldValue, string message)
        {
            logs.Add(new ValidationLog(fieldName, fieldValue, message));
        }

        public void AddLog()
        {
            AddLog(FieldName, FieldValue, Message);
        }

        public List<ValidationLog> GetLogs()
        {

            return logs;

        }

    }
}
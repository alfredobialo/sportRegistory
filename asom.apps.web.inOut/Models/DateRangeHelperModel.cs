using System;
using System.Collections.Generic;
using itrex.businessObjects.model.core.util;

namespace asom.apps.web.inOut.Models
{
    public class DateRangeHelperModel
    {
        public string Title { get; set; }
        public DateRange DateInterval { get; set; }

        public string Description
        {
            get { return $"{Title} : Date Btw {DateInterval.StartDate:ddd, dd-MMM-yyyy} And {DateInterval.EndDate:ddd, dd-MMM-yyyy}"; }
        }


        public static IEnumerable<DateRangeHelperModel> GetDateHelpers()
        {
            
            List<DateRangeHelperModel> res  =   new List<DateRangeHelperModel>();
            res.Add(new DateRangeHelperModel()
            {
                Title = "Today",
                DateInterval = DateRange.Today()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Yesterday",
                DateInterval = DateRange.Yesterday()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "This Week",
                DateInterval = DateRange.ThisWeek()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "First Week this Month",
                DateInterval = DateRange.FirstWeekOfThisMonth()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Second Week this Month",
                DateInterval = DateRange.SecondWeekOfThisMonth()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Third Week this Month",
                DateInterval = DateRange.ThirdWeekOfThisMonth()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Fourth Week this Month",
                DateInterval = DateRange.FouthWeekOfThisMonth()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Current Month",
                DateInterval = DateRange.CurrentMonth()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Last Month",
                DateInterval = DateRange.PreviousMonth()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Current Quarter",
                DateInterval = DateRange.ThisQuarter()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Q1",
                DateInterval = DateRange.FirstQuarter()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Q2",
                DateInterval = DateRange.FirstQuarter()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Q3",
                DateInterval = DateRange.ThirdQuarter()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "Q4",
                DateInterval = DateRange.FouthQuarter()
                
            });
            res.Add(new DateRangeHelperModel()
            {
                Title = "This Year",
                DateInterval = DateRange.GetForWholeYear(DateTime.Today.Year)
                
            });
            return res;
        }

    }
}
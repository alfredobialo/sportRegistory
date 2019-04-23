using System.Collections.Generic;
using System;
using System.Linq;
namespace asom.apps.inOut.core.model.sports
{
    public class PerformerResult
    {
        // takes a collection of Judge Scores and formulate a result base on each category
        public string PerformerId { get; set; }
        public Performer    PerformerInfo { get; internal set; }
        public string GroupId { get; set; }
        public IEnumerable<IJudges> Judges { get; set; }
        public JudgeScore Score { get; set; }
    }
}
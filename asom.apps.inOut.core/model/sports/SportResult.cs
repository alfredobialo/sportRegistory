using System.Collections.Generic;
using System;
using System.Linq;
namespace asom.apps.inOut.core.model.sports
{
    public class SportResult
    {
        // takes a collection of Judge Scores and formulate a result base on each category
        public IEnumerable<IJudges> Judges { get; set; }
        public JudgeScore Score { get; set; }
    }
}
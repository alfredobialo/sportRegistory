using System.Collections.Generic;
using System;
using System.Linq;
using System.Xml.Linq;

namespace asom.apps.inOut.core.model.sports
{
    public class PerformerResult
    {
        public PerformerResult(IEnumerable<JudgeScore> scores)
        {
           
            
            // do the calc here
            /*Mark the first Two Lowest as Exclude   and    the  last two Highest as Excluded*/
            var theScore = scores.OrderBy(x => x.TechnicalScore)
                    .Take(2)
                ;
            foreach (var score in theScore)
            {
                score.IsExcludedTs = true;
            }
            var theScore2 = scores.OrderBy(x => x.AthleticScore)
                    .Take(2)
                ;
            foreach (var score in theScore2)
            {
                score.IsExcludedAs = true;
            }
            
            var theScorea = scores.OrderByDescending(x => x.TechnicalScore)
                    .Take(2)
                ;
            foreach (var score in theScorea)
            {
                score.IsExcludedTs = true;
            }
            var theScore2a = scores.OrderByDescending(x => x.AthleticScore)
                    .Take(2)
                ;
            foreach (var score in theScore2a)
            {
                score.IsExcludedAs = true;
            }
               ScoreEntries = scores; 
        }

        public IEnumerable<JudgeScore> ScoreEntries { get; private set; }
        // takes a collection of Judge Scores and formulate a result base on each category
        public decimal TotalTechScore => ScoreEntries.Where(x => !x.IsExcludedTs).Sum(x => x.TechnicalScore).GetValueOrDefault(0);
        public decimal TotalAthleScore => ScoreEntries.Where(x => !x.IsExcludedAs).Sum(x => x.AthleticScore).GetValueOrDefault(0);
        public double TechFactor { get; } = 0.7;
        public double AthleFactor { get; } = 0.3;
        public double TechResult=> Math.Round((double)TotalTechScore * TechFactor,2);
        public double AthleResult => Math.Round((double)TotalAthleScore * AthleFactor,2);
        public double Total => Math.Round(TechResult + AthleResult,2);
    }
}
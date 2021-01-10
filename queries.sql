
-- Question 1: Do teams do better (win more) in away games in general?

select ftresult, count(ftresult) from matchstats group by ftresult;

-- Found out that teams do not win more when they are the away team.






-- Question 2: Given that the betting odds are against a team, do they perform better at home than when they’re away.

-- Gives the result of the game and the odds that the hometeam will win. 
-- we only looked at rows where winLikelihood < 0 because that corresponds
-- to the odds being against the home team

create view oddsAgainstHome as select * from 
(select ftresult, winLikelihood from matchstats
natural join 
(select oddsid, hometeam, awayteam, winLikelihood from games 
natural join 
(select oddsid, -1 * ((b365h + bwh +whh + vch)/4 - (b365a + bwa +wha + vca)/4) as winLikelihood
from betting) as A) as B) as C
where winLikelihood < 0;


-- Gives the result of the game and the odds that the hometeam will win. 
-- we only looked at rows where winLikelihood > 0 because that corresponds
-- to the odds being against the away team

create view oddsAgainstAway as select * from 
(select ftresult, winLikelihood from matchstats
natural join 
(select oddsid, hometeam, awayteam, winLikelihood from games 
natural join 
(select oddsid, -1 * ((b365h + bwh +whh + vch)/4 - (b365a + bwa +wha + vca)/4) as winLikelihood
from betting) as A) as B) as C
where winLikelihood > 0;



-- probability of home team winning with odds against them
select 
((select count(ftresult) from oddsAgainstHome where ftresult='H') /
cast((select count(*) from oddsAgainstHome) as float)) as likelihood;

-- gives 0.29 probability of winning^



-- probability of away team winning with odds against them
select 
((select count(ftresult) from oddsAgainstAway where ftresult='A') /
cast((select count(*) from oddsAgainstAway) as float)) as likelihood;

-- give 0.20 probability of winning

-- Then given the odds are against a team, they are 45% more likely to win the
-- game if they are the home team







-- Question 3: Do referees give out more cards to away teams compared to home teams?

select sum(hometeamyellow) + sum(hometeamred) - 
(sum(awayteamyellow) + sum(awayteamred)) from referee;

-- result of query is -69 indicating that referees give out more cards to away teams than home teams





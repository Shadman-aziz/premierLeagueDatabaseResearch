DROP SCHEMA IF EXISTS PREMIERLEAGUE CASCADE;
CREATE SCHEMA PREMIERLEAGUE;
SET SEARCH_PATH TO PREMIERLEAGUE;

-- each team in the league with their corresponding number
-- of wins, losses and draws
CREATE TABLE TeamStats (
        --The name of the team
        TEAM varchar(50) NOT NULL,
        --The total number of wins of the team
        WINS integer NOT NULL,
        --The total number of losses of the team
        LOSSES integer NOT NULL,
        --The total number of draws of the team
        DRAW integer NOT NULL,
        PRIMARY KEY(TEAM)
);
-- each referee who have officiated games in the league
CREATE TABLE Referee (
        -- name of the referee
        REFEREE varchar(50) NOT NULL,
        -- name of the home team of game officiated
        HOMETEAM varchar(50) NOT NULL,
        -- name of the away team of game officiated
        AWAYTEAM varchar(50) NOT NULL,
        -- total number of fouls committed by the home team
        HOMETEAMFOULS smallint NOT NULL,
        -- total number of fouls committed by the away team
        AWAYTEAMFOULS smallint NOT NULL,
        -- total number of red cards committed by the home team
        HOMETEAMRED smallint NOT NULL,
        -- total number of yellow cards committed by the home team
        HOMETEAMYELLOW smallint NOT NULL,
        -- total number of red cards committed by the away team
        AWAYTEAMRED smallint NOT NULL,
        -- total number of yellow cards committed by the away team
        AWAYTEAMYELLOW smallint NOT NULL,
        PRIMARY KEY(REFEREE, HOMETEAM, AWAYTEAM),
        FOREIGN KEY(HOMETEAM)
        REFERENCES TEAMSTATS(TEAM),
        FOREIGN KEY(AWAYTEAM)
        REFERENCES TEAMSTATS(TEAM)

);
-- the betting odds for each game offered by a select number of companies
CREATE TABLE BETTING(
        -- an id to refer to the game that the odds are referencing
        ODDSID  smallint PRIMARY KEY,
        -- Bet365 home win odds
        B365H   decimal,
        -- Bet365 draw odds
        B365D   decimal,
        -- Bet365 away win odds
        B365A   decimal,
        -- Bet&Win home win odds
        BWH     decimal,
        -- Bet&Win draw odds
        BWD     decimal,
        -- Bet&Win away win odds
        BWA     decimal,
        -- William Hill home win odds
        WHH     decimal,
        -- William Hill draw odds
        WHD     decimal,
        -- William Hill away win odds
        WHA     decimal,
        -- VC Bet home win odds
        VCH     decimal,
        -- VC Bet draw odds
        VCD     decimal,
        -- VC Bet away win odds
        VCA     decimal
);

-- all the games over the course of the season
CREATE TABLE GAMES(
        -- name of home team of the game
        HOMETEAM varchar(50) NOT NULL,
        -- name of away team of the game
        AWAYTEAM varchar(50) NOT NULL,
        -- date of the game
        DATE date NOT NULL,
        -- time of the game
        TIME time NOT NULL,
        -- referee officiating the game
        REFEREE varchar(50) NOT NULL,
        -- oddsID associate with this game
        ODDSID smallint NOT NULL,
        PRIMARY KEY (HOMETEAM, AWAYTEAM),
        FOREIGN KEY (HOMETEAM)
        REFERENCES TEAMSTATS(TEAM),
        FOREIGN KEY (AWAYTEAM)
        REFERENCES TEAMSTATS(TEAM),
        FOREIGN KEY (ODDSID)
        REFERENCES BETTING(ODDSID)
);

-- all the stats regarding particular games
CREATE TABLE MATCHSTATS (
        -- name of home team of the game
        HOMETEAM varchar(50) NOT NULL,
        -- name of away team of the game
        AWAYTEAM varchar(50) NOT NULL,
        -- goals the home team has scored during entire 90 minutes of game
        FTHOMETEAMGOALS smallint NOT NULL,
        -- goals the away team has scored during entire 90 minutes of game
        FTAWAYTEAMGOALS smallint NOT NULL,
        -- result after the game has concluded, indicating which team has won
        FTRESULT char(1) NOT NULL,
        -- result after first half, indicating
        -- which team was winning at the break
        HTRESULT char(1) NOT NULL,
        PRIMARY KEY (HOMETEAM, AWAYTEAM),
        FOREIGN KEY (HOMETEAM)
        REFERENCES TEAMSTATS(TEAM),
        FOREIGN KEY (AWAYTEAM)
        REFERENCES TEAMSTATS(TEAM)

);
-- stats of teams when they play at home
CREATE TABLE HOMESTATS (
        -- name of team playing at home
        TEAM varchar(50) PRIMARY KEY,
        -- the average number of goals the team scores
        AVGHOMETEAMGOALS decimal NOT NULL,
        -- the average number of goals the team concedes
        AVGGOALSSCOREDAGAINST decimal NOT NULL,
        -- the number of cleansheets the team keeps,
        -- clean sheet refers to a game where the team concedes zero goals
        CLEANSHEETS smallint NOT NULL,
        FOREIGN KEY (TEAM)
        REFERENCES TEAMSTATS(TEAM)
);
-- stats of teams when they play at away
CREATE TABLE AWAYSTATS (
        -- name of team playing at away
        TEAM varchar(50) PRIMARY KEY,
        -- the average number of goals the team scores
        AVGAWAYTEAMGOALS decimal NOT NULL,
        -- the average number of goals the team concedes
        AVGGOALSSCOREDAGAINST decimal NOT NULL,
        -- the number of cleansheets the team keeps,
        -- clean sheet refers to a game where the team concedes zero goals
 	      CLEANSHEETS smallint NOT NULL,
        FOREIGN KEY (TEAM)
        REFERENCES TEAMSTATS(TEAM)
);

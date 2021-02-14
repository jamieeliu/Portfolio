use _team20_c2c;


-- Team 20: Select Statements (25)

-- --------------------------------------------------------------------------------------------------------------

#1. Order countries by the number of topsellers female in descending order. What country had the highest number of female topsellers?
select country, topsellers
from topsellersfemale
group by country 
order by topsellers desc; 

-- --------------------------------------------------------------------------------------------------------------

#2. What country are the most users from and what are those countries in english?
select englishtranslate(country), count(identifierhash)
from userdetails
group by country
order by count(identifierhash) desc; 

-- --------------------------------------------------------------------------------------------------------------

#3. How many andriod and ios users are there and what percent of our users have an andriod or an ios device? (helpful or android marketing Suggested app in app store)
select (select count(identifierhash) from userdetails where hasandroidapp=1) as NumberOfAndroidUsers,
round((((select count(identifierhash) from userdetails where hasandroidapp=1)/count(identifierhash))*100),2) as PercentOfAndriodUsers,
(select count(identifierhash) from userdetails where hasIosapp=1) as NumberOfIOSUsers,
round((((select count(identifierhash) from userdetails where hasIosapp=1)/count(identifierhash))*100),2) as PercentOfIOSUsers
from userdetails; 

-- --------------------------------------------------------------------------------------------------------------

#4. How many sales were there? How many sales does each gender have and what percent of total sales was it. 
use _team20_c2c;
select (sum(f.totalproductssold))+(sum(m.totalproductssold)) as TotalSales, sum(f.totalproductssold) as FemaleSellerSales, round((sum(f.totalproductssold)/((sum(f.totalproductssold))+(sum(m.totalproductssold)))*100),2) as PercentofFemaleSellerSales,
sum(m.totalproductssold) as MaleSellerSales, round((sum(m.totalproductssold)/((sum(f.totalproductssold))+(sum(m.totalproductssold)))*100),2) as PercentofMaleSellerSales
from malesellers m
join countries c
on m.country=c.frenchcountryname
join femalesellers f 
on c.frenchcountryname=f.country;

-- --------------------------------------------------------------------------------------------------------------

#5. What country have male and female top sellers and what is there total number top sellers with their male and female to sellers combined?
select c.frenchcountryname, f.topsellers, m.topsellers, f.topsellers+m.topsellers as totaltopsellers 
from topsellersmale m 
join countries c 
on m.country=c.frenchcountryname
join topsellersfemale f 
on c.frenchcountryname=f.country
group by c.frenchcountryname
order by f.topsellers+m.topsellers desc; 


#--------------------------------------------------------------------------


#6. Which language is most commonly spoken among users of the platform? 
SELECT language, COUNT(language) as 'Number of Speakers' FROM usersocialdata USE INDEX(userDemographics)
GROUP BY language
ORDER BY COUNT(language) DESC;

-- --------------------------------------------------------------------------------------------------------------

#7. Are there more male or female users? Show total counts in descending order.
SELECT gender, COUNT(gender) as 'Number per Gender' FROM usersocialdata USE INDEX(userDemographics)
GROUP BY gender
ORDER BY COUNT(gender) DESC;

-- --------------------------------------------------------------------------------------------------------------

#8. Do males or females have a higher number of total items bought?
SELECT SUM(f.totalbought) as 'Female: Total Items Bought', SUM(m.totalbought) as 'Male: Total Items Bought' FROM malesellers m
JOIN countries c ON c.frenchcountryname = m.country
JOIN femalesellers f ON c.frenchcountryname = f.country;

-- --------------------------------------------------------------------------------------------------------------

#9. Which countries are the most popular in terms of having the highest number of items sold (more than 500 sold) by both male and female users in those countries? 
SELECT country, sex, totalproductssold, popularcountries(totalproductssold)
FROM malesellers
WHERE popularcountries(totalproductssold) ='Popular country with most sought after listings'
UNION 
SELECT country, sex, totalproductssold, popularcountries(totalproductssold)
FROM femalesellers USE INDEX(FemaleSellersInfo)
WHERE popularcountries(totalproductssold) ='Popular country with most sought after listings'
ORDER BY sex, totalproductssold DESC;

-- --------------------------------------------------------------------------------------------------------------

#10. What are the top 5 countries in terms of number of male users?  Show all colunms for these 5 countries.
#Step 1: Top 5 number of male users
SELECT DISTINCT numberOfSellers FROM malesellers
	ORDER BY numberOfSellers DESC
    LIMIT 5;
#Step 2: Select min of the top 5
SELECT min(numberOfSellers) FROM 
	(SELECT DISTINCT numberOfSellers FROM malesellers
	ORDER BY numberOfSellers DESC
    LIMIT 5) sq;
#Step 3: Find countries with number of male users = or > than Step 2
SELECT * FROM malesellers 
	WHERE numberOfSellers >= 
		(SELECT min(numberOfSellers) FROM 
			(SELECT DISTINCT numberOfSellers FROM malesellers
				ORDER BY numberOfSellers DESC
					LIMIT 5) sq)
                    ORDER BY numberOfSellers;
                    	
                        
-- --------------------------------------------------------------------------------------------------------------                        
                        
#11. What is the max amount bought/sold from male and female users?
select max(productsBought) maxProductsBought, max(productsSold) maxProductsSold, gender
from userproducts
group by gender;
 
 -- --------------------------------------------------------------------------------------------------------------

#12. What is the average products pass rate by country ordered by highest to lowest?
select identifierHash, avg(productsPassRate) avgpassrate, country
from userproducts
group by country
order by avg(productsPassRate) desc;

-- --------------------------------------------------------------------------------------------------------------

#13. What are the top 3 countries by total amount of application users? 
select country, count(hasAnyApp) as appusers
from userdetails
group by country
having count(hasAnyApp) >= (select min(app) from 
(select distinct count(hasAnyApp) as app from userdetails
group by country order by app desc
limit 3)sq)
order by count(hasAnyApp) desc;

-- --------------------------------------------------------------------------------------------------------------

#14. Which users have the highest amount of social media followers? What countries are they from (returns English translation) and how many products have they sold?
select identifierHash, socialNbFollowers, sum(productsSold) totprodsold, EnglishCountryName
from userproducts p
join usersocialdata usd using(identifierHash)
join seniority s using(identifierHash)
join countries c on s.country = c.FrenchCountryName
group by identifierHash
order by socialNbFollowers desc
limit 5;

-- --------------------------------------------------------------------------------------------------------------

#15. What are is the average seniority by country (English translation) from the most popular countries (by total users)?
select EnglishCountryName, avg(seniorityAsYears) avgSeniority, count(country) totalUsers
from seniority s
join countries c on s.country = c.FrenchCountryName
group by s.country 
order by count(country) desc, avg(seniorityAsYears) desc
limit 10;                       
                        
                        
#--------------------------------------------------------------------------

#16. Which countries do not have male users? 
-- Assuming 1 on the user details table represents males
SELECT Country, Gender, count(gender)
FROM userSocialData
WHERE gender != 'M'
GROUP BY country, Gender
HAVING COUNT(country) = 1
ORDER BY country ASC, Gender Desc;

-- --------------------------------------------------------------------------------------------------------------

#17. What languages are spoken by users in each country?
## Order by Number of Speakers Desc
SELECT Country,
	(CASE WHEN language = 'en' THEN 'Enlgish'
	WHEN language = 'fr' THEN 'French'
    WHEN language = 'it' THEN 'Italian'
    WHEN language = 'de' THEN 'German'
    WHEN language = 'es' THEN 'Spanish'
    ELSE 'Other'
    END) AS Language,
    COUNT(language) AS 'Number of Speakers'
FROM userdetails
GROUP BY country, language
ORDER BY COUNT(Language) DESC;

-- --------------------------------------------------------------------------------------------------------------

#18. How does the avg number of follows and followers compare between users with and without profile pictures?
-- does 0 or 1 indicate a profile picture?, O = No Profile Pic
	SELECT 'Profile Picture', AVG(usd.socialNbFollowers) AS 'Avg Followers', AVG(usd.socialNbFollows) AS 'Avg Follows'
	FROM usersocialdata AS usd
	JOIN userdetails ud ON ud.identifierHash=usd.identifierHash
	WHERE ud.hasprofilepicture = '1'
UNION
	SELECT 'No Profile Picture', AVG(usd.socialNbFollowers) AS 'Avg Followers', AVG(usd.socialNbFollows) AS 'Avg Follows'
	FROM usersocialdata AS usd
	JOIN userdetails ud ON ud.identifierHash=usd.identifierHash
	WHERE ud.hasprofilepicture = '0';

-- --------------------------------------------------------------------------------------------------------------

#19. How do top purchasing users compare with with having/not having a profile picture (Join)
--  0 = No profile pic
SELECT up.identifierHash, up.productsBought,
	(
		CASE WHEN up.productsBought >= 100 AND ud.hasProfilePicture = 1 THEN 'Top Buyer With Profile Pic'
			WHEN up.productsBought >= 100 AND ud.hasProfilePicture = 0 THEN 'Top Buyer Without Profile Pic'
			WHEN up.productsBought >= 50  AND  up.productsBought < 100  AND ud.hasProfilePicture = 1 THEN 'Mid Level Buyer With Profile Pic'
            WHEN up.productsBought >= 50  AND  up.productsBought < 100  AND ud.hasProfilePicture = 0 THEN 'Mid Level Buyer Without Profile Pic'
			WHEN up.productsBought >= 25  AND  up.productsBought < 50  AND ud.hasProfilePicture = 1 THEN 'Basic Level Buyer With Profile Pic'
            WHEN up.productsBought >= 25  AND  up.productsBought < 50  AND ud.hasProfilePicture = 0 THEN 'Basic Level Buyer Without Profile Pic'
            WHEN up.productsBought >= 1  AND  up.productsBought < 25 AND ud.hasProfilePicture = 1 THEN 'Infrequent Buyer With Profile Pic'
            WHEN up.productsBought >= 1  AND  up.productsBought < 25 AND ud.hasProfilePicture = 0 THEN 'Infrequent Buywer Without Profile Pic'
            ELSE 'No Purchase Record'
            END 
	) a
FROM userproducts AS up
JOIN userdetails ud ON ud.identifierHash=up.identifierHash
WHERE up.productsBought != 0
ORDER BY productsBought DESC;

-- --------------------------------------------------------------------------------------------------------------

#20. What users have sold and bought more than 25 products? (Subquery)

SELECT IdentifierHash, Country, productsBought, productsSold
FROM userProducts
WHERE productsBought IN 
	(SELECT productsBought
	FROM userProducts
	WHERE productsBought >=25 )
AND productsSold IN (SELECT productsSold
	FROM userProducts
	WHERE productsSold >= 25)
ORDER BY Country ASC;

-- --------------------------------------------------------------------------------------------------------------


#21.
## Which top 5 countries have the best sold ratio from female sellers?
select country, bestsoldratio from topsellersfemale
order by bestsoldratio desc
limit 5;

-- --------------------------------------------------------------------------------------------------------------

#22.
## What is the total product wished for between males and females? 
select gender, sum(productsWished) from userproducts
group by gender;

-- --------------------------------------------------------------------------------------------------------------

#23.
## How many top sellers in France use Android and IOS apps? How many social followers do these top sellers have combined?
select country, topsellers, sum(socialNbFollowers), sum(ud.hasAndroidApp) as '# of Android App User', sum(ud.hasIosApp) as
'# of IOS App User' from topsellersproduct
join usersocialdata usd using(country)
join userdetails ud using(country)
where country = 'France';

-- --------------------------------------------------------------------------------------------------------------

#24.
## What are the top 5 users when it comes to products sold at 100% productPassRate?
select ud.identifierHash, productsSold, productsPassRate AS '% of products meeting product description' from userproducts 
join userdetails ud using(identifierHash)
where productsPassRate = 100
group by identifierHash
order by productsSold desc
limit 5;

-- --------------------------------------------------------------------------------------------------------------

#25.
## How many sellers with a best sold ratio greater than 1, does each country have?
select country, sellers from topsellersproduct
where totalproductssold IN (select totalproductssold from topsellersproduct where bestsoldratio > 1 );

-- --------------------------------------------------------------------------------------------------------------

## Team 20: Indexes, Functions, and Stored Procedure, Trigger

-- --------------------------------------------------------------------------------------------------------------

-- Indexes (3)

CREATE INDEX userDemographics ON _team20_c2c.usersocialdata (country, gender, language);
CREATE INDEX FemaleSellersInfo ON _team20_c2c.femalesellers (totalproductssold, totalbought, country, sex);
CREATE INDEX ProductsListedAndSold ON _team20_c2c.userproducts (country, productsListed, productsSold);

-- --------------------------------------------------------------------------------------------------------------

-- Function 1.
drop function if exists PopularCountries;

DELIMITER //
CREATE FUNCTION PopularCountries (totalProductsSold int) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE sellerLvl VARCHAR(50);
    IF totalProductsSold > 500 THEN set sellerLvl = 'Popular country with most sought after listings';
	ELSEIF totalProductsSold < 100 THEN set sellerLvl = 'Unpopular country with least sought after items';
    ELSE SET sellerLvl = 'Country with average number of sought after items';
    END IF;
RETURN (sellerLvl);
END //
DELIMITER ;

-- Test the Function
select country, PopularCountries(totalProductsSold) from malesellers;


-- Function 2.
drop function if exists EnglishTranslate;

delimiter //
create function EnglishTranslate(input_frenchname varchar(50))
returns varchar(50)
deterministic
begin 
declare EnglishName varchar(50);
set EnglishName=(select englishcountryname
from countries where input_frenchname=frenchcountryname);
return (englishname);
end//
delimiter ; 

-- Test the Function
select country, englishtranslate(country) from topsellersmale;


-- --------------------------------------------------------------------------------------------------------------

-- Stored Procedure
	-- This procedure calculates two user ratios: One to compare the number of products listed and products sold,
	-- and one to compare the number of products wished vs products bought. This can help us to see user's activity
	-- levels relative to their tendency to purchase or sell

DROP PROCEDURE IF EXISTS userRatio;

DELIMITER // 

CREATE PROCEDURE userRatio (
	IN idNo INT,
    IN prodListed INT,
    IN prodSold INT,
    IN prodWished INT,
    IN prodBought INT,
    OUT sellRatio DECIMAL(10,2),
    OUT buyRatio DECIMAL (10,2)
)
BEGIN
	SET sellRatio = (SELECT productsListed / productsSold
						FROM userProducts
                        WHERE idNo = identifierHash
                        GROUP BY identifierHash );
	
	SET buyRatio = (SELECT productsWished/productsBought
						FROM userProducts
                        WHERE idNo = identifierHash
                        GROUP BY identifierHash );
END //

DELIMITER ;

-- --------------------------------------------------------------------------------------------------------------
## Testing the SP: 
-- Calling on the user ratio funcion for
	-- user # 1, who has the most products sold (174)
    -- user # 1145, who has the most products purchased (405)

CALL userRatio(1, @prodListed, @prodSold, @prodWished, @prodBought, @sellRatio, @buyerRatio);
SELECT 1, @sellRatio, @buyerRatio;

CALL userRatio(1145, @prodListed, @prodSold, @prodWished, @prodBought, @sellRatio, @buyerRatio);
SELECT 1145, @sellRatio, @buyerRatio;
-- --------------------------------------------------------------------------------------------------------------

-- Trigger

drop trigger if exists capCountryName;

DELIMITER // 
CREATE TRIGGER capCountryName 
BEFORE INSERT ON  countries 
FOR EACH ROW 
	BEGIN 
		SET NEW.FrenchCountryName = CONCAT(UPPER(SUBSTRING(NEW.FrenchCountryName, 1, 1) ), LOWER(SUBSTRING(NEW.FrenchCountryName FROM 2 )));
	END //
DELIMITER ;

-- Testing the Trigger
insert into countries(CountryNumberCode, FrenchCountryName, EnglishCountryName)
values (201, 'boulder Republic', 'Colorado');

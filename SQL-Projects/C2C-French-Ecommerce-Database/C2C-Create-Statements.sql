use _team20_c2c;

-- Team 20 Create Table Statments

#Dropping tables 
/*DROP TABLE IF EXISTS  UserDetails;
DROP TABLE IF EXISTS  UserProducts;
DROP TABLE IF EXISTS  UserSeniority;
DROP TABLE IF EXISTS  UserSocialData;
DROP TABLE IF EXISTS  FemaleBuyersByCountry;
DROP TABLE IF EXISTS  MaleBuyersByCountry;
DROP TABLE IF EXISTS FemaleSellers;
DROP TABLE IF EXISTS MaleSellers;
DROP TABLE IF EXISTS TopSellersMale;
DROP TABLE IF EXISTS TopSellersFemale;
DROP TABLE IF EXISTS TopSellersProduct;*/


CREATE TABLE IF NOT EXISTS  Countries(
CountryNumberCode int not null,
FrenchCountryName varchar(50) not null,
EnglishCountryName varchar(50) not null,
primary key (FrenchCountryName)); 


CREATE TABLE IF NOT EXISTS  UserDetails(
identifierHash int auto_increment,
country varchar(30),
language varchar(25),
gender varchar(1),
civilityGenderId INT,
civilityTitle varchar(4),
hasAnyApp BOOL,
hasAndroidApp BOOL,
hasIosApp BOOL,
hasProfilePicture BOOL,
daysSinceLastLogin int,
countryCode varchar(3),
primary key (identifierHash)); 


CREATE TABLE IF NOT EXISTS UserProducts(
identifierHash int NOT NULL,
type varchar (20),
Country varchar(50),
Language varchar(100),
productsListed int,
productsSold int,
productsPassRate int,
productsWished int,
productsBought int,
gender varchar(1),
countryCode varchar(3),
Primary Key (identifierHash));


CREATE TABLE IF NOT EXISTS  UserSeniority(
identifierHash int auto_increment,
country varchar(50),
language varchar(100),
gender varchar(1),
civilityGenderId varchar(45),
civilityTitle varchar(4),
seniority int,
seniorityAsMonths int,
seniorityAsYears int,
countryCode varchar(3),
primary key (identifierHash)); 


CREATE TABLE IF NOT EXISTS UserSocialData (
identifierHash INT NOT NULL,
country VARCHAR(100),
language VARCHAR(2),
socialNbFollowers int,
socialNbFollows int,
socialProductsLiked DEC(10,2),
gender CHAR(1),
civilityGenderId INT(1),
civilityTitle VARCHAR(4),
countryCode VARCHAR(3),
primary key (identifierHash));



CREATE TABLE FemaleBuyersByCountry (
country VARCHAR(100),
buyers int,
topbuyers int,
topbuyerratio DEC(10,2),
femalebuyers int,
topfemalebuyers int,
femalebuyersratio DEC(10,2),
topfemalebuyersratio DEC(10,2),
boughtperwishlistratio DEC(10,2),
boughtperlikeratio DEC(10,2),
topboughtperwishlistratio DEC(10,2),
topboughtperlikeratio DEC(10,2),
totalproductsbought int,
totalproductswished int,
totalproductsliked int,
toptotalproductsbought int,
toptotalproductswished int,
toptotalproductsliked int,
meanproductsbought DEC(10,2),
meanproductswished DEC(10,2),
meanproductsliked DEC(10,2),
topmeanproductsbought DEC(10,2),
topmeanproductswished DEC(10,2),
topmeanproductsliked DEC(10,2),
meanofflinedays DEC(10,2),
topmeanofflinedays DEC(10,2),
meanfollowers DEC(10,2),
meanfollowing DEC(10,2),
topmeanfollowers DEC(10,2),
topmeanfollowing DEC(10,2),
primary key(country)
);


CREATE TABLE MaleBuyersByCountry (
country VARCHAR(100),
buyers int,
topbuyers int,
topbuyerratio DEC(10,2),
malebuyers int,
topmalebuyers int,
malebuyersratio DEC(10,2),
topmalebuyersratio DEC(10,2),
boughtperwishlistratio DEC(10,2),
boughtperlikeratio DEC(10,2),
topboughtperwishlistratio DEC(10,2),
topboughtperlikeratio DEC(10,2),
totalproductsbought int,
totalproductswished int,
totalproductsliked int,
toptotalproductsbought int,
toptotalproductswished int,
toptotalproductsliked int,
meanproductsbought DEC(10,2),
meanproductswished DEC(10,2),
meanproductsliked DEC(10,2),
topmeanproductsbought DEC(10,2),
topmeanproductswished DEC(10,2),
topmeanproductsliked DEC(10,2),
meanofflinedays DEC(10,2),
topmeanofflinedays DEC(10,2),
meanfollowers DEC(10,2),
meanfollowing DEC(10,2),
topmeanfollowers DEC(10,2),
topmeanfollowing DEC(10,2),
primary key(country)
);



CREATE TABLE IF NOT EXISTS MaleSellers (
country varchar(45) NOT NULL, 
sex varchar(4) NOT NULL,
numberOfSellers int,
meanProductsSold dec(10,2), 
meanProductsListed dec(10,2), 
meanSellerPassrate dec(10,3), 
totalProductsSold int,
totalProductsListed int,
meanProductsBought dec(10,2), 
meanProductsWished dec(10,2), 
meanProductsLiked dec(10,2), 
totalBought int,
totalWished int,
totalProductsLiked int,
meanFollowers dec(10,2),
meanFollows dec(10,2), 
percentOfAppusers int,
percentOfiosUsers int,
meanSeniority dec(10,2),
PRIMARY KEY (country)
);


CREATE TABLE IF NOT EXISTS FemaleSellers (
country varchar(45) NOT NULL, 
sex varchar(10) NOT NULL,
numberOfSellers int,
meanProductsSold dec(10,2), 
meanProductsListed dec(10,2), 
meanSellerPassrate dec(10,3), 
totalProductsSold int,
totalProductsListed int,
meanProductsBought dec(10,2), 
meanProductsWished dec(10,2), 
meanProductsLiked dec(10,2), 
totalBought int,
totalWished int,
totalProductsLiked int,
meanFollowers dec(10,2),
meanFollows dec(10,2), 
percentOfAppusers int,
percentOfiosUsers int,
meanSeniority dec(10,2),
primary key (country)
);



CREATE TABLE IF NOT EXISTS TopSellersMale( 
country varchar(45),
sellers int not null,
topsellers int, 
topsellerratio int, 
malesellers int,
topmalesellers int,
countrysoldratio dec(10,2),
bestsoldratio dec(10,2),
primary key(country)
);

drop table TopsellersFemale;
CREATE TABLE IF NOT EXISTS TopSellersFemale(
country varchar(45),
sellers int not null,
topsellers int, 
topsellerratio int, 
femalesellersratio dec(10,2),
topfemalesellersratio dec(10,2),
femalesellers int,
topfemalesellers int,
countrysoldratio dec(10,2),
bestsoldratio dec(10,2)
);

drop table topSellersProduct;
CREATE TABLE IF NOT EXISTS topSellersProduct(
country varchar(45),
sellers int not null,
topsellers int, 
topsellerratio dec(10,2), 
countrysoldratio dec(10,2),
bestsoldratio dec(10,2),
toptotalproductssold int,
totalproductssold int,
toptotalproductslisted int,
totalproductslisted int,
topmeanproductssold dec(10,10),
topmeanproductslisted dec(10,10),
meanproductssold dec(10,10),
meanproductslisted dec(10,10),
meanofflinedays dec(10,2),
topmeanofflinedays dec(10,2),
meanfollowers dec(10,2),
meanfollowing dec(10,2),
topmeanfollowers dec(10,2),
topmeanfollowing dec(10,2)
);



#DONE
ALTER TABLE UserDetails 
ADD CONSTRAINT fk_UserDetails
FOREIGN KEY (identifierHash) REFERENCES UserProducts (identifierHash);

#DONE
ALTER TABLE UserProducts 
ADD CONSTRAINT fk_UserProducts
FOREIGN KEY (identifierHash) REFERENCES UserSocialData (identifierHash);

#DONE
ALTER TABLE UserSocialData 
ADD CONSTRAINT fk_UserSocialData
FOREIGN KEY (identifierHash) REFERENCES Seniority (identifierHash);

ALTER TABLE Seniority 
ADD CONSTRAINT fk_UserSeniority
FOREIGN KEY (country) REFERENCES countries (FrenchCountryName);

ALTER TABLE MaleSellers 
ADD CONSTRAINT fk_MaleSellers
FOREIGN KEY (country) REFERENCES  countries (FrenchCountryName);

ALTER TABLE FemaleSellers
ADD CONSTRAINT fk_FemaleSellers
FOREIGN KEY (country) REFERENCES  countries (FrenchCountryName);

ALTER TABLE femalebuyersbycountry 
ADD CONSTRAINT fk_femalebuyersbycountry 
FOREIGN KEY (country) REFERENCES  countries (FrenchCountryName);

ALTER TABLE malebuyersbycountry 
ADD CONSTRAINT fk_malebuyersbycountry 
FOREIGN KEY (country) REFERENCES  countries (FrenchCountryName);

ALTER TABLE TopSellersFemale 
ADD CONSTRAINT fk_TopSellersFemale
FOREIGN KEY (country) REFERENCES countries (FrenchCountryName);

ALTER TABLE TopSellersMale 
ADD CONSTRAINT fk_TopSellersMale
FOREIGN KEY (country) REFERENCES  countries (FrenchCountryName);

ALTER TABLE TopSellersProduct 
ADD CONSTRAINT fk_TopSellersProduct
FOREIGN KEY (country) REFERENCES countries (FrenchCountryName);

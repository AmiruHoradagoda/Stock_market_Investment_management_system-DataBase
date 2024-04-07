CREATE DATABASE IF NOT EXISTS Stock_market_Investment_management_system;
USE Stock_market_Investment_management_system;

-- (1) Create StockExchange table (D)
CREATE TABLE StockExchange (
    StockExchangeId VARCHAR(10) PRIMARY KEY NOT NULL,
    CEO VARCHAR(50) NOT NULL,
    ExchangeLocation VARCHAR(50) NOT NULL,
    Headquarters VARCHAR(50)
);
INSERT INTO StockExchange (StockExchangeID, CEO, ExchangeLocation, Headquarters)
VALUES 
    ('NYSE', 'Stacey Cunningham', 'New York, USA', 'New York, USA'),
    ('NASDAQ', 'Adena Friedman', 'New York, USA', 'New York, USA'),
    ('LSE', 'Julia Hoggett', 'London, UK', 'London, UK'),
    ('SSE', 'Huang Hongyuan', 'Shanghai, China', 'Shanghai, China'),
    ('HKEX', 'Nicolas Aguzin', 'Hong Kong', 'Hong Kong'),
    ('TSX', 'John McKenzie', 'Toronto, Canada', 'Toronto, Canada'),
    ('BSE', 'Ashishkumar Chauhan', 'Mumbai, India', 'Mumbai, India');
-- (2) Create Trader table(D)
CREATE TABLE Trader (
    TraderId VARCHAR(10) PRIMARY KEY NOT NULL,
    TraderName VARCHAR(50) NOT NULL
);
INSERT INTO Trader (TraderId, TraderName)
VALUES 
    ('JSTR1', 'John Smith'),
    ('JDTR2', 'Jane Doe'),
    ('MLTR3', 'Michael Lee'),
    ('AJTR4', 'Alice Johnson'),
    ('DWTR5', 'David Williams'),
    ('ETTR6', 'Emma Thompson'),
    ('LBTR7', 'Lucas Brown'),
    ('APTR8', 'Asitha Pathirane'),
    ('AMTR9', 'Amiru Mithsn'),
    ('CVTR10', 'Chamara Vishwa'),
    ('RVTR11', 'Rochaka Navarth'),
    ('JITR12', 'Janith Iddamalgoda'),
    ('HLTR13', 'Harsha Lankanath'),
    ('HSTR14', 'Hirusha Sdesh');


-- (3) Create Broker table(D)
CREATE TABLE TradeBroker (
    BrokerId VARCHAR(10) PRIMARY KEY NOT NULL,
    BrokerName VARCHAR(50) NOT NULL,
    ContactNo VARCHAR(20)
);
INSERT INTO TradeBroker (BrokerId, BrokerName, ContactNo)
VALUES 
    ('STBR1', 'Smith Trading Co.', '1-202-555-143'),
    ('JIBR2', 'Johnson Investments', '1-212-555-234'),
    ('ABBR3', 'Anderson Brokers', '1-416-555-345'),
    ('TWBR4', 'Thompson Wealth', '44-20-5555-456'),
    ('EPBR5', 'Edwards & Partners', '61-2-5550-567'),
    ('PFBR6', 'Patel Financials', '91-22-5556-678'),
    ('KLBR7', 'Kim & Lee Securities', '82-2-555-789');

-- (4) Create Depository table(D)
CREATE TABLE Depository (
    DepositoryId VARCHAR(10) PRIMARY KEY NOT NULL,
    DepositoryName VARCHAR(50) NOT NULL
);
INSERT INTO Depository (DepositoryId, DepositoryName)
VALUES 
    ('NSDL', 'National Securities Depository Limited'),
    ('CDSL', 'Central Depository Services (India) Limited'),
    ('SGX', 'Singapore Exchange'),
    ('DTCC', 'The Depository Trust & Clearing Corporation'),
    ('EUCL', 'Euro Belgium'),
    ('CBAG', 'Clearstream Banking A.G'),
    ('KLR', 'Keller Ltd');
-- (5) Create DematAccount table(D)
CREATE TABLE DematAccount (
    AccountNo VARCHAR(20) PRIMARY KEY NOT NULL, 
    DepositoryId VARCHAR(10) NOT NULL,
    BrokerId VARCHAR(10),
    TraderId VARCHAR(10) NOT NULL,
    CONSTRAINT FK_Depository FOREIGN KEY (DepositoryId) REFERENCES Depository(DepositoryId) ON DELETE CASCADE,
    CONSTRAINT FK_trader_account FOREIGN KEY (TraderId) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    CONSTRAINT FK_DematAccount_Broker FOREIGN KEY (BrokerId) REFERENCES TradeBroker(BrokerId) ON DELETE SET NULL
);
INSERT INTO DematAccount (DepositoryID, BrokerID, TraderID, AccountNo)
VALUES 
    ('NSDL', 'TWBR4', 'JITR12', 'NST4J12'),
    ('KLR', 'EPBR5', 'RVTR11', 'KLE5R11'),
    ('EUCL', 'PFBR6', 'AJTR4', 'EUP6A4'),
    ('DTCC', 'STBR1', 'JSTR1', 'DTS1J1'),
    ('SGX', 'JIBR2', 'JDTR2', 'SGJ2J2'),
    ('NSDL', 'ABBR3', 'MLTR3', 'NSA3M3'),
    ('CDSL', 'KLBR7', 'LBTR7', 'CDK7L7'),
    ('CBAG', 'TWBR4', 'JITR12', 'CBT4J2');

-- (6) Create Company table(D)
CREATE TABLE Company (
    CompanyId VARCHAR(10) PRIMARY KEY NOT NULL,
    CompanyName VARCHAR(50) NOT NULL,
    CompanyOwner VARCHAR(50) NOT NULL
);
INSERT INTO Company (CompanyId, CompanyName, CompanyOwner)
VALUES
    ('APPL01', 'Apple Inc.', 'Tim Cook'),
    ('TSL02', 'Tesla Inc.', 'Elon Musk'),
    ('MCR03', 'Microsoft', 'Satya Nadella'),
    ('AMZ04', 'Amazon', 'Andy Jassy'),
    ('ALP05', 'Alphabet', 'Sundar Pichai'),
    ('SAM06', 'Samsung Electronics Co., Ltd.', 'Kim Ki-nam'),
    ('VOLO7', 'Volkswagen AG', 'Herbert Diess');

-- (7) Create Share table(D)
CREATE TABLE Share (
    -- ShareType+CompanyName = shareId
    ShareID VARCHAR(10) PRIMARY KEY NOT NULL,
    CompanyID VARCHAR(10) NOT NULL,
    ShareType VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    DividendPerShare FLOAT NOT NULL,
    -- given value for share by company is Par value
    ParValue FLOAT NOT NULL,
    CONSTRAINT FK_Share_Company FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID) ON DELETE CASCADE
);
INSERT INTO Share (ShareID, CompanyID, ShareType, Quantity, DividendPerShare, ParValue)
VALUES 
    ('CMAPP', 'APPL01', 'COMMON', 140000000, 0.001, 0.01),
    ('CMTSL', 'TSL02', 'COMMON', 165000000, 0.003921569, 0.04),
    ('CMMCR', 'MCR03', 'COMMON', 140000000, 0.000102041, 0.001),
    ('CMAMZ', 'AMZ04', 'COMMON', 158000000, 0.001536885, 0.015),
    ('CMALP', 'ALP05', 'COMMON', 185000000, 0.000181818, 0.002),
    ('CMSAM', 'SAM06', 'COMMON', 128000000, 0.000669856, 0.007),
    ('CMVOL', 'VOLO7', 'COMMON', 135000000, 0.001111111, 0.012),
    ('PREAPP', 'APPL01', 'PREFERED', 18900000, 0.000994854, 0.0058),
    ('PRETSL', 'TSL02', 'PREFERED', 12340000, 0.001543779, 0.0067),
    ('PREMCR', 'MCR03', 'PREFERED', 14900000, 0.001927195, 0.009),
    ('PREAMZ', 'AMZ04', 'PREFERED', 16700000, 0.000267686, 0.0014),
    ('PREALP', 'ALP05', 'PREFERED', 19010000, 0.001648148, 0.0089),
    ('PRESAM', 'SAM06', 'PREFERED', 12390000, 0.002237136, 0.01),
    ('PREVOL', 'VOLO7', 'PREFERED', 16700000, 0.002669405, 0.013);



-- (8) Create StockSymbol table
CREATE TABLE StockSymbol (
    -- Created by using share ID and StockExchangeId 
    TickerSymbol VARCHAR(20) PRIMARY KEY NOT NULL,
    StockExchangeId VARCHAR(10) NOT NULL,
    ShareId VARCHAR(10) NOT NULL,
    CONSTRAINT FK_StockSymbol_StockExchange FOREIGN KEY (StockExchangeId) REFERENCES StockExchange(StockExchangeId) ON DELETE CASCADE,
    CONSTRAINT FK_StockSymbol_Share FOREIGN KEY (ShareId) REFERENCES Share(ShareID) ON DELETE CASCADE
);
INSERT INTO StockSymbol (TickerSymbol, StockExchangeId, ShareId)
VALUES 
    ('AAPLNYCM', 'NYSE', 'CMAPP'),
    ('TSLANASPRE', 'NASDAQ', 'PRETSL'),
    ('MSFTBSCM', 'BSE', 'CMMCR'),
    ('600887SSCM', 'SSE', 'CMAMZ'),
    ('9988HKPRE', 'HKEX', 'PREALP'),
    ('SSNLFTSCM', 'TSX', 'CMSAM'),
    ('VOW3BSCM', 'BSE', 'CMVOL'),
    ('TSLANYCM', 'NYSE', 'CMTSL'),
    ('9988NASCM', 'NASDAQ', 'CMALP'),
    ('AAPLLSPRE', 'LSE', 'PREAPP'),
    ('MSFTSSPRE', 'SSE', 'PREMCR'),
    ('SSNLFHKPRE', 'HKEX', 'PRESAM'),
    ('VOW3LSPRE', 'LSE', 'PREVOL'),
    ('600887BSPRE', 'BSE', 'PREAMZ');

-- (9) Create StockTrade table  
-- ???
CREATE TABLE StockTrade (
    StockTradeId VARCHAR(10),
    BrokerId VARCHAR(10),
    BuyerId VARCHAR(10) NOT NULL,
    SellerId VARCHAR(10) NOT NULL,
    TickerSymbol VARCHAR(20) NOT NULL,
    QuantityOfShares INT,
    PricePerShare DECIMAL(10, 4),
    Year SMALLINT,
    
    CONSTRAINT FK_StockTrade_Broker FOREIGN KEY (BrokerId) REFERENCES TradeBroker(BrokerId) ON DELETE SET NULL,
    CONSTRAINT FK_StockTrade_Buyer FOREIGN KEY (BuyerId) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    CONSTRAINT FK_StockTrade_Seller FOREIGN KEY (SellerId) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    FOREIGN KEY (TickerSymbol) REFERENCES StockSymbol(TickerSymbol) ON DELETE CASCADE

);
INSERT INTO StockTrade (StockTradeId, BrokerId, BuyerId, SellerId, TickerSymbol, QuantityOfShares, PricePerShare, Year)
VALUES 
    ('STKTRD1', 'TWBR4', 'JITR12', 'APTR8', 'AAPLNYCM', 1000000, 0.015, 2024),
    ('STKTRD2', 'EPBR5', 'RVTR11', 'AMTR9', 'TSLANASPRE', 3890000, 0.0097, 2024),
    ('STKTRD3', 'PFBR6', 'AJTR4', 'CVTR10', 'MSFTBSCM', 3006000, 0.00103, 2024),
    ('STKTRD4', 'STBR1', 'JSTR1', 'HLTR13', '600887SSCM', 1023000, 0.011, 2024),
    ('STKTRD5', 'JIBR2', 'JDTR2', 'HSTR14', '9988HKPRE', 3600200, 0.0086, 2024),
    ('STKTRD6', 'ABBR3', 'MLTR3', 'DWTR5', 'SSNLFTSCM', 1208900, 0.007, 2024),
    ('STKTRD7', 'KLBR7', 'LBTR7', 'ETTR6', 'TSLANASPRE', 4000000, 0.0067, 2024);

-- (10) Create StocksInMarket table
CREATE TABLE StocksInMarket (
    TickerSymbol VARCHAR(10) NOT NULL,
    StockQuantity INT,
    BidPrice FLOAT,
    AskPrice FLOAT,
    MarketPrice FLOAT NOT NULL,
    NumberOfPotentialBuys INT,
    Year SMALLINT ,
    PRIMARY KEY(TickerSymbol,Year),
    
    CONSTRAINT FK_StocksInMarket_StockSymbol FOREIGN KEY (TickerSymbol) REFERENCES StockSymbol(TickerSymbol) ON DELETE CASCADE
    
    );
INSERT INTO StocksInMarket (TickerSymbol, StockQuantity, BidPrice, AskPrice, MarketPrice, NumberOfPotentialBuys, Year)
VALUES 
    ('AAPLNYCM', 60000000, 0.015, 0.01, 0.015, 3000000, 2024),
    ('TSLANASPRE', 1500000, 0.0097, 0.0067, 0.0097, 1800000, 2024),
    ('MSFTBSCM', 40000000, 0.00103, 0.001, 0.00103, 1200000, 2024),
    ('600887SSCM', 50000000, 0.011, 0.015, 0.019, 1000000, 2024),
    ('9988HKPRE', 5013000, 0.0086, 0.0089, 0.0092, 1500000, 2024),
    ('SSNLFTSCM', 30000000, 0.0073, 0.007, 0.0073, 1320000, 2024),
    ('VOW3BSCM', 57000000, 0.015, 0.012, 0.015, 2450000, 2024);

-- (11) Create Bonds table
CREATE TABLE Bonds (
    OwnerId VARCHAR(10) NOT NULL,
    AnnualInterestRate FLOAT,
    BondAmount INT,
    CompanyID VARCHAR(10),
    DurationYears INT,
    Year SMALLINT,
    PRIMARY KEY(OwnerId,CompanyID,DurationYears,Year),

    CONSTRAINT FK_Bonds_Owner FOREIGN KEY (OwnerId) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    CONSTRAINT FK_Bonds_Company FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID) ON DELETE CASCADE
);
INSERT INTO Bonds (OwnerId, AnnualInterestRate, BondAmount, CompanyID, DurationYears, Year)
VALUES 
    ('DWTR5', 0.12, 6000000, 'APPL01', 8, 2024),
    ('HLTR13', 0.14, 14400000, 'TSL02', 10, 2024),
    ('DWTR5', 0.1065, 4500000, 'APPL01', 6, 2024),
    ('ETTR6', 0.115, 7000000, 'AMZ04', 6, 2024),
    ('LBTR7', 0.108, 4000000, 'ALP05', 7, 2024),
    ('APTR8', 0.127, 4500000, 'SAM06', 8, 2024),
    ('ETTR6', 0.11, 7200000, 'VOLO7', 7, 2024);

-- (12) Create CompanyPortfolio table
CREATE TABLE CompanyPortfolio (
    CompanyID VARCHAR(10) ,
    Liabilities FLOAT,
    CommonEquity FLOAT,
    PreferredEquity FLOAT,
    RetainedEarnings FLOAT,
    NetIncome FLOAT,
    Year SMALLINT,
    PRIMARY KEY(CompanyID,YEAR),
    CONSTRAINT FK_CompanyPortfolio_Company FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);
INSERT INTO CompanyPortfolio (CompanyID, Liabilities, CommonEquity, PreferredEquity, RetainedEarnings, NetIncome, Year)
VALUES 
    ('APPL01', 25535500, 1400000, 109620, 540000000, 540158802.7, 2024),
    ('TSL02', 52380000, 6600000, 82678, 430000000, 430666109.1, 2024),
    ('MCR03', 40000000, 140000, 134100, 350000000, 350043000.9, 2024),
    ('AMZ04', 18555000, 2370000, 23380, 740000000, 740247298.2, 2024),
    ('ALP05', 9888000, 370000, 169189, 140000000, 140064967.7, 2024),
    ('SAM06', 13977000, 896000, 123900, 360000000, 360113459.7, 2024),
    ('VOLO7', 21389000, 1620000, 217100, 127000000, 127194579.1, 2024);

-- (15) Create ForexInMarket table
CREATE TABLE ForexInMarket (
    Currency_Pair VARCHAR(10),
    ForexRate DECIMAL(10, 4),
    NumberOfUnits INT,
    Year INT,
    CurrencyID VARCHAR(10) PRIMARY KEY
);
INSERT INTO ForexInMarket (Currency_Pair, ForexRate, NumberOfUnits, Year, CurrencyID)
VALUES
    ('EUR/USD', 1.0732, 10000, 2024, '24EUR/USD'),
    ('USD/JPY', 151.75, 5000, 2024, '24USD/JPY'),
    ('GBP/USD', 1.255, 7500, 2024, '24GBP/USD'),
    ('USD/CHF', 0.9082, 8500, 2024, '24USD/CHF'),
    ('USD/CAD', 1.357, 12000, 2024, '24USD/CAD'),
    ('AUD/USD', 0.6493, 20000, 2024, '24AUD/USD'),
    ('NZD/USD', 0.5947, 15000, 2024, '24NZD/USD');

-- (14) Create ForexTrade table
CREATE TABLE ForexTrade (
    ForexTradeId VARCHAR(10) PRIMARY KEY NOT NULL,
    BuyerId VARCHAR(10),
    SellerId VARCHAR(10),
    Number_Of_Units INT,
    Currency_Id VARCHAR(20),
    CONSTRAINT FK_ForexTrade_Buyer FOREIGN KEY (BuyerId) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    CONSTRAINT FK_ForexTrade_ForexInMarket FOREIGN KEY (Currency_Id) REFERENCES ForexInMarket(CurrencyID) ON DELETE CASCADE,
    CONSTRAINT FK_ForexTrade_Seller FOREIGN KEY (SellerId) REFERENCES Trader(TraderId) ON DELETE CASCADE
);
INSERT INTO ForexTrade (ForexTradeId, BuyerId, SellerId, Number_Of_Units, Currency_Id)
VALUES 
    ('FTTD1', 'ETTR6', 'APTR8', 100, '24EUR/USD'),
    ('FTTD2', 'JITR12', 'AMTR9', 200, '24USD/JPY'),
    ('FTTD3', 'MLTR3', 'HSTR14', 100, '24EUR/USD'),
    ('FTTD4', 'AJTR4', 'RVTR11', 150, '24USD/CHF'),
    ('FTTD5', 'DWTR5', 'JITR12', 300, '24NZD/USD'),
    ('FTTD6', 'ETTR6', 'APTR8', 450, '24AUD/USD'),
    ('FTTD7', 'MLTR3', 'HSTR14', 500, '24NZD/USD');

-- (16) Create BondMarket table
CREATE TABLE BondMarket (
    BuyerID VARCHAR(10) ,
    TraderID VARCHAR(10),
    CompanyID VARCHAR(10),
    BondAmount INT,
    Year SMALLINT,
    PRIMARY KEY(BuyerID,TraderID,CompanyID,BondAmount,Year),

    CONSTRAINT FK_BondMarket_Buyer FOREIGN KEY (BuyerID) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    CONSTRAINT FK_BondMarket_Company FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID) ON DELETE CASCADE,
    CONSTRAINT FK_BondMarket_Trader FOREIGN KEY (TraderID) REFERENCES Trader(TraderId) ON DELETE CASCADE
);
INSERT INTO BondMarket (BuyerID, TraderID, CompanyID, BondAmount, Year)
VALUES 
    ('APTR8', 'DWTR5', 'APPL01', 4000000, 2024),
    ('AMTR9', 'HLTR13', 'TSL02', 9000000, 2024),
    ('CVTR10', 'DWTR5', 'APPL01', 3500000, 2024),
    ('RVTR11', 'ETTR6', 'AMZ04', 5000000, 2024),
    ('JSTR1', 'LBTR7', 'ALP05', 2000000, 2024),
    ('HSTR14', 'APTR8', 'SAM06', 3000000, 2024),
    ('JSTR1', 'ETTR6', 'VOLO7', 6500000, 2024);

-- (17) Create ShareHolders table

CREATE TABLE Share_Holders (
    TraderId VARCHAR(10),
    Quantity INT,
    Share_Id VARCHAR(10),
    Equity DECIMAL(10, 2),
    Year INT,
    PRIMARY KEY(TraderId,Share_Id,Year),
    CONSTRAINT FK_ShareHolders_Trade FOREIGN KEY (TraderId) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    CONSTRAINT FK_ShareHolders_Share FOREIGN KEY (Share_Id) REFERENCES Share(ShareId) ON DELETE CASCADE
);
INSERT INTO Share_Holders (TraderId, Quantity, Share_Id, Equity, Year)
VALUES
    ('APTR8', 1866667, 'CMAPP', 28000.00, 2024),
    ('AMTR9', 4920928, 'PRETSL', 47733.00, 2024),
    ('CVTR10', 1183845, 'CMMCR', 1219.36, 2024),
    ('HLTR13', 1011364, 'CMAMZ', 11125.00, 2024),
    ('HSTR14', 3018805, 'PREALP', 25961.72, 2024),
    ('DWTR5', 2092460, 'CMSAM', 14647.22, 2024),
    ('ETTR6', 3880598, 'PRETSL', 26000.00, 2024),
    ('JITR12', 1666667, 'CMAPP', 25000.00, 2024),
    ('RVTR11', 3890000, 'PRETSL', 37733.00, 2024),
    ('AJTR4', 5918622, 'CMMCR', 6096.18, 2024),
    ('JSTR1', 1023000, 'CMAMZ', 11253.00, 2024),
    ('JDTR2', 3600200, 'PREALP', 30961.72, 2024),
    ('MLTR3', 1494615, 'CMSAM', 10462.30, 2024),
    ('LBTR7', 4000000, 'PRETSL', 26800.00, 2024);


-- (18) Create DerivativesInMarket table
CREATE TABLE DerivativesInMarket (
    DerivativeId VARCHAR(10) PRIMARY KEY,
    DerivativeSeller VARCHAR(20),
    InitialBuyer VARCHAR(20),
    TypeOfAsset VARCHAR(20),
    DerivativeTradedPrice DECIMAL(10, 2),
    Year INT,
    ExpiryDate DATE,
    InitiatedDate DATE,
    CurrentAssetPrice DECIMAL(10, 2),
    ContractAssetPrice DECIMAL(10, 2),
    Premium DECIMAL(10, 2),
    DerivativeType VARCHAR(20),

     -- CONSTRAINT FK_DerivativesInMarket_TraderSeller FOREIGN KEY (DerivativeSeller) REFERENCES Trader(TraderId) ON DELETE CASCADE,
     CONSTRAINT FK_DerivativesInMarket_TrederInitialBuyer FOREIGN KEY (InitialBuyer) REFERENCES Trader(TraderId) ON DELETE SET NULL

);
INSERT INTO DerivativesInMarket (DerivativeId, DerivativeSeller, InitialBuyer, TypeOfAsset, DerivativeTradedPrice, Year, ExpiryDate, InitiatedDate, CurrentAssetPrice, ContractAssetPrice, Premium, DerivativeType) VALUES
    ('ISIN01', 'CVTR10', 'JSTR1', 'Commodities', 100, 2024, '2032-03-08', '2024-03-08', 80000, 100000, 50, 'put option'),
    ('ISIN02', 'RVTR11', 'JDTR2', 'Commodities', 50, 2024, '2030-03-09', '2024-03-09', 48000, 46000, 28, 'call'),
    ('ISIN03', 'JITR12', 'MLTR3', 'Commodities', 200, 2024, '2028-03-10', '2024-03-10', 123000, 120000, 130, 'call'),
    ('ISIN04', 'HLTR13', 'AJTR4', 'currencies', 170, 2024, '2027-12-11', '2024-12-11', 85000, 105000, 90, 'put option'),
    ('ISIN05', 'HSTR14', 'DWTR5', 'currencies', 200, 2024, '2030-05-12', '2024-05-12', 109000, 130000, 110, 'put option'),
    ('ISIN06', 'APPL01', 'AJTR4', 'stock', 1400, 2024, '2026-03-13', '2024-03-13', 3450000, 3200000, 750, 'futures'),
    ('ISIN07', 'TSL02', 'DWTR5', 'stock', 1200, 2024, '2029-09-14', '2024-09-14', 3210000, 3000000, 700, 'call'),
    ('ISIN08', 'MCR03', 'ETTR6', 'stock', 800, 2024, '2028-10-15', '2024-10-15', 3800000, 2800000, 400, 'futures'),
    ('ISIN09', 'AMZ04', 'LBTR7', 'stock', 700, 2024, '2030-03-16', '2024-03-16', 2300000, 2000000, 400, 'futures'),
    ('ISIN10', 'APPL01', 'JITR12', 'stock', 900, 2024, '2029-03-17', '2024-03-17', 3320500, 3120000, 500, 'futures'),
    ('ISIN11', 'TSL02', 'HLTR13', 'stock', 700, 2024, '2025-03-18', '2024-03-18', 2840000, 2600000, 360, 'futures');


-- (20) Create Derivative Trade table
CREATE TABLE DerivativeTrade (
    DerivativeTradeID VARCHAR(10),
    DerivativeID VARCHAR(10),
    BuyerID VARCHAR(10),
    year INT,
    BuyerSaving INT,
    InitialBuyerEarning INT,
    SellerEarning INT,
    PRIMARY KEY(DerivativeTradeID,DerivativeID,BuyerID,year),
    CONSTRAINT FK_DerivativeTrade_Trader FOREIGN KEY (DerivativeID) REFERENCES DerivativesInMarket(DerivativeId) ON DELETE CASCADE,
    CONSTRAINT FK_DerivativeTrade_BuyerTrader FOREIGN KEY (BuyerID) REFERENCES Trader(TraderId) ON DELETE CASCADE
);

INSERT INTO DerivativeTrade (DerivativeTradeID, DerivativeID, BuyerID, year, BuyerSaving, InitialBuyerEarning, SellerEarning)
VALUES
    ('DTD1', 'ISIN04', 'JSTR1', 2024, -20170, 20080, 0),
    ('DTD2', 'ISIN05', 'JDTR2', 2024, -21200, 21090, -1972),
    ('DTD3', 'ISIN06', 'MLTR3', 2024, 248600, 650, -2870),
    ('DTD4', 'ISIN07', 'CVTR10', 2024, 208800, 500, 20090),
    ('DTD5', 'ISIN08', 'RVTR11', 2024, 999200, 400, 21110),
    ('DTD6', 'ISIN09', 'JSTR1', 2024, 299300, 300, -249250),
    ('DTD7', 'ISIN10', 'RVTR11', 2024, 199600, 400, -209300);




-- (19) Create TraderPortfolio table
CREATE TABLE TraderPortfolio (
    TraderID VARCHAR(10),
    BondInterest float(24),
    DerivativeEarning float(24),
    ForexEarning float(24),
    CapitalGain float(24),
    NetIncome float(24),
    DividendEarning float(24),
    BondValues float(24),
    Year INT,
    PRIMARY KEY(TraderID,YEAR),
    CONSTRAINT FK_TraderPortfolio_TraderID FOREIGN KEY (TraderID) REFERENCES Trader(TraderId) ON DELETE CASCADE


);
INSERT INTO TraderPortfolio (TraderID, BondInterest, DerivativeEarning, ForexEarning, CapitalGain, NetIncome, DividendEarning, BondValues, Year) VALUES
    ('APTR8', 1051500, 320, 374.935, 5000, 1059061.602, 1866.667, 8500000, 2024),
    ('AMTR9', 1260000, 1080, 1.317957166, 11670, 1280348.142, 7596.824332, 9000000, 2024),
    ('CVTR10', 372750, 860, 120, 90.18, 373940.9805, 120.8005102, 3500000, 2024),
    ('HLTR13', 2016000, 1400, 60, -4092, 2014922.35, 1554.35041, 14400000, 2024),
    ('HSTR14', 381000, 2300, 404.67, -1080.06, 387600.0479, 4975.43787, 3000000, 2024),
    ('DWTR5', 1199250, 500, 304, 0, 1201455.648, 1401.647847, 10500000, 2024),
    ('ETTR6', 1597000, 400, 248, 0, 1603638.785, 5990.784931, 14200000, 2024);

CREATE DATABASE IF NOT EXISTS Stock_market_Investment_management_system;
USE Stock_market_Investment_management_system;

-- (1) Create StockExchange table (D)
CREATE TABLE StockExchange (
    StockExchangeId VARCHAR(10) PRIMARY KEY NOT NULL,
    CEO VARCHAR(50) NOT NULL,
    ExchangeLocation VARCHAR(50) NOT NULL,
    Headquarters VARCHAR(50)
);
INSERT INTO StockExchanges (StockExchangeID, CEO, ExchangeLocation, Headquarters)
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

-- (4) Create Depository table(D)
CREATE TABLE Depository (
    DepositoryId VARCHAR(10) PRIMARY KEY NOT NULL,
    DepositoryName VARCHAR(50) NOT NULL
);

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
INSERT INTO ShareTable (ShareID, CompanyID, ShareType, Quantity, DividendPerShare, ParValue)
VALUES
('CMAPP', 'APPL01', 'COMMON', 9000000, 0.001, 0.01),
('CMTSL', 'TSL02', 'COMMON', 8500000, 0.003921569, 0.04),
('CMMCR', 'MCR03', 'COMMON', 7000000, 0.000102041, 0.001),
('CMAMZ', 'AMZ04', 'COMMON', 7800000, 0.001536885, 0.015),
('CMALP', 'ALP05', 'COMMON', 9500000, 0.000181818, 0.002),
('CMSAM', 'SAM06', 'COMMON', 7800000, 0.000669856, 0.007),
('CMVOL', 'VOLO7', 'COMMON', 9500000, 0.001111111, 0.012),
('PREAPP', 'APPL01', 'PREFERRED', 890000, 0.000590031, 0.0058),
('PRETSL', 'TSL02', 'PREFERRED', 234000, 0.000717345, 0.0067),
('PREMCR', 'MCR03', 'PREFERRED', 490000, 0.000930714, 0.009),
('PREAMZ', 'AMZ04', 'PREFERRED', 670000, 0.000136852, 0.0014),
('PREALP', 'ALP05', 'PREFERRED', 901000, 0.000780702, 0.0089),
('PRESAM', 'SAM06', 'PREFERRED', 239000, 0.00095511, 0.01),
('PREVOL', 'VOLO7', 'PREFERRED', 670000, 0.001317123, 0.013);


-- (8) Create StockSymbol table
CREATE TABLE StockSymbol (
    -- Created by using share ID and StockExchangeId 
    TickerSymbol VARCHAR(10) PRIMARY KEY NOT NULL,
    StockExchangeId VARCHAR(10) NOT NULL,
    ShareId VARCHAR(10) NOT NULL,
    CONSTRAINT FK_StockSymbol_StockExchange FOREIGN KEY (StockExchangeId) REFERENCES StockExchange(StockExchangeId) ON DELETE CASCADE,
    CONSTRAINT FK_StockSymbol_Share FOREIGN KEY (ShareId) REFERENCES Share(ShareID) ON DELETE CASCADE
);

-- (9) Create StockTrade table
CREATE TABLE StockTrade (
    StockTradeId VARCHAR(10) PRIMARY KEY,
    BrokerId VARCHAR(10),
    BuyerId VARCHAR(10) NOT NULL,
    SellerId VARCHAR(10),
    TickerSymbol VARCHAR(10) NOT NULL,
    QuantityOfShares INT,
    PricePerShare FLOAT NOT NULL,
    DematAccountNumber VARCHAR(20) NOT NULL,
    CONSTRAINT FK_StockTrade_Broker FOREIGN KEY (BrokerId) REFERENCES TradeBroker(BrokerId) ON DELETE SET NULL,
    CONSTRAINT FK_StockTrade_Buyer FOREIGN KEY (BuyerId) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    CONSTRAINT FK_StockTrade_Seller FOREIGN KEY (SellerId) REFERENCES Trader(TraderId) ON DELETE SET NULL,
    FOREIGN KEY (TickerSymbol) REFERENCES StockSymbol(TickerSymbol) ON DELETE CASCADE,
    CONSTRAINT FK_Trade_Account FOREIGN KEY( DematAccountNumber) REFERENCES DematAccount(AccountNo)
);
-- (10) Create StocksInMarket table
CREATE TABLE StocksInMarket (
    TickerSymbol VARCHAR(10) NOT NULL,
    StockTradeID VARCHAR(10),
    StockQuantity INT,
    BidPrice FLOAT,
    AskPrice FLOAT,
    MarketPrice FLOAT NOT NULL,
    NumberOfPotentialBuys INT,
    CONSTRAINT FK_StocksInMarket_StockSymbol FOREIGN KEY (TickerSymbol) REFERENCES StockSymbol(TickerSymbol) ON DELETE CASCADE,
    CONSTRAINT FK_StocksInMarket_StockTrade FOREIGN KEY (StockTradeID) REFERENCES StockTrade(StockTradeID) ON DELETE SET NULL
    );

-- (11) Create Bonds table
CREATE TABLE Bonds (
    OwnerId VARCHAR(10) NOT NULL,
    InterestRate FLOAT,
    PricePerUnitBond FLOAT NOT NULL,
    NumberOfUnits INT,
    CompanyID VARCHAR(10) NOT NULL,
    CONSTRAINT FK_Bonds_Owner FOREIGN KEY (OwnerId) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    CONSTRAINT FK_Bonds_Company FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID) ON DELETE CASCADE
);

-- (12) Create CompanyPortfolio table
CREATE TABLE CompanyPortfolio (
    CompanyID VARCHAR(10) ,
    Liabilities FLOAT,
    CommonEquity FLOAT,
    PreferredEquity FLOAT,
    RetainedEarnings FLOAT,
    NetIncome FLOAT,
    CONSTRAINT FK_CompanyPortfolio_Company FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

-- (13) Create FOREX_CURRENCY table
CREATE TABLE FOREX_CURRENCY(
		Currency_Pair varchar(45) NOT NULL,
        Exchange_Rate float(24)NOT NULL,
        PRIMARY KEY(Currency_Pair)
        
);

-- (14) Create ForexTrade table
CREATE TABLE ForexTrade (
    ForexTradeId VARCHAR(10) PRIMARY KEY NOT NULL,
    BuyerId VARCHAR(10) NOT NULL,
    SellerId VARCHAR(10) NOT NULL,
    NumberOfUnits INT NOT NULL,                                                                              
    Forex_Earning FLOAT,
    CurrencyPair VARCHAR(20),
    CONSTRAINT FK_ForexTrade_Buyer FOREIGN KEY (BuyerId) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    CONSTRAINT FK_ForexTrade_Seller FOREIGN KEY (SellerId) REFERENCES Trader(TraderId) ON DELETE CASCADE,
    CONSTRAINT FK_Tradeed_Currency FOREIGN KEY(Currency_Pair) REFERENCES FOREX_CURRENCY(Currency_Pair) ON DELETE CASCADE
);

-- (15) Create ForexInMarket table
CREATE TABLE ForexInMarket (
  ForexTradeId VARCHAR(255) PRIMARY KEY NOT NULL,
  NumberOfUnits INT NOT NULL,
  NumberOfPotentialTraders INT,
  CurrencyPair VARCHAR(255),
  CONSTRAINT Fk_Currency_Market FOREIGN KEY(CurrencyPair) REFERENCES FOREX_CURRENCY(Currency_Pair)
);

-- (16) Create BondMarket table
CREATE TABLE BondMarket (
    BuyerID VARCHAR(10),
    TraderID VARCHAR(10),
    CompanyID VARCHAR(10),
    NumberOfUnits INT,
    UnitPrice FLOAT,
    CONSTRAINT FK_BondMarket_Buyer FOREIGN KEY (BuyerID) REFERENCES Trader(TraderId),
    CONSTRAINT FK_BondMarket_Company FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID),
    CONSTRAINT FK_BondMarket_Trader FOREIGN KEY (TraderID) REFERENCES Trader(TraderId)
);


-- (17) Create ShareHolders table
CREATE TABLE ShareHolders (
    TraderId VARCHAR(10) NOT NULL,
    CompanyID VARCHAR(10) NOT NULL,
    StockType VARCHAR(50) NOT NULL,
    Dividends FLOAT,
    Equity FLOAT NOT NULL,
    CONSTRAINT FK_ShareHolders_Trade FOREIGN KEY (TraderId) REFERENCES Trader(TraderId),
    CONSTRAINT FK_ShareHolders_Company FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

-- (18) Create DerivativesInMarket table
CREATE TABLE DerivativesInMarket (
    DerivativeId VARCHAR(10) PRIMARY KEY NOT NULL,
    SellerId VARCHAR(10) NOT NULL,
    DerivativeOwnership FLOAT ,
    DerivativeBroker VARCHAR(50),
    TradedPrice FLOAT,
    Earning FLOAT,
    Company_ID varchar(45),
    Owner_ID varchar (45),
    Broker varchar (45) NOT NULL,  
    CONSTRAINT FK_DerivativesInMarket_Seller FOREIGN KEY (SellerId) REFERENCES Trader(TraderId)
);


-- (19) Create TraderPortfolio table
CREATE TABLE TraderPortfolio (
    Trader_ID varchar(45) NOT NULL, 
    Forex_Earning varchar(45),
    Dividend_Earning float(24),
    Derivative_Earning float(24),
    Bond_Values float(24),
    Capital_Gain float(24),
    Net_Income float(24),
    CONSTRAINT FK_Owner_portfolio FOREIGN KEY(Trader_ID)  REFERENCES TRADER (TraderId)
);


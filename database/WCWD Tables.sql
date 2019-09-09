--USE master
--GO

--DROP DATABASE wcwd
--GO

--CREATE DATABASE wcwd
--GO

USE wcwd
GO

BEGIN TRAN

CREATE TABLE Category(
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[ShortDesc] [nvarchar](255) NULL,
	[Description] [ntext] NULL,
	[SubOf] [int] NULL,
	[MetaTitle] [nvarchar](100) NULL,
	[MetaDescription] [nvarchar](255) NULL,
	[MetaKeyWord] [nvarchar](255) NULL,
	[PageMax] [int] NULL,
	[PageType] [int] NULL,
	[MaxColumns] [int] NULL,
	[PageConfig] [nvarchar](50) NULL,
	[ListOrder] [int] NULL,
	[SortDir] [int] NULL,
	[IsActive] [int] DEFAULT 1,
	[SmallImage] [nvarchar](255) NULL,
	[LargeImage] [nvarchar](255) NULL,
	[MetaURL] [nvarchar](100) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
	CONSTRAINT PK_CategoryId PRIMARY KEY ([CategoryId] ASC)
)
GO

CREATE TABLE [Gender](
	[GenderId] [int] IDENTITY(1,1) NOT NULL,
	[Gender] [nvarchar](6) NULL,
	[IsActive] [int] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
	CONSTRAINT PK_GenderId PRIMARY KEY ([GenderId] ASC)
)

CREATE TABLE [Item](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[ItemNumber] [nvarchar](50) NULL,
	[Description] [ntext] NULL,
	[ItemGenderId] [int] NULL,
	[IsNewArrival] [int] NULL,	-- Mark to 0 after 90 days of marking as 1
	[SmallImage] [nvarchar](255) NULL,
	[LargeImage] [nvarchar](255) NULL,
	[ShortDesc] [nvarchar](255) NULL,
	[IsActive] [int] DEFAULT 1,
	[IsFeatured] [int] NULL,	
	[IsOnSale] [int] NULL,	
	[Search] [ntext] NULL,
	[InventoryQty] [int] NULL,
	[AddQty] [int] NULL,
	[ImgResize] [int] NULL,
	[HidePrice] [int] NULL,
	[HideHead] [int] NULL,
	[Weight] [float] NULL,
	[IsDigital] [int] NULL,
	[DigFile] [nvarchar](255) NULL,
	[PageVisits] [int] NULL,
	[PageVisitsON] [int] NULL,
	[IsTaxable] [int] NULL,
	[CustomField1] [nvarchar](50) NULL,
	[CustomField2] [nvarchar](50) NULL,
	[CustomField3] [nvarchar](50) NULL,
	[ImageWrap] [int] NULL,
	[AltPrices] [int] NULL,
	[EnableReviews] [int] NULL,
	[MetaURL] [nvarchar](100) NULL,
	[HideSearch] [int] NULL,
	[QtySold] [int] NULL,
	[OtherXml] [ntext] NULL,
	[TaxCode] [nvarchar](8) NULL,
	[IsFeatureImage] [int] NULL,
	[MinQty] [int] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_ItemId PRIMARY KEY ([ItemId] ASC),
CONSTRAINT FK_Item_ItemGender_Gender FOREIGN KEY([ItemGenderId])
REFERENCES [Gender]([GenderId])
)
GO

CREATE TABLE [CategoryLink](
	[CategoryLinkId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[CategoryId] [int] NULL,
	[IsActive] [int] DEFAULT 1,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_CategoryLinkId PRIMARY KEY([CategoryLinkId] ASC),
CONSTRAINT FK_CategoryLink_CategoryID_Category FOREIGN KEY ([CategoryId])
REFERENCES Category([CategoryId]),
CONSTRAINT FK_CategoryLink_ItemId_Item FOREIGN KEY ([ItemId])
REFERENCES Item([ItemId])
) 
GO

CREATE TABLE [Country](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](50) NULL,
	[CountryShortName] [nvarchar](4) NULL,
	[TaxRate] [float] NULL,
	[IsDefault] [int] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_CountryID PRIMARY KEY([CountryId] ASC)
)
GO

CREATE TABLE [State](
	[StateId] [int] IDENTITY(1,1) NOT NULL,
	[CountryID] [int] NULL,
	[StateName] [nvarchar](50) NULL,
	[Abbr] [nvarchar](4) NULL,
	[TaxRate] [float] NULL,
	[IsDefault] [float] NULL,
	[IsTaxShip] [int] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_StateID PRIMARY KEY ([StateId] ASC),
CONSTRAINT FK_State_CountryID_Country FOREIGN KEY ([CountryID])
REFERENCES Country([CountryID])
)
GO

CREATE TABLE [Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[GenderId] [int] NULL,
	[Company] [nvarchar](50) NULL,
	[Street1] [nvarchar](50) NULL,
	[Street2] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[StateId] [int] NULL,
	[Zip] [nvarchar](50) NULL,
	[CountryId] [int] NULL,
	[Phone] [nvarchar](18) NULL,
	[TempKey] [nvarchar](50) NULL,
	[PriceLevel] [float] NULL,
	[PriceDiscount] [float] NULL,
	[LockOut] [int] NULL,
	[EmailOptIn] [int] NULL,
	[IsTaxExempt] [int] NULL,
	[IsActive] [int] DEFAULT 1,
	[TaxExemptProofId] [nvarchar](50) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_CustomerId PRIMARY KEY([CustomerId] ASC),
CONSTRAINT FK_Customer_CountryId_Country FOREIGN KEY ([CountryId])
REFERENCES Country([CountryId]),
CONSTRAINT FK_Customer_StateId_State FOREIGN KEY ([StateId])
REFERENCES [State]([StateId]),
CONSTRAINT FK_Customer_GenderId_Gender FOREIGN KEY([GenderId])
REFERENCES [Gender]([GenderId])
)
GO

CREATE TABLE [CustomPage](
	[CustomPageId] [int] IDENTITY(1,1) NOT NULL,
	[HeadName] [nvarchar](50) NULL,
	[Description] [ntext] NULL,
	[PageLayout] [nvarchar](50) NULL,
	[MetaTitle] [nvarchar](100) NULL,
	[MetaDesc] [nvarchar](255) NULL,
	[MetaKeyWord] [nvarchar](255) NULL,
	[MetaURL] [nvarchar](100) NULL,
	[IsActive] [int] DEFAULT 1,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_CustomPageId PRIMARY KEY(	[CustomPageId] ASC)
)
GO

CREATE TABLE [Discount](
	[DiscountId] [int] IDENTITY(1,1) NOT NULL,
	[DiscountName] [nvarchar](50) NULL,
	[DiscountCode] [nvarchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[MaxDiscAmt] [float] NULL,
	[DiscPercent] [float] NULL,
	[OrderMin] [float] NULL,
	[MaxUseEn] [float] NULL,
	[MaxUse] [float] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_DiscountId PRIMARY KEY([DiscountId] ASC)
)
GO

CREATE TABLE [GiftCertificate](
	[GCId] [int] IDENTITY(1,1) NOT NULL,
	[GCCode] [nvarchar](50) NULL,
	[Amount] [float] NULL,
	[Status] [int] NULL,
	[Method] [int] NULL,
	[OrderId] [int] NULL,
	[BuyDate] [datetime] NULL,
	[RecipientName] [nvarchar](50) NULL,
	[RecipientStreet1] [nvarchar](50) NULL,
	[RecipientStreet2] [nvarchar](50) NULL,
	[RecipientCity] [nvarchar](50) NULL,
	[RecipientStateId] [int] NULL,
	[RecipientZip] [nvarchar](50) NULL,
	[RecipientCountryId] [int] NULL,
	[RecipientPhone] [nvarchar](50) NULL,
	[RecipientEmail] [nvarchar](50) NULL,
	[SentFrom] [nvarchar](50) NULL,
	[SentTo] [nvarchar](50) NULL,
	[Message] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_GCId PRIMARY KEY ([GCId] ASC),
CONSTRAINT FK_GiftCertificate_CountryId_Country FOREIGN KEY ([RecipientCountryId])
REFERENCES Country([CountryId]),
CONSTRAINT FK_GiftCertificate_StateId_State FOREIGN KEY ([RecipientStateId])
REFERENCES [State]([StateId])
)
GO

CREATE TABLE [GiftOpt](
	[GiftOptId] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [money] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
	CONSTRAINT PK_GiftOptId PRIMARY KEY([GiftOptId] ASC)
)
GO

CREATE TABLE [ItemImage](
	[ItemImageId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[Name] [nvarchar](255) NULL,
	[ListOrder] [int] NULL,
	[SmallImage] [nvarchar](255) NULL,
	[LargeImage] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_ItemImageId PRIMARY KEY (	ItemImageId ASC),
CONSTRAINT FK_ItemImage_ItemId_Item FOREIGN KEY ([ItemId])
REFERENCES [Item]([ItemId])
)
GO

CREATE TABLE [ItemLink](
	[ItemLinkId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[RelatedItemId] [int] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_ItemLinkId PRIMARY KEY([ItemLinkId] ASC),
CONSTRAINT FK_ItemLink_ItemId_Item FOREIGN KEY ([ItemId])
REFERENCES [Item]([ItemId]),
CONSTRAINT FK_ItemLink_RelatedItemId_ItemId_Item FOREIGN KEY ([RelatedItemId])
REFERENCES [Item]([ItemId])
)
GO

CREATE TABLE [ItemPrice](
	[ItemPriceId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[RegularPrice] [money] NULL,
	[SalePrice] [money] NULL,
	[IsDiscounted] [int] NULL,
	[DiscountPercent] [float] NULL,
	[FromQty] [float] NULL,
	[ToQty] [float] NULL,
	[Message] [nvarchar](50) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_ItemPriceId PRIMARY KEY([ItemPriceId] ASC),
CONSTRAINT FK_ItemPrice_ItemId_Item FOREIGN KEY ([ItemId])
REFERENCES [Item]([ItemId])
)
GO

CREATE TABLE [MenuTab](
	[MenuTabId] [int] IDENTITY(1,1) NOT NULL,
	[MenuLabel] [nvarchar](50) NULL,
	[HeadName] [nvarchar](50) NULL,
	[Description] [ntext] NULL,
	[PageLayout] [nvarchar](50) NULL,
	[TabType] [int] NULL,
	[CategoryId] [int] NULL,
	[ItemId] [int] NULL,
	[CustomPageId] [int] NULL,
	[TabRow] [int] NULL,
	[TabPosition] [int] NULL,
	[MetaTitle] [nvarchar](100) NULL,
	[MetaDesc] [nvarchar](255) NULL,
	[MetaKeyWord] [nvarchar](255) NULL,
	[LinkText] [nvarchar](50) NULL,
	[MenuText] [nvarchar](50) NULL,
	[ImageURL] [nvarchar](255) NULL,
	[ImageEn] [nvarchar](255) NULL,
	[OtherURL] [nvarchar](255) NULL,
	[LinkLocation] [nvarchar](50) NULL,
	[MenuColumns] [int] NULL,
	[MenuColumnWidth] [float] NULL,
	[MenuTabLeft] [int] NULL,
	[IsActive] [int] DEFAULT 1,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_MenuTabId PRIMARY KEY([MenuTabId] ASC),
CONSTRAINT FK_MenuTab_ItemId_Item FOREIGN KEY ([ItemId])
REFERENCES [Item]([ItemId]),
CONSTRAINT FK_MenuTab_CategoryID_Category FOREIGN KEY ([CategoryId])
REFERENCES Category([CategoryId]),
CONSTRAINT FK_MenuTab_CustomPageId_CustomPage FOREIGN KEY ([CustomPageId])
REFERENCES [CustomPage]([CustomPageId])
)
GO

CREATE TABLE [ItemOptionGroupType](	--Colour, Size, Embroidary etc..
	[ItemOptionGroupTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[IsActive] [int] DEFAULT 1,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
	CONSTRAINT PK_OptionGroupTypeId PRIMARY KEY ([ItemOptionGroupTypeId] ASC)
)
GO

CREATE TABLE [ItemOptionType](	--Droprdown, checkbox, radiobutton etc..
	[ItemOptionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[IsActive] [int] DEFAULT 1,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
	CONSTRAINT PK_OptionTypeId PRIMARY KEY	([ItemOptionTypeId] ASC	)
)
GO

CREATE TABLE [ItemOptionGroup]( -- Create group for Adding multiple colours, sizes for an Item
	[ItemOptionGroupId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[ItemOptionGroupTypeId] [int] NULL,
	[ItemOptionTypeId] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[ListOrder] [float] NULL,
	[IsRequired] [float] NULL,
	[FloatLeft] [float] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
	CONSTRAINT PK_OptionGroupId PRIMARY KEY ([ItemOptionGroupId] ASC),
	CONSTRAINT FK_ItemOptGrp_ItemId_Item FOREIGN KEY ([ItemId])
	REFERENCES [Item]([ItemId]),
	CONSTRAINT FK_ItemOptGrp_ItemOptGrpTypeId_ItemOptGrpType FOREIGN KEY ([ItemOptionGroupTypeId])
	REFERENCES [ItemOptionGroupType]([ItemOptionGroupTypeId]),
	CONSTRAINT FK_ItemOptGrp_ItemOptTypeId_ItemOptType FOREIGN KEY ([ItemOptionTypeId])
	REFERENCES [ItemOptionType]([ItemOptionTypeId])
) 
GO

CREATE TABLE [ItemOptionAdjustType]( -- ADD, SUBSTRACT, USE ITEM VALUE
	[AdjustTypeId] [int] IDENTITY(1,1) NOT NULL,
	[AdjustmentType] [int] NULL,
	[IsActive] [int] DEFAULT 1,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
	CONSTRAINT PK_PriceAdjustTypeId PRIMARY KEY ([AdjustTypeId] ASC),
)
GO

CREATE TABLE [ItemOption]( -- add options to the gropup like sizes: L, XL, XXL, Colour: Black, Blue etc.
	[ItemOptionId] [int] IDENTITY(1,1) NOT NULL,	
	[ItemOptionGroupId] [int] NULL,
	[IsDefault] [int] NULL,
	[OptionName] [nvarchar](50) NULL,
	[PriceAdjustTypeId] [int] NULL,
	[AdjustAmount] [money] NULL,
	[WeightAdjustTypeId] [int] NULL,
	[AdjustWeight] [float] NULL,
	[MinAddToCartQty] [int] NULL, -- Display actual inventory Qty in UI
	[TextMaxSize] [float] NULL,
	[TextMinSize] [float] NULL,
	[HideToggle] [int] NULL,
	[ListOrder] [int] NULL,
	[TrackInventory] [int] NULL,	--0 - NO, 1 - Yes
	[SmallImage] [nvarchar](255) NULL,	-- Show images related to this item in dropdown. Save the one selected from dropdown
	[LargeImage] [nvarchar](255) NULL,
	[Uploaden] [float] NULL,
	[IsActive] [int] DEFAULT 1,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_ItemOptionId PRIMARY KEY ([ItemOptionId] ASC),
CONSTRAINT FK_ItemOption_ItemOptionGroupId_ItemOptionGroup FOREIGN KEY ([ItemOptionGroupId])
REFERENCES [ItemOptionGroup]([ItemOptionGroupId]),
CONSTRAINT FK_ItemOption_PriceAdjustTypeId_ItemOptionAdjustType FOREIGN KEY ([PriceAdjustTypeId])
REFERENCES [ItemOptionAdjustType]([AdjustTypeId]),
CONSTRAINT FK_ItemOption_WeightAdjustTypeId_ItemOptionAdjustType FOREIGN KEY ([WeightAdjustTypeId])
REFERENCES [ItemOptionAdjustType]([AdjustTypeId])
)
GO

CREATE TABLE OrderStatus(
	[OrderStatusId] [int] IDENTITY(1,1) NOT NULL,
	[OrderStatus] [nvarchar](15) NULL,
	[IsActive] [int] DEFAULT 1,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
	CONSTRAINT PK_OrderStatusId PRIMARY KEY ([OrderStatusId] ASC)
)
GO

CREATE TABLE [Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CartId] [nvarchar](50) NULL,
	[ShipName] [nvarchar](50) NULL,
	[ShipCompany] [nvarchar](50) NULL,
	[ShipStreet1] [nvarchar](50) NULL,
	[ShipStreet2] [nvarchar](50) NULL,
	[ShipCity] [nvarchar](50) NULL,
	[ShipStateId] [int] NULL,
	[ShipcountryId] [int] NULL,
	[ShipZip] [nvarchar](50) NULL,
	[BillEmail] [nvarchar](50) NULL,
	[BillName] [nvarchar](50) NULL,
	[BillCompany] [nvarchar](50) NULL,
	[BillStreet1] [nvarchar](50) NULL,
	[BillStreet2] [nvarchar](50) NULL,
	[BillCity] [nvarchar](50) NULL,
	[BillStateId] [int] NULL,
	[BillZip] [nvarchar](50) NULL,
	[BillCountryId] [int] NULL,
	[BillPhone] [nvarchar](50) NULL,
	[CustomerId] [int] NULL,
	[OrderDateTime] [datetime] NULL,
	[OrderStatusId] [int] NULL,
	[Notes] [ntext] NULL,	
	[AffilLink] [nvarchar](50) NULL,
	[Downen] [float] NULL,
	[ShipResdel] [float] NULL,	
	[Tracking] [nvarchar](100) NULL,	
	[Notes2] [ntext] NULL,	
	[Notes3] [nvarchar](255) NULL,
	[Notes4] [nvarchar](255) NULL,
	[Notes5] [nvarchar](255) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_OrderId PRIMARY KEY (	[OrderId] ASC),
CONSTRAINT FK_Order_ShipCountryId_Country FOREIGN KEY ([ShipcountryId])
REFERENCES Country([CountryId]),
CONSTRAINT FK_Order_ShipStateId_State FOREIGN KEY ([ShipStateId])
REFERENCES [State]([StateId]),
CONSTRAINT FK_Order_BillCountryId_Country FOREIGN KEY ([BillcountryId])
REFERENCES Country([CountryId]),
CONSTRAINT FK_Order_BillStateId_State FOREIGN KEY ([BillStateId])
REFERENCES [State]([StateId]),
CONSTRAINT FK_Order_OrderStatusId_OrderStatus FOREIGN KEY ([OrderStatusId])
REFERENCES [OrderStatus]([OrderStatusId]),
CONSTRAINT FK_Order_CustomerId_Customer FOREIGN KEY ([CustomerId])
REFERENCES [Customer]([CustomerId])
)
GO

CREATE TABLE [OrderDetail](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[ItemId] [int] NULL,
	[Qty] [int] NULL,
	[SizeOptionId] [int] NULL,
	[ColourOptionId] [int] NULL,
	[Weight] [float] NULL,
	[SubOf] [int] NULL,
	[AffilLink] [nvarchar](50) NULL,
	[IsDigital] [int] NULL,
	[DigKey] [nvarchar](255) NULL,
	[IP] [nvarchar](50) NULL,
	[Downloads] [float] NULL,
	[DownloadDate] [datetime] NULL,
	[DownloadTime] [datetime] NULL,
	[DownloadIP] [nvarchar](25) NULL,
	[Expires] [datetime] NULL,
	[Downloaded] [float] NULL,
	[OptionText] [nvarchar](255) NULL,
	[IsTaxable] [int] NULL,
	[GiftId] [int] NULL,
	[UploadId] [nvarchar](50) NULL,
	[OptType] [int] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_OrderDetailId PRIMARY KEY([OrderDetailId] ASC),
CONSTRAINT FK_OrderDetail_SizeOptionId_ItemOption FOREIGN KEY ([SizeOptionId])
	REFERENCES [ItemOption]([ItemOptionId]),
CONSTRAINT FK_OrderDetail_ColourOptionId_ItemOption FOREIGN KEY ([ColourOptionId])
	REFERENCES [ItemOption]([ItemOptionId])
)
GO

CREATE TABLE [CreditCardType]( -- Debit, Visa, Master, AmericanExpress etc..
	[CCTypeId] [int] IDENTITY(1,1) NOT NULL,
	[CCType] [nvarchar](50) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_CreditCardTypeId PRIMARY KEY CLUSTERED ([CCTypeId] ASC)
)
GO

CREATE TABLE [Payment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[CCardNo] [nvarchar](25) NULL,
	[CCardNo_Des] [nvarchar](100) NULL,
	[CCTypeId] [int] NULL,
	[CCExpiryMonth] [nvarchar](4) NULL,
	[CCExpiryYear] [nvarchar](4) NULL,
	[CarrierName] [nvarchar](50) NULL,
	[CarrierRate] [money] NULL,
	[RateMethod] [nvarchar](50) NULL,
	[SalesTax] [float] NULL,
	[CCCode] [nvarchar](5) NULL,
	[CCNoc] [nvarchar](50) NULL,
	[CCApproval] [nvarchar](50) NULL,
	[CCTrxId] [nvarchar](50) NULL,
	[DiscountCode] [nvarchar](50) NULL,
	[DiscountAmount] [float] NULL,
	[DiscountPercent] [float] NULL,
	[TaxShip] [nvarchar](2) NULL,
	[GiftCode] [nvarchar](50) NULL,
	[GiftAmount] [money] NULL,
	[IPAddress] [nvarchar](50) NULL,
	[TrxCount] [float] NULL,
	[SalesTaxAmount] [float] NULL,
	[TaxStatus] [float] NULL,
	[Status] [nvarchar](50) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
	CONSTRAINT PK_PaymentId PRIMARY KEY	([PaymentId] ASC),
	CONSTRAINT FK_Payment_CCTypeId_CreditCardType FOREIGN KEY ([CCTypeId])
	REFERENCES [CreditCardType]([CCTypeId])
)
GO

CREATE TABLE [CommonData](
	[CommonDataId] [int] IDENTITY(1,1) NOT NULL,
	[Htmlud1] [ntext] NULL,
	[Htmlud2] [ntext] NULL,
	[Htmlud3] [ntext] NULL,
	[Htmlud4] [ntext] NULL,
	[Htmlud5] [ntext] NULL,
	[Htmlud6] [ntext] NULL,
	[Htmlud7] [ntext] NULL,
	[Htmlud8] [ntext] NULL,
	[Htmlud9] [ntext] NULL,
	[Htmlud10] [ntext] NULL,
	[Slogan] [ntext] NULL,
	[Banner1] [ntext] NULL,
	[Banner2] [ntext] NULL,
	[Banner3] [ntext] NULL,
	[Banner4] [ntext] NULL,
	[MobBanner1] [ntext] NULL,
	[MobBanner2] [ntext] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_CommonDataId PRIMARY KEY ([CommonDataId] ASC)
)
GO

CREATE TABLE [EventLog](
	[EventLogId] [int] IDENTITY(1,1) NOT NULL,
	[EventType] [nvarchar](225) NULL,
	[StackTrace] [nvarchar](225) NULL,
	[CustomerId] [int] NULL,
	[IPAddress] [nvarchar](50) NULL,
	[EventDate] [datetime] NULL,
	[EventTime] [datetime] NULL,
	[RecId] [float] NULL,
	[Note] [nvarchar](50) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_EventlogId PRIMARY KEY([EventLogId] ASC)
)

CREATE TABLE [Setup](
	[SetupId] [int] IDENTITY(1,1) NOT NULL,
	[NextOrder] [int] NULL,
	[CacheEnabled] [int] NULL,
	[SetupXml] [ntext] NULL,
	[LangXml] [ntext] NULL,
	[OtherXml] [ntext] NULL,
	[EncryptedXml] [ntext] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_SetupId PRIMARY KEY ([SetupId] ASC)
)
GO

CREATE TABLE [Review](
	[ReviewId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[Status] [int] NULL,
	[CustomerId] [int] NULL,
	[Rating] [float] NULL,
	[Anonymous] [float] NULL,
	[Title] [nvarchar](50) NULL,
	[Comments] [ntext] NULL,
	[ReviewDate] [datetime] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_ReviewId PRIMARY KEY ([ReviewId] ASC),
CONSTRAINT FK_Review_ItemID_Item FOREIGN KEY ([ItemId])
REFERENCES [Item]([ItemId]),
CONSTRAINT FK_Review_CustomerID_Customer FOREIGN KEY ([CustomerID])
REFERENCES [Customer]([CustomerId])
)
GO

CREATE TABLE [Security](
	[SecurityId] [int] IDENTITY(1,1) NOT NULL,
	[Password] [nvarchar](50) NULL,
	[Password_Des] [nvarchar](255) NULL,
	[Password_Hash] [nvarchar](64) NULL,
	[Password_Salt] [float] NULL,
	[UserName] [nvarchar](50) NULL,
	[SecLevel] [nvarchar](3) NULL,
	[TempKey] [nvarchar](50) NULL,
	[LoginDay] [float] NULL,
	[PwLoCount] [float] NULL,
	[PwLoMin] [nvarchar](25) NULL,
	[PwChgMin] [nvarchar](25) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_SecurityId PRIMARY KEY ([SecurityId] ASC)
)
GO

CREATE TABLE [ShippingCarrier](
	[ShippingCarrierId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[RateMethod] [nvarchar](50) NULL,
	[Rate] [money] NULL,
	[RateMin] [money] NULL,
	[CountryID] [int] NULL,
	[StateId] [int] NULL,
	[RateAddon] [nvarchar](50) NULL,
	[HandlingFee] [money] NULL,
	[UspsService] [nvarchar](50) NULL,
	[UspsSize] [nvarchar](50) NULL,
	[UpsService] [nvarchar](50) NULL,
	[InterService] [nvarchar](50) NULL,
	[Estimate] [nvarchar](2) NULL,
	[Freeen] [nvarchar](2) NULL,
	[FreeLabel] [nvarchar](50) NULL,
	[IsActive] [int] DEFAULT 1,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_ShippingCarrierId PRIMARY KEY ([ShippingCarrierId] ASC),
CONSTRAINT FK_ShippingCarrier_CountryID_Country FOREIGN KEY ([CountryID])
REFERENCES [Country]([CountryID]),
CONSTRAINT FK_ShippingCarrier_StateID_State FOREIGN KEY ([StateID])
REFERENCES [State]([StateID])
) 
GO

CREATE TABLE [ShipRate](
	[ShipRateId] [int] IDENTITY(1,1) NOT NULL,
	[ShippingCarrierId] [int] NULL,
	[FromAmt] [money] NULL,
	[ToAmt] [money] NULL,
	[Rate] [money] NULL,
	[Method] [float] NULL,
	[OrderPercent] [float] NULL,
	[Rate2] [money] NULL,
	[RateType] [float] NULL,
	[FromNum] [float] NULL,
	[ToNum] [float] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_ShipRateId PRIMARY KEY ([ShipRateId] ASC),
CONSTRAINT FK_ShipRate_ShippingCarrierId_ShippingCarrier FOREIGN KEY ([ShippingCarrierId])
REFERENCES ShippingCarrier([ShippingCarrierId])
)
GO


CREATE TABLE [Notification](
	[NotificationId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [ntext] NULL,
	[Emailen] [float] NULL,
	[EmailFrom] [nvarchar](50) NULL,
	[EmailFromName] [nvarchar](50) NULL,
	[EmailSubject] [nvarchar](50) NULL,
	[EmailBody] [ntext] NULL,
	[EmailTo] [ntext] NULL,
	[EmailToName] [nvarchar](50) NULL,
	[Status] [int] NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_NotificationId PRIMARY KEY ([NotificationId] ASC)
)
GO

CREATE TABLE [WishList](
	[WishListId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NULL,
	[ItemId] [int] NULL,
	[Qty] [float] NULL,
	[Price] [money] NULL,
	[OrderId] [int] NULL,
	[CartId] [nvarchar](50) NULL,
	[Weight] [float] NULL,
	[OptionDesc] [nvarchar](255) NULL,
	[SubOf] [int] NULL,
	[ItemOptionId] [int] NULL,
	[AffilLink] [nvarchar](50) NULL,
	[Digital] [nvarchar](3) NULL,
	[DigKey] [nvarchar](255) NULL,
	[IPAddress] [nvarchar](50) NULL,
	[Downloads] [float] NULL,
	[DownloadDate] [datetime] NULL,
	[DownloadTime] [datetime] NULL,
	[DownloadIP] [nvarchar](25) NULL,
	[Expires] [datetime] NULL,
	[Downloaded] [float] NULL,
	[OptionText] [nvarchar](255) NULL,
	[Taxable] [nvarchar](3) NULL,
	[CreatedDateTime] [datetime] DEFAULT GETDATE(),
	[CreatedBy] [int] DEFAULT -1,
	[UpdatedDateTime] [datetime] DEFAULT GETDATE(),
	[UpdatedBy] [int] DEFAULT -1,
CONSTRAINT PK_WishListId PRIMARY KEY ([WishListId] ASC),
CONSTRAINT FK_WishList_CustomerId_Customer FOREIGN KEY ([CustomerId])
REFERENCES Customer([CustomerId]),
CONSTRAINT FK_WishList_ItemId_Item FOREIGN KEY ([ItemId])
REFERENCES [Item]([ItemId]),
CONSTRAINT FK_WishList_OrderId_Order FOREIGN KEY ([OrderId])
REFERENCES [Order]([OrderId]),
CONSTRAINT FK_WishList_ItemOptionId_ItemOption FOREIGN KEY ([ItemOptionId])
REFERENCES [ItemOption]([ItemOptionId])
)
GO

COMMIT TRAN
--ROLLBACK TRAN
--END
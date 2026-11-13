-- MSPro V18: MuOnline database (no accounts, characters, guilds or logs). Target: SQL Server 2014 or newer.
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccountCharacter](
	[Number] [int] IDENTITY(1,1) NOT NULL,
	[Id] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[GameID1] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GameID2] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GameID3] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GameID4] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GameID5] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GameID6] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GameID7] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GameID8] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GameID9] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GameID10] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GameIDC] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[MoveCnt] [tinyint] NULL,
	[ExtClass] [int] NOT NULL,
	[ExtWarehouse] [int] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AutoAddStats](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[State] [tinyint] NOT NULL,
	[STR] [tinyint] NOT NULL,
	[AGI] [tinyint] NOT NULL,
	[VIT] [tinyint] NOT NULL,
	[ENE] [tinyint] NOT NULL,
	[CMD] [tinyint] NOT NULL,
	[Level] [smallint] NOT NULL,
 CONSTRAINT [PK_AutoAddStats] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BattlePass](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[ExpPoints] [int] NOT NULL,
	[CurrentLevel] [tinyint] NOT NULL,
	[HasPremium] [tinyint] NOT NULL,
	[PremiumExpireDate] [int] NOT NULL,
	[LastUpdate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BattlePass_Rewards](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Level] [int] NOT NULL,
	[Track] [tinyint] NOT NULL,
	[ClaimDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Name] ASC,
	[Level] ASC,
	[Track] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](16) COLLATE Latin1_General_CI_AS NULL,
	[Amount] [money] NULL,
	[SentDate] [smalldatetime] NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashShopData](
	[AccountID] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[WCoinC] [int] NULL,
	[WCoinP] [int] NULL,
	[GoblinPoint] [int] NULL,
 CONSTRAINT [PK_TempCashShop] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CashShopInventory](
	[BaseItemCode] [int] IDENTITY(1,1) NOT NULL,
	[MainItemCode] [int] NULL,
	[AccountID] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[InventoryType] [int] NULL,
	[PackageMainIndex] [int] NULL,
	[ProductBaseIndex] [int] NULL,
	[ProductMainIndex] [int] NULL,
	[CoinValue] [float] NULL,
	[ProductType] [int] NULL,
	[GiftName] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GiftText] [varchar](200) COLLATE Latin1_General_CI_AS NULL,
 CONSTRAINT [PK_CashShopInventory] PRIMARY KEY CLUSTERED 
(
	[BaseItemCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashShopPeriodicItem](
	[ItemSerial] [int] NOT NULL,
	[Time] [int] NULL,
 CONSTRAINT [PK_CashShopPeriodicItem] PRIMARY KEY CLUSTERED 
(
	[ItemSerial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Character](
	[AccountID] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[cLevel] [int] NULL,
	[LevelUpPoint] [int] NULL,
	[Class] [tinyint] NULL,
	[Strength] [int] NULL,
	[Dexterity] [int] NULL,
	[Vitality] [int] NULL,
	[Energy] [int] NULL,
	[Leadership] [int] NULL,
	[Inventory] [varbinary](3776) NULL,
	[MagicList] [varbinary](180) NULL,
	[Money] [int] NULL,
	[Life] [real] NULL,
	[MaxLife] [real] NULL,
	[Mana] [real] NULL,
	[MaxMana] [real] NULL,
	[BP] [real] NULL,
	[MaxBP] [real] NULL,
	[Shield] [real] NULL,
	[MaxShield] [real] NULL,
	[MapNumber] [smallint] NULL,
	[MapPosX] [smallint] NULL,
	[MapPosY] [smallint] NULL,
	[MapDir] [tinyint] NULL,
	[PkCount] [int] NULL,
	[PkLevel] [int] NULL,
	[PkTime] [int] NULL,
	[MDate] [smalldatetime] NULL,
	[LDate] [smalldatetime] NULL,
	[CtlCode] [tinyint] NULL,
	[DbVersion] [tinyint] NULL,
	[Quest] [varbinary](50) NULL,
	[ChatLimitTime] [smallint] NULL,
	[FruitPoint] [int] NULL,
	[EffectList] [varbinary](208) NULL,
	[FruitAddPoint] [int] NOT NULL,
	[FruitSubPoint] [int] NOT NULL,
	[ResetCount] [int] NOT NULL,
	[MasterResetCount] [int] NOT NULL,
	[ExtInventory] [int] NOT NULL,
	[Kills] [int] NOT NULL,
	[Deads] [int] NOT NULL,
	[Bloc_Expire] [smalldatetime] NULL,
	[ResetDay] [int] NOT NULL,
	[ResetWek] [int] NOT NULL,
	[ResetMon] [int] NOT NULL,
	[ItemStart] [int] NOT NULL,
	[RuudToken] [int] NOT NULL,
	[LastDivorceDate] [datetime] NULL,
	[LastDivorceStyle] [int] NOT NULL,
	[ResetLimit] [int] NOT NULL,
	[MasterResetLimit] [int] NOT NULL,
	[Flag] [tinyint] NULL,
	[Experience] [int] NOT NULL,
	[NewExperience] [decimal](20, 0) NOT NULL,
	[BanChat] [int] NOT NULL,
	[ElementID] [int] NOT NULL,
	[BonusPoints] [int] NOT NULL,
	[AllowSummonParty] [tinyint] NOT NULL,
	[BlockSummonParty] [tinyint] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientSettings](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[Enable3D] [tinyint] NOT NULL,
	[EnableMiniMap] [tinyint] NOT NULL,
	[EnableTime] [tinyint] NOT NULL,
	[EnableFog] [tinyint] NOT NULL,
	[MonstersHPBar] [tinyint] NOT NULL,
	[PlayersHPBar] [tinyint] NOT NULL,
	[ReduceZenInFloor] [tinyint] NOT NULL,
	[ShowCharName] [tinyint] NOT NULL,
	[EnablePingBar] [tinyint] NOT NULL,
	[AntiLag] [tinyint] NOT NULL,
	[MiniMapX] [float] NOT NULL,
	[MiniMapY] [float] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomAttack](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Active] [smallint] NOT NULL,
	[Skill] [smallint] NULL,
	[Map] [smallint] NULL,
	[PosX] [smallint] NULL,
	[PosY] [smallint] NULL,
	[AutoBuff] [smallint] NULL,
	[OffPvP] [smallint] NULL,
	[AutoReset] [smallint] NULL,
	[AutoAddStr] [int] NULL,
	[AutoAddAgi] [int] NULL,
	[AutoAddVit] [int] NULL,
	[AutoAddEne] [int] NULL,
	[AutoAddCmd] [int] NULL,
 CONSTRAINT [PK_CustomAttack] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomGift](
	[AccountID] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_CustomGift] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomNpcQuest](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Quest] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[MonsterCount] [int] NOT NULL,
 CONSTRAINT [PK_CustomNpcQuest] PRIMARY KEY CLUSTERED 
(
	[Name] ASC,
	[Quest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomQuest](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Quest] [int] NOT NULL,
 CONSTRAINT [PK_CustomQuest] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DailyBonus](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Day0] [tinyint] NOT NULL,
	[Day1] [tinyint] NOT NULL,
	[Day2] [tinyint] NOT NULL,
	[Day3] [tinyint] NOT NULL,
	[Day4] [tinyint] NOT NULL,
	[Day5] [tinyint] NOT NULL,
	[Day6] [tinyint] NOT NULL,
 CONSTRAINT [PK_DailyBonus] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DefaultClassType](
	[Class] [tinyint] NOT NULL,
	[Level] [smallint] NULL,
	[LevelUpPoint] [smallint] NULL,
	[Strength] [smallint] NULL,
	[Dexterity] [smallint] NULL,
	[Vitality] [smallint] NULL,
	[Energy] [smallint] NULL,
	[Leadership] [smallint] NULL,
	[Inventory] [varbinary](3776) NULL,
	[MagicList] [varbinary](180) NULL,
	[Life] [real] NULL,
	[MaxLife] [real] NULL,
	[Mana] [real] NULL,
	[MaxMana] [real] NULL,
	[MapNumber] [smallint] NULL,
	[MapPosX] [smallint] NULL,
	[MapPosY] [smallint] NULL,
	[Quest] [varbinary](50) NULL,
	[DbVersion] [tinyint] NULL,
	[EffectList] [varbinary](208) NULL,
 CONSTRAINT [PK_DefaultClassType] PRIMARY KEY CLUSTERED 
(
	[Class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventLeoTheHelper](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_EventLeoTheHelper] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventSantaClaus](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_EventSantaClaus] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExtWarehouse](
	[AccountID] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Items] [varbinary](3840) NULL,
	[Money] [int] NULL,
	[Number] [int] NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FlagSystem](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Index] [tinyint] NOT NULL,
	[Time] [int] NULL,
 CONSTRAINT [PK_FlagSystem] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FortuneWheel](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Wheel] [int] NULL,
	[Count] [int] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameServerInfo](
	[Number] [int] NOT NULL,
	[ItemCount] [int] NOT NULL,
	[ZenCount] [int] NULL,
	[AceItemCount] [int] NULL,
	[GremoryCount] [int] NOT NULL,
	[ItemMarketCount] [int] NOT NULL
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Gens_Duprian](
	[Rank] [bigint] NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Family] [int] NULL,
	[Contribution] [int] NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Gens_Rank](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Family] [int] NULL,
	[Contribution] [int] NULL,
 CONSTRAINT [PK_Gens_Rank] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Gens_Reward](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Rank] [int] NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Gens_Reward] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Gens_Varnert](
	[Rank] [bigint] NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Family] [int] NULL,
	[Contribution] [int] NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GiftCodes](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[GiftCode] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[UseCount] [int] NULL,
	[ResetTime] [int] NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GremoryCase](
	[ID] [int] NOT NULL,
	[Type] [tinyint] NULL,
	[Name] [varchar](11) COLLATE Latin1_General_CI_AS NULL,
	[ExpireTime] [int] NULL,
	[Item] [varbinary](16) NULL,
	[Origin] [tinyint] NULL,
	[DurationTime] [int] NULL,
 CONSTRAINT [PK_GremoryCase] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Guild](
	[G_Name] [varchar](8) COLLATE Latin1_General_CI_AS NOT NULL,
	[G_Mark] [varbinary](32) NULL,
	[G_Score] [int] NULL,
	[G_Master] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[G_Count] [int] NULL,
	[G_Notice] [varchar](60) COLLATE Latin1_General_CI_AS NULL,
	[Number] [int] IDENTITY(1,1) NOT NULL,
	[G_Type] [int] NOT NULL,
	[G_Rival] [int] NOT NULL,
	[G_Union] [int] NOT NULL,
	[MemberCount] [int] NULL,
 CONSTRAINT [PK_Guild] PRIMARY KEY CLUSTERED 
(
	[G_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GuildMember](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[G_Name] [varchar](8) COLLATE Latin1_General_CI_AS NOT NULL,
	[G_Level] [tinyint] NULL,
	[G_Status] [tinyint] NOT NULL,
 CONSTRAINT [PK_GuildMember] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GuildWarehouseConfig](
	[GuildName] [varchar](9) COLLATE Latin1_General_CI_AS NOT NULL,
	[DefaultCanDeposit] [bit] NOT NULL,
	[DefaultCanWithdraw] [bit] NOT NULL,
	[BattleMasterCanManage] [bit] NOT NULL,
	[AssistantCanManage] [bit] NOT NULL,
 CONSTRAINT [PK_GuildWarehouseConfig] PRIMARY KEY CLUSTERED 
(
	[GuildName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GuildWarehousePermissions](
	[GuildName] [varchar](9) COLLATE Latin1_General_CI_AS NOT NULL,
	[MemberName] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[CanDeposit] [bit] NOT NULL,
	[CanWithdraw] [bit] NOT NULL,
 CONSTRAINT [PK_GuildWarehousePermissions] PRIMARY KEY CLUSTERED 
(
	[GuildName] ASC,
	[MemberName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HelperData](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Data] [binary](256) NULL,
 CONSTRAINT [PK_HelperData] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemLog](
	[SEQ] [int] IDENTITY(1,1) NOT NULL,
	[Acc] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[ItemCode] [varbinary](32) NULL,
	[SN] [int] NULL,
	[iName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[iLvl] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[iSkill] [smallint] NULL,
	[iLuck] [smallint] NULL,
	[iExt] [varchar](500) COLLATE Latin1_General_CI_AS NULL,
	[iSet] [smallint] NULL,
	[i380] [smallint] NULL,
	[iJh] [smallint] NULL,
	[SentDate] [smalldatetime] NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItemMarket](
	[ID] [int] NOT NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Item] [varbinary](16) NULL,
	[Zen] [int] NOT NULL,
	[WC] [int] NOT NULL,
	[WP] [int] NOT NULL,
	[GP] [int] NOT NULL,
	[Ruuds] [int] NOT NULL,
	[Chaos] [int] NOT NULL,
	[Bless] [int] NOT NULL,
	[Soul] [int] NOT NULL,
	[Life] [int] NOT NULL,
	[Creation] [int] NOT NULL,
	[DateTime] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
 CONSTRAINT [PK_ItemMarket] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KillLog](
	[Name1] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Name2] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[KD1] [int] NOT NULL,
	[Class1] [tinyint] NULL,
	[L1] [smallint] NOT NULL,
	[R1] [smallint] NOT NULL,
	[MR1] [smallint] NOT NULL,
	[GName1] [varchar](8) COLLATE Latin1_General_CI_AS NULL,
	[Class2] [tinyint] NULL,
	[KD2] [int] NOT NULL,
	[L2] [smallint] NOT NULL,
	[R2] [smallint] NOT NULL,
	[MR2] [smallint] NOT NULL,
	[GName2] [varchar](8) COLLATE Latin1_General_CI_AS NULL,
	[DateTime] [int] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LockManager](
	[AccountID] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[MoveItems] [tinyint] NOT NULL,
	[PersonalStore] [tinyint] NOT NULL,
	[ShopBuy] [tinyint] NOT NULL,
	[ShopSell] [tinyint] NOT NULL,
	[JewelBank] [tinyint] NOT NULL,
	[StatsChange] [tinyint] NOT NULL,
	[CommandsUse] [tinyint] NOT NULL,
	[GuildChanges] [tinyint] NOT NULL,
	[CharactersDelete] [tinyint] NOT NULL,
 CONSTRAINT [PK_LockSystem] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOG_CREDITOS](
	[id_creditos] [int] IDENTITY(1,1) NOT NULL,
	[login] [nvarchar](10) COLLATE Latin1_General_CI_AS NULL,
	[valor] [int] NOT NULL,
	[data] [smalldatetime] NOT NULL,
	[ip] [char](15) COLLATE Latin1_General_CI_AS NULL,
	[tipo] [smallint] NOT NULL,
 CONSTRAINT [PK_LOG_CREDITOS] PRIMARY KEY CLUSTERED 
(
	[id_creditos] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LuckyCoin](
	[AccountID] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[LuckyCoin] [int] NULL,
 CONSTRAINT [PK_LuckyCoin] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LuckyItem](
	[ItemSerial] [int] NOT NULL,
	[DurabilitySmall] [int] NULL,
 CONSTRAINT [PK_LuckyItem] PRIMARY KEY CLUSTERED 
(
	[ItemSerial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Marry](
	[Name1] [varchar](15) COLLATE Latin1_General_CI_AS NOT NULL,
	[Name2] [varchar](15) COLLATE Latin1_General_CI_AS NOT NULL,
	[MarryDate] [datetime] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MasterSkillTree](
	[Name] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[MasterLevel] [int] NULL,
	[MasterPoint] [int] NULL,
	[MasterExperience] [bigint] NULL,
	[MasterSkill] [varbinary](180) NULL,
 CONSTRAINT [PK_MasterSkillTree] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MEMB_INFO](
	[memb_guid] [int] IDENTITY(1,1) NOT NULL,
	[memb___id] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[memb__pwd] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[memb_name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[sno__numb] [char](18) COLLATE Latin1_General_CI_AS NOT NULL,
	[post_code] [char](6) COLLATE Latin1_General_CI_AS NULL,
	[addr_info] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[addr_deta] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[tel__numb] [varchar](20) COLLATE Latin1_General_CI_AS NULL,
	[phon_numb] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[mail_addr] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[fpas_ques] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[fpas_answ] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[job__code] [char](2) COLLATE Latin1_General_CI_AS NULL,
	[appl_days] [datetime] NULL,
	[modi_days] [datetime] NULL,
	[out__days] [datetime] NULL,
	[true_days] [datetime] NULL,
	[mail_chek] [char](1) COLLATE Latin1_General_CI_AS NULL,
	[bloc_code] [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
	[ctl1_code] [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
	[AccountLevel] [int] NOT NULL,
	[AccountExpireDate] [smalldatetime] NOT NULL,
	[Lock] [int] NOT NULL,
	[Bloc_Expire] [smalldatetime] NULL,
	[GoldenArcherCount] [int] NULL,
	[GiftCount] [int] NOT NULL,
	[memb__pwd_md5] [varbinary](16) NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MEMB_STAT](
	[memb___id] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[ConnectStat] [tinyint] NULL,
	[ServerName] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[IP] [varchar](15) COLLATE Latin1_General_CI_AS NULL,
	[ConnectTM] [smalldatetime] NULL,
	[DisConnectTM] [smalldatetime] NULL,
	[OnlineHours] [int] NULL,
 CONSTRAINT [PK_MEMB_STAT] PRIMARY KEY CLUSTERED 
(
	[memb___id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MK_Server](
	[rei_do_mk] [smallint] NOT NULL,
	[recorde_on] [int] NOT NULL
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MonstersCount](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[MonsterID] [int] NOT NULL,
	[KillCount] [int] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSPro_AchievementMilestones](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Kind] [tinyint] NOT NULL,
	[Category] [int] NOT NULL,
	[Milestone] [int] NOT NULL,
	[Claimed] [datetime] NOT NULL,
 CONSTRAINT [PK_MSPro_AchievementMilestones] PRIMARY KEY CLUSTERED 
(
	[Name] ASC,
	[Kind] ASC,
	[Category] ASC,
	[Milestone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSPro_Achievements](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Achievement] [int] NOT NULL,
	[Tier] [tinyint] NOT NULL,
	[Claimed] [tinyint] NOT NULL,
	[Progress] [bigint] NOT NULL,
	[Updated] [datetime] NOT NULL,
 CONSTRAINT [PK_MSPro_Achievements] PRIMARY KEY CLUSTERED 
(
	[Name] ASC,
	[Achievement] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSPro_AchievementSummary](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Points] [int] NOT NULL,
	[Completed] [int] NOT NULL,
	[Updated] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSPro_AuctionBids](
	[AuctionID] [bigint] NOT NULL,
	[Version] [int] NOT NULL,
	[Account] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Price] [varbinary](max) NOT NULL,
	[Created] [bigint] NOT NULL,
 CONSTRAINT [PK_MSPro_AuctionBids] PRIMARY KEY CLUSTERED 
(
	[AuctionID] ASC,
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSPro_AuctionDeliveries](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[AuctionID] [bigint] NOT NULL,
	[Account] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Kind] [varchar](12) COLLATE Latin1_General_CI_AS NOT NULL,
	[SourceVersion] [int] NOT NULL,
	[Item] [varbinary](16) NULL,
	[Info] [varbinary](max) NULL,
	[Price] [varbinary](max) NOT NULL,
	[Version] [int] NOT NULL,
	[Claimed] [bit] NOT NULL,
	[Created] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSPro_AuctionOperations](
	[ID] [varchar](36) COLLATE Latin1_General_CI_AS NOT NULL,
	[Account] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Result] [varbinary](max) NOT NULL,
	[Created] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSPro_Auctions](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[OwnerAccount] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[OwnerName] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Item] [varbinary](16) NOT NULL,
	[Serial] [bigint] NOT NULL,
	[Info] [varbinary](max) NOT NULL,
	[ItemName] [varchar](64) COLLATE Latin1_General_CI_AS NOT NULL,
	[ItemIndex] [int] NOT NULL,
	[ItemLevel] [int] NOT NULL,
	[BasePrice] [varbinary](max) NOT NULL,
	[Price] [varbinary](max) NOT NULL,
	[BidderAccount] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[BidderName] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[Version] [int] NOT NULL,
	[Ends] [bigint] NOT NULL,
	[State] [varchar](12) COLLATE Latin1_General_CI_AS NOT NULL,
	[Released] [bit] NOT NULL,
	[Created] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSPro_JewelBank](
	[Account] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Item] [int] NOT NULL,
	[Level] [int] NOT NULL,
	[Count] [int] NOT NULL,
 CONSTRAINT [PK_MSPro_JewelBank] PRIMARY KEY CLUSTERED 
(
	[Account] ASC,
	[Item] ASC,
	[Level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSPro_JewelBank_Config](
	[Account] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[AutoSave] [tinyint] NOT NULL,
	[AutoSaveResetTime] [int] NOT NULL,
	[AutoSaveCount] [int] NOT NULL,
 CONSTRAINT [PK_MSPro_JewelBank_Config] PRIMARY KEY CLUSTERED 
(
	[Account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MSPro_LuaStorage](
	[Scope] [tinyint] NOT NULL,
	[Owner] [varchar](32) COLLATE Latin1_General_CI_AS NOT NULL,
	[Module] [varchar](32) COLLATE Latin1_General_CI_AS NOT NULL,
	[Data] [varbinary](max) NULL,
	[Updated] [datetime] NOT NULL,
 CONSTRAINT [PK_MSPro_LuaStorage] PRIMARY KEY CLUSTERED 
(
	[Scope] ASC,
	[Owner] ASC,
	[Module] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MuCastle_DATA](
	[MAP_SVR_GROUP] [int] NOT NULL,
	[SIEGE_START_DATE] [datetime] NOT NULL,
	[SIEGE_END_DATE] [datetime] NOT NULL,
	[SIEGE_GUILDLIST_SETTED] [bit] NOT NULL,
	[SIEGE_ENDED] [bit] NOT NULL,
	[CASTLE_OCCUPY] [bit] NOT NULL,
	[OWNER_GUILD] [varchar](8) COLLATE Latin1_General_CI_AS NOT NULL,
	[MONEY] [money] NOT NULL,
	[TAX_RATE_CHAOS] [int] NOT NULL,
	[TAX_RATE_STORE] [int] NOT NULL,
	[TAX_HUNT_ZONE] [int] NOT NULL,
 CONSTRAINT [PK_MuCastle_DATA] PRIMARY KEY CLUSTERED 
(
	[MAP_SVR_GROUP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MuCastle_MONEY_STATISTICS](
	[MAP_SVR_GROUP] [int] NOT NULL,
	[LOG_DATE] [datetime] NOT NULL,
	[MONEY_CHANGE] [money] NOT NULL
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MuCastle_NPC](
	[MAP_SVR_GROUP] [int] NOT NULL,
	[NPC_NUMBER] [int] NOT NULL,
	[NPC_INDEX] [int] NOT NULL,
	[NPC_DF_LEVEL] [int] NOT NULL,
	[NPC_RG_LEVEL] [int] NOT NULL,
	[NPC_MAXHP] [int] NOT NULL,
	[NPC_HP] [int] NOT NULL,
	[NPC_X] [tinyint] NOT NULL,
	[NPC_Y] [tinyint] NOT NULL,
	[NPC_DIR] [tinyint] NOT NULL,
	[NPC_CREATEDATE] [datetime] NOT NULL
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MuCastle_REG_SIEGE](
	[MAP_SVR_GROUP] [int] NOT NULL,
	[REG_SIEGE_GUILD] [varchar](8) COLLATE Latin1_General_CI_AS NOT NULL,
	[REG_MARKS] [int] NOT NULL,
	[IS_GIVEUP] [tinyint] NOT NULL,
	[SEQ_NUM] [int] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MuCastle_SIEGE_GUILDLIST](
	[MAP_SVR_GROUP] [int] NOT NULL,
	[GUILD_NAME] [varchar](8) COLLATE Latin1_General_CI_AS NOT NULL,
	[GUILD_ID] [int] NOT NULL,
	[GUILD_INVOLVED] [bit] NOT NULL,
	[GUILD_SCORE] [int] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OptionData](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[SkillKey] [binary](20) NULL,
	[GameOption] [tinyint] NULL,
	[Qkey] [tinyint] NULL,
	[Wkey] [tinyint] NULL,
	[Ekey] [tinyint] NULL,
	[ChatWindow] [tinyint] NULL,
	[Rkey] [tinyint] NULL,
	[QWERLevel] [int] NULL,
 CONSTRAINT [PK_OptionData] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuestKillCount](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[QuestIndex] [int] NULL,
	[MonsterClass1] [int] NULL,
	[KillCount1] [int] NULL,
	[MonsterClass2] [int] NULL,
	[KillCount2] [int] NULL,
	[MonsterClass3] [int] NULL,
	[KillCount3] [int] NULL,
	[MonsterClass4] [int] NULL,
	[KillCount4] [int] NULL,
	[MonsterClass5] [int] NULL,
	[KillCount5] [int] NULL,
 CONSTRAINT [PK_QuestKillCount] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuestWorld](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[QuestWorldList] [varbinary](400) NULL,
 CONSTRAINT [PK_QuestWorld] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RankingBloodCastle](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Score] [int] NULL,
	[Score_semanal] [int] NOT NULL,
 CONSTRAINT [PK_RankingBloodCastle] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RankingChaosCastle](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Score] [int] NULL,
	[Score_semanal] [int] NOT NULL,
 CONSTRAINT [PK_RankingChaosCastle] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RankingDevilSquare](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Score] [int] NULL,
	[Score_semanal] [int] NOT NULL,
 CONSTRAINT [PK_RankingDevilSquare] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RankingDuel](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[WinScore] [int] NULL,
	[LoseScore] [int] NULL,
	[WinScore_semanal] [int] NOT NULL,
 CONSTRAINT [PK_RankingDuel] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RankingIllusionTemple](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Score] [int] NULL,
 CONSTRAINT [PK_RankingIllusionTemple] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RankingKingGuild](
	[Name] [varchar](8) COLLATE Latin1_General_CI_AS NOT NULL,
	[Score] [int] NULL,
	[Score_semanal] [int] NULL,
 CONSTRAINT [PK_RankingKingGuild] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RankingKingPlayer](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Score] [int] NULL,
	[Score_semanal] [int] NULL,
 CONSTRAINT [PK_RankingKingPlayer] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RankingTvT](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Kills] [int] NOT NULL,
	[Deads] [int] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResetSystem](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Strength] [int] NULL,
	[Dexterity] [int] NULL,
	[Vitality] [int] NULL,
	[Energy] [int] NULL,
	[Leadership] [int] NULL,
	[AutoReset] [tinyint] NOT NULL,
	[PointsLeft] [int] NOT NULL,
 CONSTRAINT [PK_ResetSystem] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_CGuid](
	[GUID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
 CONSTRAINT [PK_T_CGuid] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_FriendList](
	[GUID] [int] NOT NULL,
	[FriendGuid] [int] NULL,
	[FriendName] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[Del] [tinyint] NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_FriendMail](
	[MemoIndex] [int] NOT NULL,
	[GUID] [int] NOT NULL,
	[FriendName] [varchar](10) COLLATE Latin1_General_CI_AS NULL,
	[wDate] [smalldatetime] NOT NULL,
	[Subject] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[bRead] [bit] NOT NULL,
	[Memo] [varbinary](1000) NULL,
	[Photo] [binary](18) NULL,
	[Dir] [tinyint] NULL,
	[Act] [tinyint] NULL,
 CONSTRAINT [PK_T_FriendMemo] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC,
	[MemoIndex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_FriendMain](
	[GUID] [int] NOT NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[FriendCount] [tinyint] NULL,
	[MemoCount] [int] NULL,
	[MemoTotal] [int] NULL,
 CONSTRAINT [PK_T_FriendMain] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_PetItem_Info](
	[ItemSerial] [int] NOT NULL,
	[Pet_Level] [smallint] NULL,
	[Pet_Exp] [int] NULL,
 CONSTRAINT [PK_T_Pet_Info] PRIMARY KEY CLUSTERED 
(
	[ItemSerial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_WaitFriend](
	[GUID] [int] NOT NULL,
	[FriendGuid] [int] NOT NULL,
	[FriendName] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[warehouse](
	[AccountID] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Items] [varbinary](3840) NULL,
	[Money] [int] NULL,
	[EndUseDate] [smalldatetime] NULL,
	[DbVersion] [tinyint] NULL,
	[pw] [smallint] NULL,
 CONSTRAINT [PK_warehouse] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WarehouseGuild](
	[Guild] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[Items] [varbinary](3840) NULL,
	[Money] [int] NULL,
	[EndUseDate] [smalldatetime] NULL,
	[DbVersion] [tinyint] NULL,
	[pw] [smallint] NULL,
	[State] [int] NOT NULL,
	[ServerCode] [int] NOT NULL,
 CONSTRAINT [PK_warehouseguild] PRIMARY KEY CLUSTERED 
(
	[Guild] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WZ_CW_INFO](
	[MAP_SVR_GROUP] [int] NULL,
	[CRYWOLF_OCCUFY] [int] NULL,
	[CRYWOLF_STATE] [int] NULL
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[XTR_EventEnterCount](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[BloodCastle] [int] NOT NULL,
	[ChaosCastle] [int] NOT NULL,
	[DevilSquare] [int] NOT NULL,
	[DoppelGanger] [int] NOT NULL,
	[ImperialGuardianWeek] [int] NOT NULL,
	[IlussionTemple] [int] NOT NULL,
 CONSTRAINT [PK_XTR_EventEnterCount_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[XTR_JewelStore](
	[Account] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[AutoSave] [tinyint] NOT NULL,
	[AutoSaveResetTime] [int] NOT NULL,
	[AutoSaveCount] [int] NOT NULL,
	[7181] [int] NOT NULL,
	[7182] [int] NOT NULL,
	[6159] [int] NOT NULL,
	[7184] [int] NOT NULL,
	[7190] [int] NOT NULL,
	[7199] [int] NOT NULL,
	[7210] [int] NOT NULL,
	[7209] [int] NOT NULL,
	[7211] [int] NOT NULL,
	[7212] [int] NOT NULL,
	[6174] [int] NOT NULL,
	[6174_1] [int] NOT NULL,
	[6174_2] [int] NOT NULL,
	[6175] [int] NOT NULL,
	[6175_1] [int] NOT NULL,
	[6175_2] [int] NOT NULL,
	[6285] [int] NOT NULL,
	[6285_1] [int] NOT NULL,
	[6285_2] [int] NOT NULL,
	[6280] [int] NOT NULL,
	[6280_1] [int] NOT NULL,
	[6280_2] [int] NOT NULL,
	[7179_8] [int] NOT NULL,
	[7179_9] [int] NOT NULL,
	[7179_10] [int] NOT NULL,
	[7179_11] [int] NOT NULL,
	[7179_12] [int] NOT NULL,
	[6671] [int] NOT NULL,
	[6671_1] [int] NOT NULL,
	[6671_2] [int] NOT NULL,
	[6671_3] [int] NOT NULL,
	[7189_2] [int] NOT NULL,
	[7189_1] [int] NOT NULL,
 CONSTRAINT [PK_XTR_JewelStore] PRIMARY KEY CLUSTERED 
(
	[Account] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[XTR_PenaltyData](
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[NameType] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Time] [int] NOT NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[XTR_PetInventory](
	[Name] [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
	[PetInventory] [varbinary](16) NULL,
 CONSTRAINT [PK_XTR_PetInventory] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[XTR_PlayerDieLog](
	[Player1] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Player2] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Map] [int] NULL,
	[X] [int] NULL,
	[Y] [int] NULL,
	[Status] [int] NULL,
	[Date] [datetime] NULL
)
GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[XTR_QuestInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
	[QuestIndex] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Data] [varbinary](24) NULL,
	[State] [tinyint] NOT NULL,
	[Count] [int] NOT NULL,
	[Date] [int] NOT NULL,
 CONSTRAINT [PK_XTR_QuestInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[DefaultClassType] ([Class], [Level], [LevelUpPoint], [Strength], [Dexterity], [Vitality], [Energy], [Leadership], [Inventory], [MagicList], [Life], [MaxLife], [Mana], [MaxMana], [MapNumber], [MapPosX], [MapPosY], [Quest], [DbVersion], [EffectList]) VALUES (0, 1, 0, 26, 26, 26, 26, 0, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, NULL, 70, 70, 40, 40, 0, 182, 128, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 3, NULL)
GO
INSERT [dbo].[DefaultClassType] ([Class], [Level], [LevelUpPoint], [Strength], [Dexterity], [Vitality], [Energy], [Leadership], [Inventory], [MagicList], [Life], [MaxLife], [Mana], [MaxMana], [MapNumber], [MapPosX], [MapPosY], [Quest], [DbVersion], [EffectList]) VALUES (16, 1, 0, 26, 26, 26, 26, 0, 0x00001200000000000010000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, NULL, 70, 70, 40, 40, 0, 182, 128, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 3, NULL)
GO
INSERT [dbo].[DefaultClassType] ([Class], [Level], [LevelUpPoint], [Strength], [Dexterity], [Vitality], [Energy], [Leadership], [Inventory], [MagicList], [Life], [MaxLife], [Mana], [MaxMana], [MapNumber], [MapPosX], [MapPosY], [Quest], [DbVersion], [EffectList]) VALUES (32, 1, 0, 26, 26, 26, 26, 0, 0x0F00FF0000000000004000000000000000001400000000000040000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, NULL, 70, 70, 40, 40, 0, 182, 128, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 3, NULL)
GO
INSERT [dbo].[DefaultClassType] ([Class], [Level], [LevelUpPoint], [Strength], [Dexterity], [Vitality], [Energy], [Leadership], [Inventory], [MagicList], [Life], [MaxLife], [Mana], [MaxMana], [MapNumber], [MapPosX], [MapPosY], [Quest], [DbVersion], [EffectList]) VALUES (48, 1, 0, 26, 26, 26, 26, 0, 0x0100160000000000000000000000000000001600000000000060000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, NULL, 70, 70, 40, 40, 0, 182, 128, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 3, NULL)
GO
INSERT [dbo].[DefaultClassType] ([Class], [Level], [LevelUpPoint], [Strength], [Dexterity], [Vitality], [Energy], [Leadership], [Inventory], [MagicList], [Life], [MaxLife], [Mana], [MaxMana], [MapNumber], [MapPosX], [MapPosY], [Quest], [DbVersion], [EffectList]) VALUES (64, 1, 0, 26, 26, 26, 26, 26, 0x0100160000000000000000000000000000001600000000000060000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, NULL, 70, 70, 40, 40, 0, 182, 128, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 3, NULL)
GO
INSERT [dbo].[DefaultClassType] ([Class], [Level], [LevelUpPoint], [Strength], [Dexterity], [Vitality], [Energy], [Leadership], [Inventory], [MagicList], [Life], [MaxLife], [Mana], [MaxMana], [MapNumber], [MapPosX], [MapPosY], [Quest], [DbVersion], [EffectList]) VALUES (80, 1, 0, 26, 26, 26, 26, 0, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, NULL, 70, 70, 40, 40, 0, 182, 128, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 3, NULL)
GO
INSERT [dbo].[DefaultClassType] ([Class], [Level], [LevelUpPoint], [Strength], [Dexterity], [Vitality], [Energy], [Leadership], [Inventory], [MagicList], [Life], [MaxLife], [Mana], [MaxMana], [MapNumber], [MapPosX], [MapPosY], [Quest], [DbVersion], [EffectList]) VALUES (96, 1, 0, 26, 26, 26, 26, 0, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 100, 100, 40, 40, 0, 182, 128, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 3, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
GO
INSERT [dbo].[DefaultClassType] ([Class], [Level], [LevelUpPoint], [Strength], [Dexterity], [Vitality], [Energy], [Leadership], [Inventory], [MagicList], [Life], [MaxLife], [Mana], [MaxMana], [MapNumber], [MapPosX], [MapPosY], [Quest], [DbVersion], [EffectList]) VALUES (112, 1, 0, 30, 30, 25, 24, 0, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, NULL, 110, 110, 40, 40, 0, 182, 128, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, 3, NULL)
GO
INSERT [dbo].[GameServerInfo] ([Number], [ItemCount], [ZenCount], [AceItemCount], [GremoryCount], [ItemMarketCount]) VALUES (0, 4506288, 0, 0, 858, 295)
GO
INSERT [dbo].[MK_Server] ([rei_do_mk], [recorde_on]) VALUES (0, 0)
GO
INSERT [dbo].[MuCastle_DATA] ([MAP_SVR_GROUP], [SIEGE_START_DATE], [SIEGE_END_DATE], [SIEGE_GUILDLIST_SETTED], [SIEGE_ENDED], [CASTLE_OCCUPY], [OWNER_GUILD], [MONEY], [TAX_RATE_CHAOS], [TAX_RATE_STORE], [TAX_HUNT_ZONE]) VALUES (0, CAST(N'2027-01-01T00:00:00.000' AS DateTime), CAST(N'2027-08-01T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0.0000, 0, 0, 0)
GO
INSERT [dbo].[MuCastle_DATA] ([MAP_SVR_GROUP], [SIEGE_START_DATE], [SIEGE_END_DATE], [SIEGE_GUILDLIST_SETTED], [SIEGE_ENDED], [CASTLE_OCCUPY], [OWNER_GUILD], [MONEY], [TAX_RATE_CHAOS], [TAX_RATE_STORE], [TAX_HUNT_ZONE]) VALUES (1, CAST(N'2026-11-08T00:00:00.000' AS DateTime), CAST(N'2026-11-15T00:00:00.000' AS DateTime), 0, 0, 0, N'', 0.0000, 0, 0, 0)
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (0, 277, 1, 3, 0, 5200000, 5200000, 93, 204, 1, CAST(N'2026-11-01T18:38:25.527' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (0, 277, 2, 3, 0, 5200000, 5200000, 81, 161, 1, CAST(N'2026-11-01T18:38:25.527' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (0, 277, 3, 3, 0, 5200000, 5200000, 107, 161, 1, CAST(N'2026-11-01T18:38:25.527' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (0, 277, 4, 3, 0, 5200000, 5200000, 67, 114, 1, CAST(N'2026-11-01T18:38:25.530' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (0, 277, 5, 3, 0, 5200000, 5200000, 93, 114, 1, CAST(N'2026-11-01T18:38:25.530' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (0, 277, 6, 3, 0, 5200000, 5200000, 119, 114, 1, CAST(N'2026-11-01T18:38:25.530' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (1, 277, 6, 0, 0, 500000, 500000, 119, 114, 1, CAST(N'2026-11-13T08:06:21.310' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (1, 277, 5, 0, 0, 500000, 500000, 93, 114, 1, CAST(N'2026-11-13T08:06:21.310' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (1, 277, 4, 0, 0, 500000, 500000, 67, 114, 1, CAST(N'2026-11-13T08:06:21.310' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (1, 277, 3, 0, 0, 500000, 500000, 107, 161, 1, CAST(N'2026-11-13T08:06:21.307' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (1, 277, 2, 0, 0, 500000, 500000, 81, 161, 1, CAST(N'2026-11-13T08:06:21.307' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (1, 277, 1, 0, 0, 500000, 500000, 93, 204, 1, CAST(N'2026-11-13T08:06:21.307' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (1, 283, 4, 0, 0, 400000, 400000, 107, 130, 1, CAST(N'2026-11-13T08:06:21.307' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (1, 283, 3, 0, 0, 400000, 400000, 82, 130, 1, CAST(N'2026-11-13T08:06:21.307' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (1, 283, 2, 0, 0, 400000, 400000, 94, 182, 1, CAST(N'2026-11-13T08:06:21.307' AS DateTime))
GO
INSERT [dbo].[MuCastle_NPC] ([MAP_SVR_GROUP], [NPC_NUMBER], [NPC_INDEX], [NPC_DF_LEVEL], [NPC_RG_LEVEL], [NPC_MAXHP], [NPC_HP], [NPC_X], [NPC_Y], [NPC_DIR], [NPC_CREATEDATE]) VALUES (1, 283, 1, 0, 0, 400000, 400000, 94, 227, 1, CAST(N'2026-11-13T08:06:21.307' AS DateTime))
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[AccountCharacter] ADD  CONSTRAINT [PK_AccountCharacter] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_BattlePass_Name] ON [dbo].[BattlePass]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [PK_Character] PRIMARY KEY NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_ExtWarehouse_AccountID] ON [dbo].[ExtWarehouse]
(
	[AccountID] ASC,
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[GameServerInfo] ADD  CONSTRAINT [PK_GameServerInfo] PRIMARY KEY NONCLUSTERED 
(
	[Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[MEMB_INFO] ADD  CONSTRAINT [PK_MEMB_INFO_1] PRIMARY KEY NONCLUSTERED 
(
	[memb_guid] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_MEMB_INFO_memb___id] ON [dbo].[MEMB_INFO]
(
	[memb___id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
CREATE NONCLUSTERED INDEX [IX_MSPro_AchievementSummary_Points] ON [dbo].[MSPro_AchievementSummary]
(
	[Points] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[MSPro_AuctionDeliveries] ADD  CONSTRAINT [UQ_MSPro_AuctionDeliveries] UNIQUE NONCLUSTERED 
(
	[AuctionID] ASC,
	[Kind] ASC,
	[SourceVersion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_MSPro_AuctionDelivery_Owner] ON [dbo].[MSPro_AuctionDeliveries]
(
	[Account] ASC,
	[Name] ASC,
	[Claimed] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MSPro_AuctionEscrow] ON [dbo].[MSPro_Auctions]
(
	[Serial] ASC
)
WHERE ([Released]=(0))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_MSPro_Auctions_Ends] ON [dbo].[MSPro_Auctions]
(
	[State] ASC,
	[Ends] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[MuCastle_NPC] ADD  CONSTRAINT [IX_NPC_SUBKEY] UNIQUE NONCLUSTERED 
(
	[MAP_SVR_GROUP] ASC,
	[NPC_NUMBER] ASC,
	[NPC_INDEX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[MuCastle_REG_SIEGE] ADD  CONSTRAINT [IX_ATTACK_GUILD_SUBKEY] UNIQUE NONCLUSTERED 
(
	[MAP_SVR_GROUP] ASC,
	[REG_SIEGE_GUILD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_XTR_EventEnterCount_Name] ON [dbo].[XTR_EventEnterCount]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_XTR_QuestInfo_Name] ON [dbo].[XTR_QuestInfo]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[AccountCharacter] ADD  CONSTRAINT [DF__AccountCh__MoveC__7A3223E8]  DEFAULT ((0)) FOR [MoveCnt]
GO
ALTER TABLE [dbo].[AccountCharacter] ADD  CONSTRAINT [df_AccountCharacter_ExtClass]  DEFAULT ((0)) FOR [ExtClass]
GO
ALTER TABLE [dbo].[AccountCharacter] ADD  CONSTRAINT [DF__AccountCh__ExtWa__793DFFAF]  DEFAULT ((0)) FOR [ExtWarehouse]
GO
ALTER TABLE [dbo].[AutoAddStats] ADD  CONSTRAINT [DF_AutoAddStats_Enable]  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[AutoAddStats] ADD  CONSTRAINT [DF_AutoAddStats_STR]  DEFAULT ((0)) FOR [STR]
GO
ALTER TABLE [dbo].[AutoAddStats] ADD  CONSTRAINT [DF_AutoAddStats_AGI]  DEFAULT ((0)) FOR [AGI]
GO
ALTER TABLE [dbo].[AutoAddStats] ADD  CONSTRAINT [DF_AutoAddStats_VIT]  DEFAULT ((0)) FOR [VIT]
GO
ALTER TABLE [dbo].[AutoAddStats] ADD  CONSTRAINT [DF_AutoAddStats_ENE]  DEFAULT ((0)) FOR [ENE]
GO
ALTER TABLE [dbo].[AutoAddStats] ADD  CONSTRAINT [DF_AutoAddStats_CMD]  DEFAULT ((0)) FOR [CMD]
GO
ALTER TABLE [dbo].[AutoAddStats] ADD  CONSTRAINT [DF_AutoAddStats_Level]  DEFAULT ((0)) FOR [Level]
GO
ALTER TABLE [dbo].[BattlePass] ADD  DEFAULT ((0)) FOR [ExpPoints]
GO
ALTER TABLE [dbo].[BattlePass] ADD  DEFAULT ((0)) FOR [CurrentLevel]
GO
ALTER TABLE [dbo].[BattlePass] ADD  DEFAULT ((0)) FOR [HasPremium]
GO
ALTER TABLE [dbo].[BattlePass] ADD  DEFAULT ((0)) FOR [PremiumExpireDate]
GO
ALTER TABLE [dbo].[BattlePass] ADD  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[BattlePass_Rewards] ADD  DEFAULT (getdate()) FOR [ClaimDate]
GO
ALTER TABLE [dbo].[CashLog] ADD  DEFAULT (getdate()) FOR [SentDate]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_cLevel]  DEFAULT ((1)) FOR [cLevel]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_LevelUpPoint]  DEFAULT ((0)) FOR [LevelUpPoint]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__Leade__7A672E12]  DEFAULT ((0)) FOR [Leadership]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_Money]  DEFAULT ((0)) FOR [Money]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_MapDir]  DEFAULT ((0)) FOR [MapDir]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_PkCount]  DEFAULT ((0)) FOR [PkCount]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_PkLevel]  DEFAULT ((3)) FOR [PkLevel]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_PkTime]  DEFAULT ((0)) FOR [PkTime]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_CtlCode]  DEFAULT ((0)) FOR [CtlCode]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__DbVer__787EE5A0]  DEFAULT ((0)) FOR [DbVersion]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__Quest__797309D9]  DEFAULT ((0)) FOR [Quest]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__ChatL__7B5B524B]  DEFAULT ((0)) FOR [ChatLimitTime]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_FruitPoint]  DEFAULT ((0)) FOR [FruitPoint]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__Fruit__4F67C174]  DEFAULT ((0)) FOR [FruitAddPoint]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__Fruit__505BE5AD]  DEFAULT ((0)) FOR [FruitSubPoint]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_ResetCount]  DEFAULT ((0)) FOR [ResetCount]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__Maste__7CF981FA]  DEFAULT ((0)) FOR [MasterResetCount]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__ExtIn__40E497F3]  DEFAULT ((0)) FOR [ExtInventory]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_Kills]  DEFAULT ((0)) FOR [Kills]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_Deads]  DEFAULT ((0)) FOR [Deads]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_ResetDay]  DEFAULT ((0)) FOR [ResetDay]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__Reset__6225902D]  DEFAULT ((0)) FOR [ResetWek]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__Reset__6319B466]  DEFAULT ((0)) FOR [ResetMon]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_ItemStart]  DEFAULT ((0)) FOR [ItemStart]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_RuudToken]  DEFAULT ((0)) FOR [RuudToken]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__LastD__257187A8]  DEFAULT ((0)) FOR [LastDivorceStyle]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_ResetLimit]  DEFAULT ((0)) FOR [ResetLimit]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__Maste__284DF453]  DEFAULT ((0)) FOR [MasterResetLimit]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_Flag]  DEFAULT ((255)) FOR [Flag]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_Experience]  DEFAULT ((0)) FOR [Experience]
GO
ALTER TABLE [dbo].[Character] ADD  DEFAULT ((0)) FOR [NewExperience]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF_Character_BanChat]  DEFAULT ((0)) FOR [BanChat]
GO
ALTER TABLE [dbo].[Character] ADD  DEFAULT ((0)) FOR [ElementID]
GO
ALTER TABLE [dbo].[Character] ADD  DEFAULT ((0)) FOR [BonusPoints]
GO
ALTER TABLE [dbo].[Character] ADD  CONSTRAINT [DF__Character__Allow__10C14EDC]  DEFAULT ((0)) FOR [AllowSummonParty]
GO
ALTER TABLE [dbo].[Character] ADD  DEFAULT ((0)) FOR [BlockSummonParty]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_Enable3D]  DEFAULT ((0)) FOR [Enable3D]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_EnableMiniMap]  DEFAULT ((0)) FOR [EnableMiniMap]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_EnableTime]  DEFAULT ((0)) FOR [EnableTime]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_EnableFog]  DEFAULT ((0)) FOR [EnableFog]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_MonstersHPBar]  DEFAULT ((0)) FOR [MonstersHPBar]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_PlayersHPBar]  DEFAULT ((0)) FOR [PlayersHPBar]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_ReduceZenInFloor]  DEFAULT ((0)) FOR [ReduceZenInFloor]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_ShowCharName]  DEFAULT ((0)) FOR [ShowCharName]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_AntiLag]  DEFAULT ((0)) FOR [AntiLag]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_MiniMapX]  DEFAULT ((0)) FOR [MiniMapX]
GO
ALTER TABLE [dbo].[ClientSettings] ADD  CONSTRAINT [DF_ClientSettings_MiniMapY]  DEFAULT ((0)) FOR [MiniMapY]
GO
ALTER TABLE [dbo].[CustomGift] ADD  CONSTRAINT [DF_CustomGift_date]  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[CustomNpcQuest] ADD  CONSTRAINT [DF_CustomNpcQuest_Quest]  DEFAULT ((0)) FOR [Quest]
GO
ALTER TABLE [dbo].[CustomNpcQuest] ADD  CONSTRAINT [DF_CustomNpcQuest_Count]  DEFAULT ((0)) FOR [Count]
GO
ALTER TABLE [dbo].[CustomNpcQuest] ADD  CONSTRAINT [DF_CustomNpcQuest_MonsterQtd]  DEFAULT ((0)) FOR [MonsterCount]
GO
ALTER TABLE [dbo].[CustomQuest] ADD  DEFAULT ((0)) FOR [Quest]
GO
ALTER TABLE [dbo].[DailyBonus] ADD  CONSTRAINT [DF_DailyBonus_Day0]  DEFAULT ((0)) FOR [Day0]
GO
ALTER TABLE [dbo].[DailyBonus] ADD  CONSTRAINT [DF_DailyBonus_Day1]  DEFAULT ((0)) FOR [Day1]
GO
ALTER TABLE [dbo].[DailyBonus] ADD  CONSTRAINT [DF_DailyBonus_Day2]  DEFAULT ((0)) FOR [Day2]
GO
ALTER TABLE [dbo].[DailyBonus] ADD  CONSTRAINT [DF_DailyBonus_Day3]  DEFAULT ((0)) FOR [Day3]
GO
ALTER TABLE [dbo].[DailyBonus] ADD  CONSTRAINT [DF_DailyBonus_Day4]  DEFAULT ((0)) FOR [Day4]
GO
ALTER TABLE [dbo].[DailyBonus] ADD  CONSTRAINT [DF_DailyBonus_Day5]  DEFAULT ((0)) FOR [Day5]
GO
ALTER TABLE [dbo].[DailyBonus] ADD  CONSTRAINT [DF_DailyBonus_Day6]  DEFAULT ((0)) FOR [Day6]
GO
ALTER TABLE [dbo].[DefaultClassType] ADD  CONSTRAINT [DF__DefaultCl__Level__72910220]  DEFAULT ((0)) FOR [Level]
GO
ALTER TABLE [dbo].[DefaultClassType] ADD  CONSTRAINT [DF__DefaultCl__Level__73852659]  DEFAULT ((0)) FOR [LevelUpPoint]
GO
ALTER TABLE [dbo].[DefaultClassType] ADD  CONSTRAINT [DF__DefaultCl__Leade__719CDDE7]  DEFAULT ((0)) FOR [Leadership]
GO
ALTER TABLE [dbo].[FortuneWheel] ADD  CONSTRAINT [DF_FortuneWheel_Count]  DEFAULT ((0)) FOR [Count]
GO
ALTER TABLE [dbo].[GameServerInfo] ADD  CONSTRAINT [DF_GameServerInfo_Number]  DEFAULT ((0)) FOR [Number]
GO
ALTER TABLE [dbo].[GameServerInfo] ADD  CONSTRAINT [DF_GameServerInfo_ZenCount]  DEFAULT ((0)) FOR [ZenCount]
GO
ALTER TABLE [dbo].[GameServerInfo] ADD  CONSTRAINT [DF_GameServerInfo_GremoryCount]  DEFAULT ((0)) FOR [GremoryCount]
GO
ALTER TABLE [dbo].[GameServerInfo] ADD  DEFAULT ((0)) FOR [ItemMarketCount]
GO
ALTER TABLE [dbo].[GiftCodes] ADD  DEFAULT ((0)) FOR [UseCount]
GO
ALTER TABLE [dbo].[GiftCodes] ADD  DEFAULT ((0)) FOR [ResetTime]
GO
ALTER TABLE [dbo].[GremoryCase] ADD  CONSTRAINT [DF_GremoryCase_Type]  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Guild] ADD  CONSTRAINT [DF_Guild_G_Score]  DEFAULT ((0)) FOR [G_Score]
GO
ALTER TABLE [dbo].[Guild] ADD  CONSTRAINT [DF__Guild__G_Type__0D7A0286]  DEFAULT ((0)) FOR [G_Type]
GO
ALTER TABLE [dbo].[Guild] ADD  CONSTRAINT [DF__Guild__G_Rival__0E6E26BF]  DEFAULT ((0)) FOR [G_Rival]
GO
ALTER TABLE [dbo].[Guild] ADD  CONSTRAINT [DF__Guild__G_Union__0F624AF8]  DEFAULT ((0)) FOR [G_Union]
GO
ALTER TABLE [dbo].[Guild] ADD  CONSTRAINT [DF__Guild__MemberCou__10566F31]  DEFAULT ((0)) FOR [MemberCount]
GO
ALTER TABLE [dbo].[GuildMember] ADD  CONSTRAINT [DF__GuildMemb__G_Sta__01D345B0]  DEFAULT ((0)) FOR [G_Status]
GO
ALTER TABLE [dbo].[GuildWarehouseConfig] ADD  DEFAULT ((0)) FOR [DefaultCanDeposit]
GO
ALTER TABLE [dbo].[GuildWarehouseConfig] ADD  DEFAULT ((0)) FOR [DefaultCanWithdraw]
GO
ALTER TABLE [dbo].[GuildWarehouseConfig] ADD  DEFAULT ((0)) FOR [BattleMasterCanManage]
GO
ALTER TABLE [dbo].[GuildWarehouseConfig] ADD  DEFAULT ((0)) FOR [AssistantCanManage]
GO
ALTER TABLE [dbo].[GuildWarehousePermissions] ADD  DEFAULT ((0)) FOR [CanDeposit]
GO
ALTER TABLE [dbo].[GuildWarehousePermissions] ADD  DEFAULT ((0)) FOR [CanWithdraw]
GO
ALTER TABLE [dbo].[ItemLog] ADD  DEFAULT (getdate()) FOR [SentDate]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_Zen]  DEFAULT ((0)) FOR [Zen]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_WC]  DEFAULT ((0)) FOR [WC]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_WP]  DEFAULT ((0)) FOR [WP]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_GP]  DEFAULT ((0)) FOR [GP]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_Ruuds]  DEFAULT ((0)) FOR [Ruuds]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_Chaos]  DEFAULT ((0)) FOR [Chaos]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_Bless]  DEFAULT ((0)) FOR [Bless]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_Soul]  DEFAULT ((0)) FOR [Soul]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_Life]  DEFAULT ((0)) FOR [Life]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_Creation]  DEFAULT ((0)) FOR [Creation]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_Datetime]  DEFAULT ((0)) FOR [DateTime]
GO
ALTER TABLE [dbo].[ItemMarket] ADD  CONSTRAINT [DF_ItemMarket_Status]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[KillLog] ADD  CONSTRAINT [DF_KillLog_Kills]  DEFAULT ((0)) FOR [KD1]
GO
ALTER TABLE [dbo].[KillLog] ADD  CONSTRAINT [DF_KillLog_Class1]  DEFAULT ((0)) FOR [Class1]
GO
ALTER TABLE [dbo].[KillLog] ADD  CONSTRAINT [DF_KillLog_L1]  DEFAULT ((0)) FOR [L1]
GO
ALTER TABLE [dbo].[KillLog] ADD  CONSTRAINT [DF_KillLog_R1]  DEFAULT ((0)) FOR [R1]
GO
ALTER TABLE [dbo].[KillLog] ADD  CONSTRAINT [DF_KillLog_MR1]  DEFAULT ((0)) FOR [MR1]
GO
ALTER TABLE [dbo].[KillLog] ADD  CONSTRAINT [DF_KillLog_Class2]  DEFAULT ((0)) FOR [Class2]
GO
ALTER TABLE [dbo].[KillLog] ADD  CONSTRAINT [DF_KillLog_Death]  DEFAULT ((0)) FOR [KD2]
GO
ALTER TABLE [dbo].[KillLog] ADD  CONSTRAINT [DF_KillLog_L2]  DEFAULT ((0)) FOR [L2]
GO
ALTER TABLE [dbo].[KillLog] ADD  CONSTRAINT [DF_KillLog_R2]  DEFAULT ((0)) FOR [R2]
GO
ALTER TABLE [dbo].[KillLog] ADD  CONSTRAINT [DF_KillLog_MR2]  DEFAULT ((0)) FOR [MR2]
GO
ALTER TABLE [dbo].[LockManager] ADD  CONSTRAINT [DF_LockManager_MoveItems]  DEFAULT ((0)) FOR [MoveItems]
GO
ALTER TABLE [dbo].[LockManager] ADD  CONSTRAINT [DF_LockManager_PersonalStore]  DEFAULT ((0)) FOR [PersonalStore]
GO
ALTER TABLE [dbo].[LockManager] ADD  CONSTRAINT [DF_LockManager_ShopBuy]  DEFAULT ((0)) FOR [ShopBuy]
GO
ALTER TABLE [dbo].[LockManager] ADD  CONSTRAINT [DF_LockManager_ShopSell]  DEFAULT ((0)) FOR [ShopSell]
GO
ALTER TABLE [dbo].[LockManager] ADD  CONSTRAINT [DF_LockManager_JewelBank]  DEFAULT ((0)) FOR [JewelBank]
GO
ALTER TABLE [dbo].[LockManager] ADD  CONSTRAINT [DF_LockManager_StatsChange]  DEFAULT ((0)) FOR [StatsChange]
GO
ALTER TABLE [dbo].[LockManager] ADD  CONSTRAINT [DF_LockManager_CommandsUse]  DEFAULT ((0)) FOR [CommandsUse]
GO
ALTER TABLE [dbo].[LockManager] ADD  CONSTRAINT [DF_LockManager_GuildChanges]  DEFAULT ((0)) FOR [GuildChanges]
GO
ALTER TABLE [dbo].[LockManager] ADD  CONSTRAINT [DF_LockManager_CharactersDelete]  DEFAULT ((0)) FOR [CharactersDelete]
GO
ALTER TABLE [dbo].[LOG_CREDITOS] ADD  DEFAULT ((0)) FOR [valor]
GO
ALTER TABLE [dbo].[LOG_CREDITOS] ADD  DEFAULT (getdate()) FOR [data]
GO
ALTER TABLE [dbo].[LOG_CREDITOS] ADD  DEFAULT ((0)) FOR [tipo]
GO
ALTER TABLE [dbo].[Marry] ADD  CONSTRAINT [DF_Marry_MarriedOn]  DEFAULT (getdate()) FOR [MarryDate]
GO
ALTER TABLE [dbo].[MEMB_INFO] ADD  CONSTRAINT [DF_MEMB_INFO_mail_chek]  DEFAULT ((0)) FOR [mail_chek]
GO
ALTER TABLE [dbo].[MEMB_INFO] ADD  CONSTRAINT [DF_MEMB_INFO_AccountLevel]  DEFAULT ((0)) FOR [AccountLevel]
GO
ALTER TABLE [dbo].[MEMB_INFO] ADD  CONSTRAINT [DF__MEMB_INFO__Accou__3493CFA7]  DEFAULT ((0)) FOR [AccountExpireDate]
GO
ALTER TABLE [dbo].[MEMB_INFO] ADD  CONSTRAINT [DF_MEMB_INFO_Lock]  DEFAULT ((0)) FOR [Lock]
GO
ALTER TABLE [dbo].[MEMB_INFO] ADD  CONSTRAINT [DF__MEMB_INFO__Golde__2665ABE1]  DEFAULT ((0)) FOR [GoldenArcherCount]
GO
ALTER TABLE [dbo].[MEMB_INFO] ADD  CONSTRAINT [DF_MEMB_INFO_GiftCount]  DEFAULT ((0)) FOR [GiftCount]
GO
ALTER TABLE [dbo].[MEMB_STAT] ADD  CONSTRAINT [DF__MEMB_STAT__Onlin__22751F6C]  DEFAULT ((0)) FOR [OnlineHours]
GO
ALTER TABLE [dbo].[MK_Server] ADD  CONSTRAINT [DF_Server_rei_do_mk]  DEFAULT ((0)) FOR [rei_do_mk]
GO
ALTER TABLE [dbo].[MonstersCount] ADD  CONSTRAINT [DF_MonstersCount_Monster]  DEFAULT ((0)) FOR [MonsterID]
GO
ALTER TABLE [dbo].[MonstersCount] ADD  CONSTRAINT [DF_MonstersCount_Count]  DEFAULT ((0)) FOR [KillCount]
GO
ALTER TABLE [dbo].[MSPro_AchievementMilestones] ADD  DEFAULT (getdate()) FOR [Claimed]
GO
ALTER TABLE [dbo].[MSPro_Achievements] ADD  DEFAULT ((0)) FOR [Tier]
GO
ALTER TABLE [dbo].[MSPro_Achievements] ADD  DEFAULT ((0)) FOR [Claimed]
GO
ALTER TABLE [dbo].[MSPro_Achievements] ADD  DEFAULT ((0)) FOR [Progress]
GO
ALTER TABLE [dbo].[MSPro_Achievements] ADD  DEFAULT (getdate()) FOR [Updated]
GO
ALTER TABLE [dbo].[MSPro_AchievementSummary] ADD  DEFAULT ((0)) FOR [Points]
GO
ALTER TABLE [dbo].[MSPro_AchievementSummary] ADD  DEFAULT ((0)) FOR [Completed]
GO
ALTER TABLE [dbo].[MSPro_AchievementSummary] ADD  DEFAULT (getdate()) FOR [Updated]
GO
ALTER TABLE [dbo].[MSPro_AuctionDeliveries] ADD  DEFAULT ((0)) FOR [Version]
GO
ALTER TABLE [dbo].[MSPro_AuctionDeliveries] ADD  DEFAULT ((0)) FOR [Claimed]
GO
ALTER TABLE [dbo].[MSPro_Auctions] ADD  DEFAULT ((0)) FOR [Version]
GO
ALTER TABLE [dbo].[MSPro_Auctions] ADD  DEFAULT ('active') FOR [State]
GO
ALTER TABLE [dbo].[MSPro_Auctions] ADD  DEFAULT ((0)) FOR [Released]
GO
ALTER TABLE [dbo].[MSPro_JewelBank] ADD  DEFAULT ((0)) FOR [Level]
GO
ALTER TABLE [dbo].[MSPro_JewelBank] ADD  DEFAULT ((0)) FOR [Count]
GO
ALTER TABLE [dbo].[MSPro_JewelBank_Config] ADD  DEFAULT ((0)) FOR [AutoSave]
GO
ALTER TABLE [dbo].[MSPro_JewelBank_Config] ADD  DEFAULT ((0)) FOR [AutoSaveResetTime]
GO
ALTER TABLE [dbo].[MSPro_JewelBank_Config] ADD  DEFAULT ((0)) FOR [AutoSaveCount]
GO
ALTER TABLE [dbo].[MSPro_LuaStorage] ADD  DEFAULT (getdate()) FOR [Updated]
GO
ALTER TABLE [dbo].[MuCastle_DATA] ADD  CONSTRAINT [DF_MuCastle_Data_SEIGE_ENDED]  DEFAULT ((0)) FOR [SIEGE_ENDED]
GO
ALTER TABLE [dbo].[MuCastle_DATA] ADD  CONSTRAINT [DF_MuCastle_Data_CASTLE_OCCUPY]  DEFAULT ((0)) FOR [CASTLE_OCCUPY]
GO
ALTER TABLE [dbo].[MuCastle_DATA] ADD  CONSTRAINT [DF_MuCastle_Data_MONEY]  DEFAULT ((0)) FOR [MONEY]
GO
ALTER TABLE [dbo].[MuCastle_DATA] ADD  CONSTRAINT [DF_MuCastle_Data_TAX_RATE]  DEFAULT ((0)) FOR [TAX_RATE_CHAOS]
GO
ALTER TABLE [dbo].[MuCastle_DATA] ADD  CONSTRAINT [DF_MuCastle_DATA_TAX_RATE_STORE]  DEFAULT ((0)) FOR [TAX_RATE_STORE]
GO
ALTER TABLE [dbo].[MuCastle_DATA] ADD  CONSTRAINT [DF_MuCastle_DATA_TAX_HUNT_ZONE]  DEFAULT ((0)) FOR [TAX_HUNT_ZONE]
GO
ALTER TABLE [dbo].[RankingBloodCastle] ADD  DEFAULT ((0)) FOR [Score_semanal]
GO
ALTER TABLE [dbo].[RankingChaosCastle] ADD  DEFAULT ((0)) FOR [Score_semanal]
GO
ALTER TABLE [dbo].[RankingDevilSquare] ADD  DEFAULT ((0)) FOR [Score_semanal]
GO
ALTER TABLE [dbo].[RankingDuel] ADD  DEFAULT ((0)) FOR [WinScore_semanal]
GO
ALTER TABLE [dbo].[RankingTvT] ADD  CONSTRAINT [DF_RankingTvT_Kills]  DEFAULT ((0)) FOR [Kills]
GO
ALTER TABLE [dbo].[RankingTvT] ADD  CONSTRAINT [DF_RankingTvT_Deads]  DEFAULT ((0)) FOR [Deads]
GO
ALTER TABLE [dbo].[ResetSystem] ADD  CONSTRAINT [DF_ResetSystem_Leadership]  DEFAULT ((0)) FOR [Leadership]
GO
ALTER TABLE [dbo].[ResetSystem] ADD  CONSTRAINT [DF_ResetSystem_AutoReset]  DEFAULT ((0)) FOR [AutoReset]
GO
ALTER TABLE [dbo].[ResetSystem] ADD  CONSTRAINT [DF_ResetSystem_LeftPoints]  DEFAULT ((0)) FOR [PointsLeft]
GO
ALTER TABLE [dbo].[T_FriendList] ADD  CONSTRAINT [DF_T_FriendList_Del]  DEFAULT ((0)) FOR [Del]
GO
ALTER TABLE [dbo].[T_FriendMail] ADD  CONSTRAINT [DF_T_FriendMemo_MemoIndex]  DEFAULT ((10)) FOR [MemoIndex]
GO
ALTER TABLE [dbo].[T_FriendMail] ADD  CONSTRAINT [DF_T_FriendMemo_wDate]  DEFAULT (getdate()) FOR [wDate]
GO
ALTER TABLE [dbo].[T_FriendMail] ADD  CONSTRAINT [DF_T_FriendMemo_MemoRead]  DEFAULT ((0)) FOR [bRead]
GO
ALTER TABLE [dbo].[T_FriendMail] ADD  CONSTRAINT [DF_T_FriendMemo_Dir]  DEFAULT ((0)) FOR [Dir]
GO
ALTER TABLE [dbo].[T_FriendMail] ADD  CONSTRAINT [DF_T_FriendMemo_Action]  DEFAULT ((0)) FOR [Act]
GO
ALTER TABLE [dbo].[T_FriendMain] ADD  CONSTRAINT [DF_T_FriendMain_MemoCount]  DEFAULT ((10)) FOR [MemoCount]
GO
ALTER TABLE [dbo].[T_FriendMain] ADD  CONSTRAINT [DF_T_FriendMain_MemoTotal]  DEFAULT ((0)) FOR [MemoTotal]
GO
ALTER TABLE [dbo].[T_PetItem_Info] ADD  CONSTRAINT [DF_T_Pet_Info_Pet_Level]  DEFAULT ((0)) FOR [Pet_Level]
GO
ALTER TABLE [dbo].[T_PetItem_Info] ADD  CONSTRAINT [DF_T_Pet_Info_Pet_Exp]  DEFAULT ((0)) FOR [Pet_Exp]
GO
ALTER TABLE [dbo].[warehouse] ADD  CONSTRAINT [DF_warehouse_Money]  DEFAULT ((0)) FOR [Money]
GO
ALTER TABLE [dbo].[warehouse] ADD  CONSTRAINT [DF__warehouse__DbVer__690797E6]  DEFAULT ((0)) FOR [DbVersion]
GO
ALTER TABLE [dbo].[warehouse] ADD  CONSTRAINT [DF__warehouse__pw__69FBBC1F]  DEFAULT ((0)) FOR [pw]
GO
ALTER TABLE [dbo].[WarehouseGuild] ADD  CONSTRAINT [DF_WarehouseGuild_State]  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[WarehouseGuild] ADD  CONSTRAINT [DF_WarehouseGuild_ServerCode]  DEFAULT ((0)) FOR [ServerCode]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  CONSTRAINT [DF_XTR_JewelStore_AutoSave]  DEFAULT ((0)) FOR [AutoSave]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  CONSTRAINT [DF_XTR_JewelStore_AutoSaveResetTime]  DEFAULT ((0)) FOR [AutoSaveResetTime]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  CONSTRAINT [DF_XTR_JewelStore_AutoSaveCount]  DEFAULT ((0)) FOR [AutoSaveCount]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7181]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7182]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6159]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7184]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7190]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7199]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7210]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7209]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7211]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7212]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6174]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6174_1]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6174_2]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6175]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6175_1]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6175_2]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6285]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6285_1]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6285_2]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6280]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6280_1]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6280_2]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7179_8]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7179_9]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7179_10]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7179_11]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7179_12]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6671]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6671_1]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6671_2]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [6671_3]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7189_2]
GO
ALTER TABLE [dbo].[XTR_JewelStore] ADD  DEFAULT ((0)) FOR [7189_1]
GO
ALTER TABLE [dbo].[XTR_QuestInfo] ADD  CONSTRAINT [DF_XTR_QuestInfo_QuestState]  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[XTR_QuestInfo] ADD  CONSTRAINT [DF_XTR_QuestInfo_State]  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[XTR_QuestInfo] ADD  CONSTRAINT [DF_XTR_QuestInfo_Count]  DEFAULT ((0)) FOR [Count]
GO
ALTER TABLE [dbo].[XTR_QuestInfo] ADD  CONSTRAINT [DF_XTR_QuestInfo_Date]  DEFAULT ((0)) FOR [Date]
GO
ALTER TABLE [dbo].[BattlePass_Rewards]  WITH CHECK ADD FOREIGN KEY([Name])
REFERENCES [dbo].[BattlePass] ([Name])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomNpcQuest]  WITH CHECK ADD  CONSTRAINT [FK_CustomNpcQuest_Character] FOREIGN KEY([Name])
REFERENCES [dbo].[Character] ([Name])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomNpcQuest] CHECK CONSTRAINT [FK_CustomNpcQuest_Character]
GO
ALTER TABLE [dbo].[CustomQuest]  WITH CHECK ADD  CONSTRAINT [FK_CustomQuest_Character] FOREIGN KEY([Name])
REFERENCES [dbo].[Character] ([Name])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CustomQuest] CHECK CONSTRAINT [FK_CustomQuest_Character]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[fn_rank_gens]
(
@name varchar(10),
@familia int
)
returns int
as
begin
declare @valor int;

set @valor = 0;

if exists (select Contribution from Gens_Rank where Name = @name and Contribution > 9999)
begin
WITH cte AS (
SELECT DENSE_RANK() OVER (ORDER BY contribution DESC) AS Rank, Name
FROM Gens_Rank where family=@familia)
select @valor = rank from cte where Name = @name;
end

return @valor;
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION dbo.SplitString (@stringToSplit VARCHAR(MAX))
RETURNS
 @returnList TABLE ([Name] [nvarchar] (500))
AS
BEGIN

 DECLARE @name NVARCHAR(255)
 DECLARE @pos INT

 WHILE CHARINDEX(',', @stringToSplit) > 0
 BEGIN
  SELECT @pos  = CHARINDEX(',', @stringToSplit)  
  SELECT @name = SUBSTRING(@stringToSplit, 1, @pos-1)

  INSERT INTO @returnList 
  SELECT @name

  SELECT @stringToSplit = SUBSTRING(@stringToSplit, @pos+1, LEN(@stringToSplit)-@pos)
 END

 INSERT INTO @returnList
 SELECT @stringToSplit

 RETURN
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[MSP_AddCountFortuneWheel]
	@Name varchar(10),
	@Type int,
	@Wheel int
AS
BEGIN

	IF NOT EXISTS (SELECT Count FROM FortuneWheel WHERE Name = @Name AND Wheel = @Wheel)
		BEGIN
			INSERT INTO FortuneWheel (Name, Wheel, Count) VALUES (@Name, @Wheel, 1)
		END
	ELSE
		BEGIN
			IF @Type = 1
				BEGIN
					UPDATE FortuneWheel SET Count = (Count - 1) WHERE Name = @Name AND Wheel = @Wheel
				END
			ELSE
				BEGIN
					UPDATE FortuneWheel SET Count = (Count + 1) WHERE Name = @Name AND Wheel = @Wheel
				END
			
		END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[MSP_CheckDeleteCharacter] 
@Account varchar(10),
@Name varchar(10),
@MaxLevel int,
@MaxResets int,
@MaxMasterResets int
AS
BEGIN
SET NOCOUNT ON
SET XACT_ABORT ON
DECLARE @Result tinyint
DECLARE @Level int
DECLARE @Resets int
DECLARE @MasterResets int
SET @Result = 0
SET @Level = 0
SET @Resets = 0
SET @MasterResets = 0
-- Retrieve the character details
SELECT 
	@Level = cLevel, 
	@Resets = ResetCount, 
	@MasterResets = MasterResetCount
FROM 
	Character 
WHERE 
	Name = @Name

-- Check if character exists and if level, resets, and master resets exceed the limits
IF (@Level IS NULL)
BEGIN
	-- Character does not exist
	SET @Result = 0
END
ELSE IF ((@Level >= @MaxLevel) OR (@MaxResets > 0 AND @Resets >= @MaxResets) OR (@MaxMasterResets > 0 AND @MasterResets >= @MaxMasterResets))
BEGIN
	-- Level, Resets, or MasterResets exceeds the allowed limits
	SET @Result = 3
END
ELSE
BEGIN
	-- Passed all checks, proceed with deletion
	SET @Result = 1
END
-- Return the result
SELECT @Result
SET NOCOUNT OFF
SET XACT_ABORT OFF
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MSP_ExchangeGiftCode]
	@Name varchar(10),
	@GiftCode varchar(10),
	@Limit int,
	@ResetTime int,
	@Time int,
	@GlobalCount tinyint
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Result tinyint
	DECLARE @NextTime int
	SET @NextTime = (@Time + @ResetTime)
	SET @Result = 0x00
	if(@GlobalCount > 0)
	BEGIN
		DECLARE @Count int
		SET @Count = 0
		SELECT @Count = SUM(ALL UseCount) FROM GiftCodes WHERE GiftCode = @GiftCode
		IF(@Count >= @GlobalCount)
		BEGIN
			SET @Result = 0x02
			GOTO ResultEnd
		END
	END
	IF NOT EXISTS (SELECT Name FROM GiftCodes WHERE Name = @Name AND GiftCode = @GiftCode)
		BEGIN
			INSERT INTO GiftCodes (Name, GiftCode, UseCount, ResetTime) VALUES (@Name, @GiftCode, 1, @NextTime)
		END
	ELSE
		BEGIN
			DECLARE @GetCount int, @GetTime int
			SELECT @GetCount = UseCount, @GetTime = ResetTime FROM GiftCodes WHERE Name = @Name AND GiftCode = @GiftCode
			IF (@Limit > 0 AND @GetCount >= @Limit)
			BEGIN
				IF(@ResetTime > 0 AND @Time > @GetTime)
				BEGIN
					UPDATE GiftCodes SET UseCount = 1, ResetTime = @NextTime  WHERE Name = @Name AND GiftCode = @GiftCode
					GOTO ResultEnd
				END

				SET @Result = 0x01
				GOTO ResultEnd
			END
			UPDATE GiftCodes SET UseCount = UseCount + 1, ResetTime = @NextTime WHERE Name = @Name AND GiftCode = @GiftCode
		END
	GOTO ResultEnd
ResultEnd:
	SET NOCOUNT OFF
	SET	XACT_ABORT OFF
	SELECT Result = @Result
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MSP_GetFortuneWheel]
	@Name varchar(10)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM FortuneWheel WHERE Name = @Name
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[MSP_GetKillLog]
	@Name varchar(10)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 20 * FROM KillLog WHERE Name1 = @Name OR Name2 = @Name ORDER BY DateTime DESC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[MSP_GetKillLogByChar]
	@Name varchar(10),
	@Target varchar(10)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 * FROM KillLog WHERE (Name1 = @Name AND Name2 = @Target) OR (Name2 = @Name AND Name1 = @Target) ORDER BY DateTime DESC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MSP_ResetFortuneWheel]
	@ID varchar(4096)
AS
BEGIN
	UPDATE FortuneWheel SET Count = 0 WHERE Wheel IN (SELECT * FROM dbo.SplitString(@ID))
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MSP_SetKillLog]
	@Name1 varchar(10), /* Killer */
	@Name2 varchar(10), /* Killed */
	@Class1 int,
	@L1 int,
	@R1 int,
	@MR1 int,
	@GName1 varchar(8),
	@Class2 int,
	@L2 int,
	@R2 int,
	@MR2 int,
	@GName2 varchar(8),
	@DateTime int
AS
BEGIN
	SET NOCOUNT ON;
	
	IF NOT EXISTS (SELECT 1 FROM KillLog WHERE (Name1 = @Name1 AND Name2 = @Name2) OR (Name1 = @Name2 AND Name2 = @Name1))
		BEGIN
			INSERT INTO KillLog (Name1, Name2, KD1, KD2, Class1, L1, R1, MR1, GName1, Class2, L2, R2, MR2, GName2, DateTime) 
			VALUES (@Name1, @Name2, 1, 0, @Class1, @L1, @R1, @MR1, @GName1, @Class2, @L2, @R2, @MR2, @GName2, @DateTime)
		END
	ELSE
		BEGIN
			DECLARE @GetName1 varchar(10), @GetName2 varchar(10)
			SELECT @GetName1=Name1, @GetName2=Name2 FROM KillLog WHERE (Name1=@Name1 AND Name2=@Name2) OR ( Name1=@Name2 AND Name2=@Name1)

			IF (@GetName1 = @Name1)
				BEGIN
					UPDATE KillLog SET KD1 = KD1 + 1,
						Class1 = @Class1, L1 = @L1, R1 = @R1, MR1 = @MR1, GName1 = @GName1,
						Class2 = @Class2, L2 = @L2, R2 = @R2, MR2 = @MR2, GName2 = @GName2,
						DateTime = @DateTime WHERE Name1 = @Name1 AND Name2 = @Name2
				END
			ELSE
				BEGIN
					UPDATE KillLog SET KD2 = KD2 + 1,
						Class2 = @Class1, L2 = @L1, R2 = @R1, MR2 = @MR1, GName2 = @GName1,
						Class1 = @Class2, L1 = @L2, R1 = @R2, MR1 = @MR2, GName1 = @GName2,
						DateTime = @DateTime WHERE Name2 = @Name1 AND Name1 = @Name2
				END
		END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Claim Reward
CREATE PROCEDURE MSPro_BattlePass_ClaimReward
    @Name VARCHAR(10),
    @Level INT,
    @Track TINYINT
AS
BEGIN
    SET NOCOUNT ON;  -- <-- También aquí
    
    -- Asegurar que existe el registro principal
    IF NOT EXISTS(SELECT 1 FROM BattlePass WHERE Name = @Name)
    BEGIN
        INSERT INTO BattlePass (Name, ExpPoints, CurrentLevel, HasPremium, PremiumExpireDate)
        VALUES (@Name, 0, 0, 0, 0)
    END
    
    -- Insertar la recompensa reclamada si no existe
    IF NOT EXISTS(SELECT 1 FROM BattlePass_Rewards WHERE Name = @Name AND Level = @Level AND Track = @Track)
    BEGIN
        INSERT INTO BattlePass_Rewards (Name, Level, Track)
        VALUES (@Name, @Level, @Track)
    END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE[dbo].[MSPro_BattlePass_Clear]
			AS
			BEGIN
				SET NOCOUNT ON;
				DELETE FROM BattlePass_Rewards
				DELETE FROM BattlePass
			END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Load BattlePass Main Data (solo datos principales)
CREATE PROCEDURE MSPro_BattlePass_Load
    @Name VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT ExpPoints, CurrentLevel, HasPremium, PremiumExpireDate
    FROM BattlePass
    WHERE Name = @Name
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Load BattlePass Rewards (solo recompensas)
CREATE PROCEDURE MSPro_BattlePass_LoadRewards
    @Name VARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Level, Track
    FROM BattlePass_Rewards
    WHERE Name = @Name
    ORDER BY Level ASC, Track ASC
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Save BattlePass Main Data
CREATE PROCEDURE MSPro_BattlePass_Save
    @Name VARCHAR(10),
    @ExpPoints INT,
    @CurrentLevel TINYINT,
    @HasPremium TINYINT,
    @PremiumExpireDate INT
AS
BEGIN
    SET NOCOUNT ON;  -- <-- Esto evita el mensaje de filas afectadas
    
    IF EXISTS(SELECT 1 FROM BattlePass WHERE Name = @Name)
    BEGIN
        UPDATE BattlePass
        SET ExpPoints = @ExpPoints,
            CurrentLevel = @CurrentLevel,
            HasPremium = @HasPremium,
            PremiumExpireDate = @PremiumExpireDate,
            LastUpdate = GETDATE()
        WHERE Name = @Name
    END
    ELSE
    BEGIN
        INSERT INTO BattlePass (Name, ExpPoints, CurrentLevel, HasPremium, PremiumExpireDate)
        VALUES (@Name, @ExpPoints, @CurrentLevel, @HasPremium, @PremiumExpireDate)
    END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CONNECT_MEMB : 
--

CREATE PROCEDURE [dbo].[WZ_CONNECT_MEMB]
@memb___id varchar(10),
@ServerName  varchar(50),
@IP varchar(20)	
 AS
Begin	
set nocount on
	Declare  @find_id varchar(10)	
	Declare  @ConnectStat tinyint
	Set @find_id = 'NOT'
	Set @ConnectStat = 1		-- ?? ?? ? 1 = ??, 0 = ??X

	select @find_id = S.memb___id from MEMB_STAT S INNER JOIN MEMB_INFO I ON S.memb___id = I.memb___id 
	       where I.memb___id = @memb___id

	if( @find_id = 'NOT' )
	begin		
		insert into MEMB_STAT (memb___id,ConnectStat,ServerName,IP,ConnectTM)
		values(@memb___id,  @ConnectStat, @ServerName, @IP, getdate())
	end
	else		
		update MEMB_STAT set ConnectStat = @ConnectStat,
					 ServerName = @ServerName,IP = @IP,
					 ConnectTM = getdate()
       	 where memb___id = @memb___id
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Procedure [dbo].[WZ_CreateCharacter] 
	@AccountID		varchar(10),
	@Name			varchar(10),
	@Class			tinyint	
AS
Begin

	SET NOCOUNT ON
	SET	XACT_ABORT ON
	DECLARE		@Result		tinyint

	SET @Result = 0x00	

	--====================================================================================
	--	Check if Character Name Exists 
	--====================================================================================
	If EXISTS ( SELECT  Name  FROM  Character WHERE Name = @Name )
	begin
		SET @Result	= 0x01					
		GOTO ProcEnd						
	end 

	BEGIN TRAN
	--====================================================================================
	--	Check Account on CharacterList
	--====================================================================================
	If NOT EXISTS ( SELECT  Id  FROM  AccountCharacter WHERE Id = @AccountID )
		begin
			INSERT INTO dbo.AccountCharacter(Id, GameID1, GameID2, GameID3, GameID4, GameID5, GameID6, GameID7, GameID8, GameID9, GameID10, GameIDC) 
			VALUES(@AccountID, @Name, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)

			SET @Result  = @@Error
		end 
	else
		begin
			--====================================================================================
			-- Try to Create Character
			--====================================================================================
			Declare @g1 varchar(10), @g2 varchar(10), @g3 varchar(10), @g4 varchar(10), @g5 varchar(10), @g6 varchar(10), @g7 varchar(10), @g8 varchar(10), @g9 varchar(10), @g10 varchar(10)		
			SELECT @g1=GameID1, @g2=GameID2, @g3=GameID3, @g4=GameID4, @g5=GameID5, @g6=GameID6, @g7=GameID7, @g8=GameID8, @g9=GameID9, @g10=GameID10 FROM dbo.AccountCharacter Where Id = @AccountID 			

			if( ( @g1 Is NULL) OR (Len(@g1) = 0))
				begin
					UPDATE AccountCharacter SET  GameID1 = @Name
					WHERE Id = @AccountID
										
					SET @Result  = @@Error
				end 
			else	 if( @g2  Is NULL OR Len(@g2) = 0)
				begin
					UPDATE AccountCharacter SET  GameID2 = @Name
					WHERE Id = @AccountID

					SET @Result  = @@Error
				end 
			else	 if( @g3  Is NULL OR Len(@g3) = 0)
				begin			
					UPDATE AccountCharacter SET  GameID3 = @Name
					WHERE Id = @AccountID

					SET @Result  = @@Error
				end 
			else	 if( @g4 Is NULL OR Len(@g4) = 0)
				begin
					UPDATE AccountCharacter SET  GameID4 = @Name
					WHERE Id = @AccountID

					SET @Result  = @@Error
				end 
			else	 if( @g5 Is NULL OR Len(@g5) = 0)
				begin
					UPDATE AccountCharacter SET  GameID5 = @Name
					WHERE Id = @AccountID

					SET @Result  = @@Error
				end 	
			else	 if( @g6 Is NULL OR Len(@g6) = 0)
				begin
					UPDATE AccountCharacter SET  GameID6 = @Name
					WHERE Id = @AccountID

					SET @Result  = @@Error
				end	
			else	 if( @g7 Is NULL OR Len(@g7) = 0)
				begin
					UPDATE AccountCharacter SET  GameID7 = @Name
					WHERE Id = @AccountID

					SET @Result  = @@Error
				end
			else	 if( @g8 Is NULL OR Len(@g8) = 0)
				begin
					UPDATE AccountCharacter SET  GameID8 = @Name
					WHERE Id = @AccountID

					SET @Result  = @@Error
				end
			else	 if( @g9 Is NULL OR Len(@g9) = 0)
				begin
					UPDATE AccountCharacter SET  GameID9 = @Name
					WHERE Id = @AccountID

					SET @Result  = @@Error
				end
			else	 if( @g10 Is NULL OR Len(@g10) = 0)
				begin
					UPDATE AccountCharacter SET  GameID10 = @Name
					WHERE Id = @AccountID

					SET @Result  = @@Error
				end
			else 
				--//No Space
				begin					
					SET @Result	= 0x03							
					GOTO TranProcEnd								
				end 			 
		end 

	--====================================================================================
	--	Insert into Character and Select data from DefaultClassType
	--====================================================================================
	if( @Result <> 0 )
		begin
			GOTO TranProcEnd		
		end 
	else
		begin
			INSERT INTO dbo.Character(AccountID, Name, cLevel, LevelUpPoint, Class, Strength, Dexterity, Vitality, Energy, Leadership, Inventory, MagicList, 
					Life, MaxLife, Mana, MaxMana, BP, MaxBP, Shield, MaxShield, MapNumber, MapPosX, MapPosY, MDate, LDate, Quest, DbVersion, EffectList )
			SELECT @AccountID As AccountID, @Name As Name, Level, LevelUpPoint, @Class As Class, 
				Strength, Dexterity, Vitality, Energy, Leadership, Inventory, MagicList, Life, MaxLife, Mana, MaxMana, 0, 0, 0, 0, MapNumber, MapPosX, MapPosY,
				getdate() As MDate, getdate() As LDate, Quest, DbVersion, EffectList
			FROM  DefaultClassType WHERE Class = @Class				

			SET @Result = @@Error
		end 

TranProcEnd:	-- GOTO
	IF ( @Result  <> 0 )
		ROLLBACK TRAN
	ELSE
		COMMIT	TRAN

ProcEnd:
	SET NOCOUNT OFF
	SET	XACT_ABORT OFF


	SELECT
	   CASE @Result
	      WHEN 0x00 THEN 0x01
	      WHEN 0x01 THEN 0x00
	      WHEN 0x03 THEN 0x03
	      ELSE 0x02
	   END AS Result 
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WZ_CreateCharacter_GetVersion]
AS
BEGIN
	SELECT 1
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_CheckSiegeGuildList : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ???????? ??? ????.
--// ??	: MuStudio 
--// ???	: 2005.01.11
--// ???	: 2005.03.15
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_CheckSiegeGuildList]
	@szGuildName		varchar(8)
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	DECLARE @iEnd INT

	SELECT @iEnd = SIEGE_ENDED FROM MuCastle_DATA

	IF @iEnd = 1
	BEGIN
		SELECT 0 As QueryResult
	END
	ELSE IF EXISTS ( SELECT GUILD_NAME FROM MuCastle_SIEGE_GUILDLIST  WITH (READUNCOMMITTED) 
				WHERE GUILD_NAME = @szGuildName)
	BEGIN
		SELECT 1 As QueryResult	
	END
	ELSE
	BEGIN
		IF EXISTS ( SELECT REG_SIEGE_GUILD FROM MuCastle_REG_SIEGE WITH (READUNCOMMITTED) 
				WHERE REG_SIEGE_GUILD = @szGuildName AND IS_GIVEUP = 0)
		BEGIN
			SELECT 1 As QueryResult
		END
		ELSE
		BEGIN
			SELECT 0 As QueryResult	
		END
	END


	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetAllGuildMarkRegInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ??? ??? ???? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetAllGuildMarkRegInfo]
	@iMapSvrGroup		SMALLINT	-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON	

	SELECT TOP 100 * FROM MuCastle_REG_SIEGE WITH (READUNCOMMITTED)
	WHERE MAP_SVR_GROUP = @iMapSvrGroup
	ORDER BY SEQ_NUM DESC

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetCalcRegGuildList : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ?? ???? ?? ??? ???? ???? ???? ?????. (?? N??)
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetCalcRegGuildList]
	@iMapSvrGroup		SMALLINT	-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON	

	DECLARE T_CURSOR CURSOR FAST_FORWARD
	FOR SELECT TOP 100 * FROM MuCastle_REG_SIEGE	WHERE MAP_SVR_GROUP = @iMapSvrGroup AND IS_GIVEUP = 0 ORDER BY SEQ_NUM DESC
	
	OPEN T_CURSOR
	
	DECLARE	@iMapSvrNum			INT
	DECLARE	@szRegGuild			VARCHAR(8)
	DECLARE	@iRegMarks			INT
	DECLARE	@iIsGiveUp			INT
	DECLARE	@iSeqNum			INT

	DECLARE	@iGuildMemberCount		INT
	DECLARE	@iGuildMasterLevel		INT

	CREATE TABLE #T_REG_GUILDLIST  (
		[REG_SIEGE_GUILD] [varchar] (8) NOT NULL ,
		[REG_MARKS] [int] NOT NULL ,
		[GUILD_MEMBER] [int] NOT NULL ,
		[GM_LEVEL] [int] NOT NULL ,
		[SEQ_NUM] [int] NOT NULL 
	) ON [PRIMARY]
	
	FETCH FROM T_CURSOR INTO @iMapSvrNum, @szRegGuild, @iRegMarks, @iIsGiveUp, @iSeqNum
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		IF EXISTS ( SELECT G_Name FROM Guild  WITH (READUNCOMMITTED) WHERE G_Name = @szRegGuild)
		BEGIN
			DECLARE @szGuildMaster	VARCHAR(10)
			SELECT @szGuildMaster = G_Master FROM Guild  WHERE G_Name = @szRegGuild

			IF EXISTS ( SELECT Name FROM Character WITH (READUNCOMMITTED) WHERE Name = @szGuildMaster)
			BEGIN
				-- ???? ?? ??? ????? ???? ???? ??? ???.
				SELECT @iGuildMemberCount = COUNT(*) FROM GuildMember WHERE G_Name = @szRegGuild
				SELECT @iGuildMasterLevel = cLevel FROM Character WHERE Name = @szGuildMaster

				INSERT INTO #T_REG_GUILDLIST VALUES (@szRegGuild, @iRegMarks, @iGuildMemberCount, @iGuildMasterLevel, @iSeqNum)
			END
		END
		
		FETCH FROM T_CURSOR INTO @iMapSvrGroup, @szRegGuild, @iRegMarks, @iIsGiveUp, @iSeqNum
	END
	
	CLOSE T_CURSOR
	
	DEALLOCATE T_CURSOR

	SELECT * FROM #T_REG_GUILDLIST

	DROP TABLE #T_REG_GUILDLIST

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetCastleMoneySts : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ??? ?? ????? ????.
--// ??	: ???? 1? 
--// ???	: 2005.02.22
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetCastleMoneySts]
	@iMapSvrGroup		SMALLINT,		-- ??? ??
	@iTaxDate		DATETIME
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON
	
	DECLARE	@iTaxInc		MONEY
	DECLARE	@iTaxDec		MONEY
	
	DECLARE	@iYEAR		INT
	DECLARE	@iMONTH		INT
	DECLARE	@iDAY			INT
	
	DECLARE	@dtLogDateStart	DATETIME
	DECLARE	@dtLogDateEnd	DATETIME
	
	SELECT	@iYEAR		= DATEPART(YY, @iTaxDate)
	SELECT	@iMONTH		= DATEPART(MM, @iTaxDate)
	SELECT	@iDAY			= DATEPART(DD, @iTaxDate)
	
	SET		@dtLogDateStart	= CAST(@iYEAR AS VARCHAR(4)) + '-' + CAST(@iMONTH AS VARCHAR(2))  + '-' + CAST(@iDAY AS VARCHAR(4)) + ' 00:00:00'
	SET		@dtLogDateEnd	= CAST(@iYEAR AS VARCHAR(4)) + '-' + CAST(@iMONTH AS VARCHAR(2))  + '-' + CAST(@iDAY AS VARCHAR(4)) + ' 23:59:59'
	
	SELECT @iTaxInc = SUM(MONEY_CHANGE) FROM MuCastle_MONEY_STATISTICS  WITH (READUNCOMMITTED) 
	WHERE MAP_SVR_GROUP = 0 and LOG_DATE BETWEEN @dtLogDateStart AND @dtLogDateEnd and MONEY_CHANGE >= 0
	
	SELECT @iTaxDec = SUM(MONEY_CHANGE) FROM MuCastle_MONEY_STATISTICS  WITH (READUNCOMMITTED) 
	WHERE MAP_SVR_GROUP = 0 and LOG_DATE BETWEEN @dtLogDateStart AND @dtLogDateEnd and MONEY_CHANGE < 0
	
	IF @iTaxInc IS NULL
		SET @iTaxInc = 0
	IF @iTaxDec IS NULL
		SET @iTaxDec = 0

	SELECT @dtLogDateStart As TaxDate, @iTaxInc As TaxInc, @iTaxDec As TaxDec

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetCastleMoneyStsRange : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ??? ?? ????? ????.
--// ??	: ???? 1? 
--// ???	: 2005.02.22
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetCastleMoneyStsRange]
	@iMapSvrGroup		SMALLINT,		-- ??? ??
	@iTaxDateStart		DATETIME,
	@iTaxDateEnd		DATETIME
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	CREATE TABLE #T_REG_TAXSTT  (
		[TaxDate] [datetime] NOT NULL ,
		[TaxInc] [money] NOT NULL ,
		[TaxDec] [money] NOT NULL 
	) ON [PRIMARY]
	
	IF (@iTaxDateStart <= @iTaxDateEnd)
	BEGIN
		DECLARE	@iTaxDate		DATETIME
		SET		@iTaxDate		= @iTaxDateStart

		WHILE(@iTaxDate <= @iTaxDateEnd)
		BEGIN
			DECLARE	@dtLogDateStart	DATETIME
			DECLARE	@dtLogDateEnd	DATETIME

			DECLARE	@iTaxInc		MONEY
			DECLARE	@iTaxDec		MONEY
		
			DECLARE	@iYEAR		INT
			DECLARE	@iMONTH		INT
			DECLARE	@iDAY			INT
		
			SELECT	@iYEAR		= DATEPART(YY, @iTaxDate)
			SELECT	@iMONTH		= DATEPART(MM, @iTaxDate)
			SELECT	@iDAY			= DATEPART(DD, @iTaxDate)
			
			SET		@dtLogDateStart	= CAST(@iYEAR AS VARCHAR(4)) + '-' + CAST(@iMONTH AS VARCHAR(2))  + '-' + CAST(@iDAY AS VARCHAR(4)) + ' 00:00:00'
			SET		@dtLogDateEnd	= CAST(@iYEAR AS VARCHAR(4)) + '-' + CAST(@iMONTH AS VARCHAR(2))  + '-' + CAST(@iDAY AS VARCHAR(4)) + ' 23:59:59'
					
			SELECT @iTaxInc = SUM(MONEY_CHANGE) FROM MuCastle_MONEY_STATISTICS  WITH (READUNCOMMITTED) 
			WHERE MAP_SVR_GROUP = 0 and LOG_DATE BETWEEN @dtLogDateStart AND @dtLogDateEnd and MONEY_CHANGE >= 0
			
			SELECT @iTaxDec = SUM(MONEY_CHANGE) FROM MuCastle_MONEY_STATISTICS  WITH (READUNCOMMITTED) 
			WHERE MAP_SVR_GROUP = 0 and LOG_DATE BETWEEN @dtLogDateStart AND @dtLogDateEnd and MONEY_CHANGE < 0

			IF @iTaxInc IS NULL
				SET @iTaxInc = 0
			IF @iTaxDec IS NULL
				SET @iTaxDec = 0
						
			INSERT INTO #T_REG_TAXSTT VALUES (@dtLogDateStart, @iTaxInc, @iTaxDec)

			SET @iTaxDate				= DATEADD(DD, 1, @iTaxDate)
		END
	END
	
	SELECT * FROM #T_REG_TAXSTT

	DROP TABLE #T_REG_TAXSTT

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetCastleNpcInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ??? NPC ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetCastleNpcInfo]
	@iMapSvrGroup		SMALLINT	-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON	

	SELECT * FROM MuCastle_NPC WITH (READUNCOMMITTED)
	WHERE MAP_SVR_GROUP = @iMapSvrGroup

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetCastleTaxInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ????? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetCastleTaxInfo]
	@iMapSvrGroup		SMALLINT	-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON	

	SELECT MONEY, TAX_RATE_CHAOS, TAX_RATE_STORE, TAX_HUNT_ZONE FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
	WHERE MAP_SVR_GROUP = @iMapSvrGroup

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetCastleTotalInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ????? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetCastleTotalInfo]
	@iMapSvrGroup		SMALLINT,			-- ??? ??
	@iCastleEventCycle	INT				-- ??? ??
As
Begin
	DECLARE	@iCastleSiegeTerm			INT
	SET		@iCastleSiegeTerm			= @iCastleEventCycle		-- ??? ?? (?? 14?)
	DECLARE	@iFirstCreate				INT
	SET		@iFirstCreate				= 0
	
	BEGIN TRANSACTION
	
	SET NOCOUNT ON	

	IF NOT EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN
		DECLARE	@dtStartDate			datetime
		DECLARE	@dtEndDate			datetime
		DECLARE	@dtStartDateString		varchar(32)
		DECLARE	@dtEndDateString		varchar(32)

		SET		@dtStartDate			= GetDate()
		SET		@dtEndDate			= DATEADD(dd, @iCastleSiegeTerm, GetDate())
		SET		@dtStartDateString		= CONVERT(datetime, CAST(DATEPART(YY, @dtStartDate) AS char(4)) + '-' + CAST(DATEPART(MM, @dtStartDate) AS char(2)) + '-' + CAST(DATEPART(DD, @dtStartDate) AS char(2)) + ' 00:00:00' ,20)
		SET		@dtEndDateString		= CONVERT(datetime, CAST(DATEPART(YY, @dtEndDate) AS char(4)) + '-' + CAST(DATEPART(MM, @dtEndDate) AS char(2)) + '-' + CAST(DATEPART(DD, @dtEndDate) AS char(2)) + ' 00:00:00' ,20)


		INSERT INTO MuCastle_DATA  VALUES (
			@iMapSvrGroup,			-- MAP_SVR_GROUP
			@dtStartDateString,			-- SIEGE_START_DATE
			@dtEndDateString,			-- SIEGE_END_DATE
			0,					-- SIEGE_GUILDLIST_SETTED
			0,					-- SIEGE_ENDED
			0,					-- CASTLE_OCCUPY
			'',					-- OWNER_GUILD
			0,					-- MONEY
			0,					-- TAX_RATE_CHAOS
			0,					-- TAX_RATE_STORE
			0					-- TAX_HUNT_ZONE
		)

		SET @iFirstCreate				= 1
	END

	SELECT	 MAP_SVR_GROUP, 
			DATEPART(YY,SIEGE_START_DATE)	As SYEAR, 
			DATEPART(MM,SIEGE_START_DATE)	As SMONTH, 
			DATEPART(DD,SIEGE_START_DATE)	As SDAY, 
			DATEPART(YY,SIEGE_END_DATE)	As EYEAR, 
			DATEPART(MM,SIEGE_END_DATE)	As EMONTH, 
			DATEPART(DD,SIEGE_END_DATE)	As EDAY, 
			SIEGE_GUILDLIST_SETTED, 
			SIEGE_ENDED, 
			CASTLE_OCCUPY, 
			OWNER_GUILD, 
			MONEY, 
			TAX_RATE_CHAOS,
			TAX_RATE_STORE,
			TAX_HUNT_ZONE,
			@iFirstCreate As FIRST_CREATE
	FROM MuCastle_DATA  WITH (READUNCOMMITTED)
	WHERE MAP_SVR_GROUP = @iMapSvrGroup

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetCsGuildUnionInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ??? ????? ???? ????.
--// ??	: ???? 1? 
--// ???	: 2004.12.03
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetCsGuildUnionInfo]
	@szGuildName		VARCHAR(8)	-- ????? ??? ?? ???
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	DECLARE	@iG_Union	INT
	SET		@iG_Union	= -1	-- ??? ? ?? ????? ????
	
	IF EXISTS ( SELECT G_Name FROM Guild  WITH (READUNCOMMITTED) 
				WHERE G_Name = @szGuildName)
	BEGIN				-- ?? ??? ??? ????.
		SELECT @iG_Union = G_Union
		FROM Guild WITH (READUNCOMMITTED) 
		WHERE G_Name = @szGuildName
	END

	-- ?? ??? ???? ???? ????.
	IF (@iG_Union = 0)
	BEGIN
		SELECT @szGuildName As GUILD_NAME
	END
	ELSE
	BEGIN
		-- ??? ????? ??? ????? ????.
		SELECT G_Name As GUILD_NAME
		FROM Guild WITH (READUNCOMMITTED) 
		WHERE G_Union = @iG_Union
	END
	
	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetGuildMarkRegInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ??? ??? ???? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetGuildMarkRegInfo]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@szGuildName		VARCHAR(8)	-- ????? ? ????
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON	

	SELECT * FROM MuCastle_REG_SIEGE WITH (READUNCOMMITTED)
	WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName
	ORDER BY SEQ_NUM ASC

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetOwnerGuildMaster : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ??? ??? ????? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.22
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetOwnerGuildMaster]
	@iMapSvrGroup		SMALLINT	-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON	

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN				-- ????? ??? ????.
		DECLARE	@iIsCastleOccupied	TINYINT
		DECLARE	@szGuildName		VARCHAR(8)

		SELECT @iIsCastleOccupied = CASTLE_OCCUPY, @szGuildName = OWNER_GUILD FROM MuCastle_DATA WHERE MAP_SVR_GROUP = @iMapSvrGroup

		IF (@iIsCastleOccupied = 1)
		BEGIN
			IF (@szGuildName <> '')			
			BEGIN		-- ?? ??? ??? ????? ????.
				IF EXISTS ( SELECT G_Master FROM Guild  WITH (READUNCOMMITTED)
							WHERE G_Name = @szGuildName)
				BEGIN
					SELECT 1 As QueryResult, @szGuildName As OwnerGuild, G_Master As OwnerGuildMaster FROM Guild  WITH (READUNCOMMITTED) WHERE G_Name = @szGuildName
				END
				ELSE
				BEGIN	-- ???? ? ??? ???? ???. (??? ???? ?)
					SELECT 4 As QueryResult, '' As OwnerGuild, '' As OwnerGuildMaster
				END
			END
			ELSE
			BEGIN		-- ????? ?????.
				SELECT 3 As QueryResult, '' As OwnerGuild, '' As OwnerGuildMaster
			END
		END
		ELSE
		BEGIN			-- ?? ??? ??.
			SELECT 2 As QueryResult, '' As OwnerGuild, '' As OwnerGuildMaster
		END
	END
	ELSE
	BEGIN				-- ????? ??? ???? ???.
		SELECT 0 As QueryResult, '' As OwnerGuild, '' As OwnerGuildMaster
	END


	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_GetSiegeGuildInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ???? ???? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.12.04
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_GetSiegeGuildInfo]
	@iMapSvrGroup		SMALLINT	-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	SELECT * 
	FROM MuCastle_SIEGE_GUILDLIST  WITH (READUNCOMMITTED) 
	WHERE MAP_SVR_GROUP = @iMapSvrGroup

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ModifyCastleOwnerInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ??? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ModifyCastleOwnerInfo]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@iCastleOccupied	INT,		-- ?? ??? ???? (0:NPC ??)
	@szOwnGuildName	VARCHAR(8)	-- ?? ??? ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN
		UPDATE MuCastle_DATA 
		SET CASTLE_OCCUPY = @iCastleOccupied, OWNER_GUILD = @szOwnGuildName
		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		SELECT 1 As QueryResult	-- ????? ??? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult	-- ????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ModifyCastleSchedule : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ????? (????, ????) ? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ModifyCastleSchedule]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@dtStartDate		DATETIME,	-- ????
	@dtEndDate		DATETIME	-- ????
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN
		UPDATE MuCastle_DATA 
		SET SIEGE_START_DATE = CONVERT(datetime,@dtStartDate,20), SIEGE_END_DATE = CONVERT(datetime,@dtEndDate,20)
		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		SELECT 1 As QueryResult	-- ????? ??? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult	-- ????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ModifyGuildGiveUp : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ??? ????? ?? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ModifyGuildGiveUp]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@szGuildName		VARCHAR(8),	-- ????? ? ????
	@iIsGiveUp		INT		-- ?? ?? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_REG_SIEGE  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName)
	BEGIN
		DECLARE	@iMarkCount	INT
		SELECT @iMarkCount = REG_MARKS FROM MuCastle_REG_SIEGE  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName

		UPDATE MuCastle_REG_SIEGE 
		SET IS_GIVEUP = @iIsGiveUp, REG_MARKS = 0
		WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName

		SELECT 1 As QueryResult, @iMarkCount As DEL_MARKS	-- ????? ??? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 2 As QueryResult, 0 As DEL_MARKS			-- ????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ModifyGuildMarkRegCount : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ??? ???? ????? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ModifyGuildMarkRegCount]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@szGuildName		VARCHAR(8),	-- ????? ? ????
	@iMarkCount		INT		-- ???? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_REG_SIEGE  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName)
	BEGIN
		UPDATE MuCastle_REG_SIEGE 
		SET REG_MARKS = @iMarkCount
		WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName

		SELECT 1 As QueryResult	-- ????? ??? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult	--????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ModifyGuildMarkReset : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ??? ???? ????? ??? ??.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ModifyGuildMarkReset]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@szGuildName		VARCHAR(8)	-- ????? ? ????
As
Begin
	BEGIN TRANSACTION

	DECLARE		@iMarkCount	INT	-- ???? ??
	DECLARE		@bIsGiveUp	INT	-- ?? ????

	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_REG_SIEGE  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName)
	BEGIN
		SELECT @iMarkCount = REG_MARKS, @bIsGiveUp = IS_GIVEUP
		FROM MuCastle_REG_SIEGE
		WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName

		IF (@iMarkCount > 0)
		BEGIN
			IF (@bIsGiveUp = 0)
			BEGIN
				UPDATE MuCastle_REG_SIEGE 
				SET REG_MARKS = 0
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName
		
				SELECT 1 As QueryResult, @iMarkCount As DEL_MARKS	--????? ??? ?? ??? ??? ??? ??.
			END
			ELSE
			BEGIN
				SELECT 2 As QueryResult, 0 As DEL_MARKS			--?? ??? ?????. (?? -> ?? ?)
			END
		END
		ELSE
		BEGIN
			SELECT 1 As QueryResult, 0 As DEL_MARKS				--??? ???? ???? ?? ??? ???? ??
		END
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult, 0 As DEL_MARKS					--????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ModifyMoney : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ModifyMoney]
	@iMapSvrGroup		SMALLINT,			-- ??? ??
	@iMoneyChange	MONEY				-- ????? ??? ?
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN
		DECLARE	@iTotMoney	MONEY
		SELECT @iTotMoney = MONEY FROM MuCastle_DATA
		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		IF (@iTotMoney + @iMoneyChange < 0)
		BEGIN
			SELECT 2 As QueryResult, MONEY	--  ?? ?? ?? ??? ?? ???? ???? ???.
			FROM MuCastle_DATA
			WHERE MAP_SVR_GROUP = @iMapSvrGroup		
		END
		ELSE
		BEGIN
			UPDATE MuCastle_DATA 
			SET MONEY = @iTotMoney + @iMoneyChange
			WHERE MAP_SVR_GROUP = @iMapSvrGroup
	
			SELECT 1 As QueryResult, MONEY	-- ????? ??? ???? ??? ? ??? ???? ????? ????.
			FROM MuCastle_DATA
			WHERE MAP_SVR_GROUP = @iMapSvrGroup		
		END

		-- ?? ?? ????? ?? ???? ? ??? ?? ??
		INSERT MuCastle_MONEY_STATISTICS VALUES (@iMapSvrGroup, GetDate(), @iMoneyChange)
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult, 0 As MONEY		-- ????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ModifySiegeEnd : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ?? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ModifySiegeEnd]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@iSiegeEnded		INT		-- ?? ?? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN
		UPDATE MuCastle_DATA 
		SET SIEGE_ENDED = @iSiegeEnded
		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		SELECT 1 As QueryResult	-- ????? ??? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult	-- ????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ModifyTaxRate : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ModifyTaxRate]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@iTaxKind		INT,		-- ??? ?? (1:????? / 2:??)
	@iTaxRate		INT		-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF (@iTaxKind = 1)			-- ??? ?? ????
	BEGIN
		IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
					WHERE MAP_SVR_GROUP = @iMapSvrGroup)
		BEGIN
			UPDATE MuCastle_DATA 
			SET TAX_RATE_CHAOS = @iTaxRate
			WHERE MAP_SVR_GROUP = @iMapSvrGroup
	
			SELECT @iTaxKind As TaxKind, 1 As QueryResult, TAX_RATE_CHAOS As TaxRate	-- ????? ??? ???? ????? ????.
			FROM MuCastle_DATA
			WHERE MAP_SVR_GROUP = @iMapSvrGroup
		END
		ELSE
		BEGIN
			SELECT @iTaxKind As TaxKind, 0 As QueryResult, 0 As TaxRate				-- ????? ??? ???? ???? ????? ????.
		END
	END
	ELSE IF (@iTaxKind = 2)			-- ?? ?? ??
	BEGIN
		IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
					WHERE MAP_SVR_GROUP = @iMapSvrGroup)
		BEGIN
			UPDATE MuCastle_DATA 
			SET TAX_RATE_STORE = @iTaxRate
			WHERE MAP_SVR_GROUP = @iMapSvrGroup
	
			SELECT @iTaxKind As TaxKind, 1 As QueryResult, TAX_RATE_STORE As TaxRate	-- ????? ??? ???? ????? ????.
			FROM MuCastle_DATA
			WHERE MAP_SVR_GROUP = @iMapSvrGroup
		END
		ELSE
		BEGIN
			SELECT @iTaxKind As TaxKind, 0 As QueryResult, 0 As TaxRate				-- ????? ??? ???? ???? ????? ????.
		END
	END
	ELSE IF (@iTaxKind = 3)			-- ??? ??? ?? ??
	BEGIN
		IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
					WHERE MAP_SVR_GROUP = @iMapSvrGroup)
		BEGIN
			UPDATE MuCastle_DATA 
			SET TAX_HUNT_ZONE = @iTaxRate
			WHERE MAP_SVR_GROUP = @iMapSvrGroup
	
			SELECT @iTaxKind As TaxKind, 1 As QueryResult, TAX_HUNT_ZONE As TaxRate	-- ????? ??? ???? ????? ????.
			FROM MuCastle_DATA
			WHERE MAP_SVR_GROUP = @iMapSvrGroup
		END
		ELSE
		BEGIN
			SELECT @iTaxKind As TaxKind, 0 As QueryResult, 0 As TaxRate				-- ????? ??? ???? ???? ????? ????.
		END
	END
	ELSE
	BEGIN
		SELECT @iTaxKind As TaxKind, 0 As QueryResult, 0 As TaxRate					-- ????? ???? ???.
	END


	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ReqNpcBuy : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ??? NPC? ????. (NPC ??? ????.)
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ReqNpcBuy]
	@iMapSvrGroup		SMALLINT,		-- ??? ??
	@iNpcNumber		INT,			-- NPC??
	@iNpcIndex		INT,			-- NPC???
	@iNpcDfLevel		INT,			-- ??? ??
	@iNpcRgLevel		INT,			-- ???? ??
	@iNpcMaxHp		INT,			-- ?? HP
	@iNpcHp		INT,			-- HP
	@btNpcX		TINYINT,		-- ?? - X
	@btNpcY		TINYINT,		-- ?? - Y
	@btNpcDIR		TINYINT		-- ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_NPC  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex)
	BEGIN
		SELECT 4 As QueryResult		-- ?? NPC? ?? ???? ??.
	END
	ELSE
	BEGIN
		INSERT INTO MuCastle_NPC VALUES (
			@iMapSvrGroup	,		-- MAP_SVR_GROUP
			@iNpcNumber,			-- NPC_NUMBER
			@iNpcIndex,			-- NPC_INDEX
			@iNpcDfLevel,			-- NPC_DF_LEVEL
			@iNpcRgLevel,			-- NPC_RG_LEVEL
			@iNpcMaxHp,			-- NPC_MAXHP
			@iNpcHp,			-- NPC_HP
			@btNpcX,			-- NPC_X
			@btNpcY,			-- NPC_Y
			@btNpcDIR,			-- NPC_DIR
			GetDate()			-- NPC_CREATEDATE
		)
		
		SELECT 1 As QueryResult		-- NPC?? ??
	END



	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ReqNpcRemove : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ??? NPC? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.26
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ReqNpcRemove]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@iNpcNumber		INT,		-- NPC??
	@iNpcIndex		INT		-- NPC???
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_NPC  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex)
	BEGIN
		DELETE MuCastle_NPC
		WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex

		SELECT 1 As QueryResult	-- NPC? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 2 As QueryResult	-- NPC? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ReqNpcRepair : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ??? NPC? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ReqNpcRepair]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@iNpcNumber		INT,		-- NPC??
	@iNpcIndex		INT		-- NPC???
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_NPC  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex)
	BEGIN
		UPDATE MuCastle_NPC 
		SET  NPC_HP = NPC_MAXHP
		WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex

		SELECT 1 As QueryResult, NPC_HP, NPC_MAXHP		-- NPC? ???? ????? ????.
		FROM MuCastle_NPC  WITH (READUNCOMMITTED) 
		WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex
	END
	ELSE
	BEGIN
		SELECT 2 As QueryResult, 0 As NPC_HP, 0 As NPC_MAXHP	-- NPC? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ReqNpcUpdate : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ??? NPC ??? ???? -> NPC ??? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.12.15
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ReqNpcUpdate]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@iNpcNumber		INT,		-- NPC??
	@iNpcIndex		INT,		-- NPC???
	@iNpcDfLevel		INT,		-- ??? ??
	@iNpcRgLevel		INT,		-- ???? ??
	@iNpcMaxHp		INT,		-- ?? HP
	@iNpcHp		INT,		-- HP
	@btNpcX		TINYINT,	-- ?? - X
	@btNpcY		TINYINT,	-- ?? - Y
	@btNpcDIR		TINYINT	-- ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_NPC  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex)
	BEGIN
		-- ?? NPC? ???? -> ?? ??
		
		UPDATE MuCastle_NPC
		SET	NPC_NUMBER		= @iNpcNumber, 
			NPC_INDEX		= @iNpcIndex, 
			NPC_DF_LEVEL	= @iNpcDfLevel, 
			NPC_RG_LEVEL	= @iNpcRgLevel, 
			NPC_MAXHP		= @iNpcMaxHp, 
			NPC_HP		= @iNpcHp,
			NPC_X			= @btNpcX,
			NPC_Y			= @btNpcY, 
			NPC_DIR		= @btNpcDIR
		WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex
	END
	ELSE
	BEGIN
		-- ?? NPC? ???? ??? -> ?? ??

		INSERT INTO MuCastle_NPC VALUES (
			@iMapSvrGroup	,	-- MAP_SVR_GROUP
			@iNpcNumber,		-- NPC_NUMBER
			@iNpcIndex,		-- NPC_INDEX
			@iNpcDfLevel,		-- NPC_DF_LEVEL
			@iNpcRgLevel,		-- NPC_RG_LEVEL
			@iNpcMaxHp,		-- NPC_MAXHP
			@iNpcHp,		-- NPC_HP
			@btNpcX,		-- NPC_X
			@btNpcY,		-- NPC_Y
			@btNpcDIR,		-- NPC_DIR
			GetDate()		-- NPC_CREATEDATE
		)
	END



	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ReqNpcUpgrade : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ??? NPC? ????? ??.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ReqNpcUpgrade]
	@iMapSvrGroup		SMALLINT,		-- ??? ??
	@iNpcNumber		INT,			-- NPC??
	@iNpcIndex		INT,			-- NPC???
	@iNpcUpType		INT,			-- NPC????? ?? (1:???/2:???/3:??HP)
	@iNpcUpValue		INT			-- NPC????? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_NPC  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex)
	BEGIN
		IF (@iNpcUpType = 1)			-- ???
		BEGIN
			UPDATE MuCastle_NPC 
			SET NPC_DF_LEVEL = @iNpcUpValue
			WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex
	
			SELECT 1 As QueryResult	-- NPC? ???? ????? ????.
		END
		ELSE IF (@iNpcUpType = 2) 		-- ???
		BEGIN
			UPDATE MuCastle_NPC 
			SET NPC_RG_LEVEL = @iNpcUpValue
			WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex
	
			SELECT 1 As QueryResult	-- NPC? ???? ????? ????.
		END
		ELSE IF (@iNpcUpType = 3) 		-- ??HP
		BEGIN
			UPDATE MuCastle_NPC 
			SET NPC_MAXHP = @iNpcUpValue, NPC_HP = @iNpcUpValue
			WHERE MAP_SVR_GROUP = @iMapSvrGroup and NPC_NUMBER = @iNpcNumber and NPC_INDEX = @iNpcIndex
	
			SELECT 1 As QueryResult	-- NPC? ???? ????? ????.
		END
		ELSE
		BEGIN
			SELECT 2 As QueryResult	-- ????? ??? ?????.
		END
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult		-- NPC? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ReqRegAttackGuild : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ???? ??? ??? ??? ??.
--// ??	: ???? 1? 
--// ???	: 2004.11.22
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ReqRegAttackGuild]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@szGuildName		VARCHAR(8)	-- ????? ? ????
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	DECLARE	@iMaxRegGuildCount	INT					-- ??? ?? ??? ? ?? ?? ?
	DECLARE	@iCurRegGuildCount	INT					-- ?? ??? ??? ?? ?
	SET 		@iMaxRegGuildCount	= 100

	SELECT @iCurRegGuildCount = COUNT(*) FROM MuCastle_REG_SIEGE  WITH (READUNCOMMITTED)  WHERE MAP_SVR_GROUP = @iMapSvrGroup
	IF (@iCurRegGuildCount >= @iMaxRegGuildCount)
	BEGIN
			SELECT 6 As QueryResult					-- ??? ??? ?? N?? ???
	END
	ELSE
	BEGIN
		IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_REG_SIEGE  WITH (READUNCOMMITTED) 
					WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName)
		BEGIN
			SELECT 2 As QueryResult					-- ?? ???? ??
		END
		ELSE
		BEGIN
			DECLARE @szOwnGuildName		VARCHAR(8)
			SELECT @szOwnGuildName = OWNER_GUILD FROM MuCastle_DATA WHERE MAP_SVR_GROUP = @iMapSvrGroup
	
			-- ?? ??? ??? ??? ??
			IF (@szOwnGuildName = @szGuildName)
			BEGIN
				SELECT 3 As QueryResult				-- ??? ???
			END
			ELSE
			BEGIN
				IF NOT EXISTS ( SELECT G_Name FROM Guild  WITH (READUNCOMMITTED) WHERE G_Name = @szGuildName)
				BEGIN
					SELECT 4 As QueryResult			-- ????? ???? ??
				END
				ELSE
				BEGIN
					DECLARE @szGuildMaster			VARCHAR(10)
					DECLARE @iGuildMasterLevel			INT
					DECLARE @iGuildMemberCount			INT
					
					SELECT @szGuildMaster = G_Master FROM Guild WHERE G_Name = @szGuildName
					SELECT @iGuildMasterLevel = cLevel FROM Character WHERE Name = @szGuildMaster
					SELECT @iGuildMemberCount = COUNT(*) FROM GuildMember WHERE G_Name = @szGuildName
					
					IF (@iGuildMasterLevel <1)
					BEGIN
						SELECT 5 As QueryResult		-- ?????? ??? ??
					END
					ELSE
					BEGIN
						IF (@iGuildMemberCount <1)
						BEGIN
							SELECT 8 As QueryResult	-- ??? ?? ??
						END
						ELSE
						BEGIN
							DECLARE @iMAX_SEQNUM	INT	-- ?? ?? ????
							DECLARE @iNXT_SEQNUM	INT	-- ?? ????
							SELECT @iMAX_SEQNUM = MAX(SEQ_NUM) FROM MuCastle_REG_SIEGE  WITH (READUNCOMMITTED)  WHERE MAP_SVR_GROUP = @iMapSvrGroup
							
							IF (@iMAX_SEQNUM IS NULL)
								SET @iNXT_SEQNUM	= 1
							ELSE
								SET @iNXT_SEQNUM	= @iMAX_SEQNUM + 1

							INSERT INTO MuCastle_REG_SIEGE 
							VALUES (@iMapSvrGroup, @szGuildName, 0, 0, @iNXT_SEQNUM)
					
							SELECT 1 As QueryResult	-- ?? ??
						END
					END
				END
			END
		END
	END

	
	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ReqRegGuildMark : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ???? ??? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ReqRegGuildMark]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@szGuildName		VARCHAR(8)	-- ????? ? ????
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_REG_SIEGE  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName)
	BEGIN
		DECLARE	@bIS_GIVEUP	INT
		SELECT @bIS_GIVEUP = IS_GIVEUP FROM MuCastle_REG_SIEGE  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName

		-- ???? ??? ??? ?? ???.
		IF (@bIS_GIVEUP = 0)
		BEGIN
			UPDATE MuCastle_REG_SIEGE 
			SET REG_MARKS = REG_MARKS + 1
			WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName
	
			SELECT 1 As QueryResult, REG_MARKS
			FROM MuCastle_REG_SIEGE  WITH (READUNCOMMITTED)
			WHERE MAP_SVR_GROUP = @iMapSvrGroup and REG_SIEGE_GUILD = @szGuildName
		END
		ELSE
		BEGIN
			SELECT 0 As QueryResult, 0 As REG_MARKS
		END
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult, 0 As REG_MARKS
	END


	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ResetCastleSiege : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ????? ????? (?? ??? ??? ?)
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ResetCastleSiege]
	@iMapSvrGroup		SMALLINT	-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN
		-- 1 . ?? ??? ???? ??? ???? ??? ??.
		UPDATE MuCastle_DATA 
		SET 	SIEGE_GUILDLIST_SETTED = 0,
			SIEGE_ENDED = 0
		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		-- 2 . ?? ???? ??? ??? ??.
		-- ???? ?? ??? ?? ? ??? ??? ? ??? ??? ?? -> ???? ?? ? ?? ??
--		DELETE MuCastle_REG_SIEGE
--		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		--DBCC CHECKIDENT ('MuCastle_REG_SIEGE', RESEED, 0)

		-- 3 . ???? ????? ??? ??? ??.
		DELETE MuCastle_SIEGE_GUILDLIST
		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		SELECT 1 As QueryResult	-- ????? ??? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult	-- ????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ResetCastleTaxInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ??? ??? ??.
--// ??	: ???? 1? 
--// ???	: 2004.12.21
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ResetCastleTaxInfo]
	@iMapSvrGroup		SMALLINT			-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN
		UPDATE MuCastle_DATA 
		SET MONEY = 0, TAX_RATE_CHAOS = 0, TAX_RATE_STORE = 0, TAX_HUNT_ZONE = 0
		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		SELECT 1 As QueryResult			-- ????? ??? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult			-- ????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ResetRegSiegeInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ???? ?? ???? ??? ??.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ResetRegSiegeInfo]
	@iMapSvrGroup		SMALLINT	-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN
		-- ???? ????? ??? ??? ??.
		DELETE MuCastle_REG_SIEGE
		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		SELECT 1 As QueryResult	-- ????? ??? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult	-- ????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_ResetSiegeGuildInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ???? ???? ??? ??.
--// ??	: ???? 1? 
--// ???	: 2004.11.09
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_ResetSiegeGuildInfo]
	@iMapSvrGroup		SMALLINT	-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN
		-- ???? ????? ??? ??? ??.
		DELETE MuCastle_SIEGE_GUILDLIST
		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		SELECT 1 As QueryResult	-- ????? ??? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult	-- ????? ??? ???? ???? ????? ????.
	END

	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_SetSiegeGuildInfo : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ???? ???? ??? ????.
--// ??	: ???? 1? 
--// ???	: 2004.12.04
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_SetSiegeGuildInfo]
	@iMapSvrGroup		SMALLINT,	-- ??? ??
	@szGuildName		VARCHAR(8),	-- ????? ? ????
	@iGuildID		INT,		-- ?/?? ?? ??? ?
	@iGuildInvolved		INT,		-- ??? ?? ??? ????? ?
	@iGuildScore		INT
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	INSERT INTO MuCastle_SIEGE_GUILDLIST
	VALUES (@iMapSvrGroup, @szGuildName, @iGuildID, @iGuildInvolved, @iGuildScore)
	
	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_CS_SetSiegeGuildOK : 
--

--//************************************************************************
--// << ? ??? - ?? ???? >>
--// 
--// ??	: ?? ? (????) ? ?? ???? ???? ??? ????? ????? ??? ??.
--// ??	: ???? 1? 
--// ???	: 2004.12.04
--// ???	: ???
--// 
--//************************************************************************

CREATE PROCEDURE	[dbo].[WZ_CS_SetSiegeGuildOK]
	@iMapSvrGroup		SMALLINT	-- ??? ??
As
Begin
	BEGIN TRANSACTION
	
	SET NOCOUNT ON

	IF EXISTS ( SELECT MAP_SVR_GROUP FROM MuCastle_DATA  WITH (READUNCOMMITTED) 
				WHERE MAP_SVR_GROUP = @iMapSvrGroup)
	BEGIN					-- ????? ??? ????.
		UPDATE MuCastle_DATA
		SET SIEGE_GUILDLIST_SETTED = 1
		WHERE MAP_SVR_GROUP = @iMapSvrGroup

		SELECT 1 As QueryResult	-- ????? ??? ???? ????? ????.
	END
	ELSE
	BEGIN
		SELECT 0 As QueryResult	-- ????? ??? ???? ???? ????? ????.
	END

	
	IF(@@Error <> 0 )
		ROLLBACK TRANSACTION
	ELSE	
		COMMIT TRANSACTION

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_CustomArenaRanking] 
@Account varchar(10),
@Name varchar(10),
@ArenaNumber int,
@UserScore int,
@UserRank int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

IF(@ArenaNumber = 0)
BEGIN

IF(@UserRank = 1)
BEGIN

UPDATE CashShopData SET GoblinPoint=GoblinPoint WHERE AccountID=@Account

END

END

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_CustomMonsterReward] 
@Account varchar(10),
@Name varchar(10),
@MonsterClass int,
@MapNumber int,
@RewardValue1 int,
@RewardValue2 int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

IF NOT EXISTS (SELECT Name FROM MonstersCount WHERE Name=@Name AND MonsterID=@MonsterClass)
BEGIN

	 INSERT INTO MonstersCount (Name, MonsterID, KillCount) VALUES (@Name, @MonsterClass, 1)
END
ELSE
BEGIN

	UPDATE MonstersCount SET KillCount=KillCount+1 WHERE Name=@Name AND MonsterID=@MonsterClass

END

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE	[dbo].[WZ_CustomRanking]
	@type		SMALLINT
As
Begin
	
	SET NOCOUNT ON	

	IF @type = 0 
	BEGIN
			Select top 10 name as VALUE1, masterresetcount as VALUE2 from Character order by MasterResetCount desc, ResetCount desc
	END
	
	IF @type = 1 
	BEGIN
			Select top 10 name as VALUE1, resetcount as VALUE2 from Character order by ResetCount desc, cLevel desc
	END
	
	IF @type = 2 
	BEGIN
			Select top 10 name as VALUE1, cLevel as VALUE2 from Character order by cLevel desc
	END
	
	IF @type = 3 
	BEGIN
			Select top 10 name as VALUE1, Score as VALUE2 from RankingBloodCastle order by Score desc
	END
	
	IF @type = 4 
	BEGIN
			Select top 10 name as VALUE1, Score as VALUE2 from RankingDevilSquare order by Score desc
	END
	
	
	--WAITFOR DELAY '00:00:02';

	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE	[dbo].[WZ_CustomTop]
	@type		SMALLINT,
	@class		SMALLINT
As
Begin
	
	SET NOCOUNT ON	

	IF @type = 1 
	BEGIN
		IF @class < 0
			Select top 5 name as VALUE1, resetcount as VALUE2 from Character order by ResetCount desc
		ELSE
			Select top 5 name as VALUE1, resetcount as VALUE2 from Character where Class >= @class and Class <= @class+2 order by ResetCount desc
	END
	
	IF @type = 2 
	BEGIN
		IF @class < 0
			Select top 5 name as VALUE1, masterresetcount as VALUE2 from Character order by masterResetCount desc,ResetCount desc
		ELSE
			Select top 5 name as VALUE1, masterresetcount as VALUE2 from Character where Class >= @class and Class <= @class+2 order by masterResetCount desc,ResetCount desc
	END



	SET NOCOUNT OFF	
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WZ_CW_InfoLoad]

@MapServerGroup int
AS
Begin
set nocount on

SELECT CRYWOLF_OCCUFY, CRYWOLF_STATE FROM WZ_CW_INFO
WHERE MAP_SVR_GROUP=@MapServerGroup

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[WZ_CW_InfoSave]

@iMapServerGroup int,
@iState int,
@iOccupy int

AS
Begin
set nocount on

UPDATE WZ_CW_INFO
SET CRYWOLF_OCCUFY=@iOccupy, CRYWOLF_STATE=@iState
WHERE MAP_SVR_GROUP=@iMapServerGroup

end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_DeleteCharacter] 
@Account varchar(10),
@Name varchar(10)
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @Result tinyint
SET @Result = 0

BEGIN
    -- Passed all checks, proceed with deletion
    SET @Result = 1
    
    -- Delete from all relevant tables
    DELETE FROM Character WHERE AccountID = @Account AND Name = @Name
    DELETE FROM OptionData WHERE Name = @Name
    DELETE FROM QuestKillCount WHERE Name = @Name
    DELETE FROM MasterSkillTree WHERE Name = @Name
    DELETE FROM EventLeoTheHelper WHERE Name = @Name
    DELETE FROM EventSantaClaus WHERE Name = @Name
    DELETE FROM QuestWorld WHERE Name = @Name
    DELETE FROM Gens_Rank WHERE Name = @Name
    DELETE FROM Gens_Reward WHERE Name = @Name
    DELETE FROM RankingDuel WHERE Name = @Name
    DELETE FROM RankingBloodCastle WHERE Name = @Name
    DELETE FROM RankingChaosCastle WHERE Name = @Name
    DELETE FROM RankingDevilSquare WHERE Name = @Name
    DELETE FROM RankingIllusionTemple WHERE Name = @Name
    DELETE FROM HelperData WHERE Name = @Name
    DELETE FROM RankingKingPlayer WHERE Name = @Name
    
    -- MSPro V10
    DELETE FROM XTR_PenaltyData WHERE Name = @Name
    DELETE FROM XTR_PetInventory WHERE Name = @Name
    DELETE FROM XTR_QuestInfo WHERE Name = @Name
    DELETE FROM XTR_EventEnterCount WHERE Name = @Name 
    DELETE FROM XTR_PlayerDieLog WHERE Player1 = @Name 
    DELETE FROM XTR_PlayerDieLog WHERE Player2 = @Name 
    DELETE FROM Marry WHERE Name1 = @Name OR Name2 = @Name
    
    -- V11
    DELETE FROM FlagSystem WHERE Name = @Name
    DELETE FROM ResetSystem WHERE Name = @Name
    
    -- V13
    DELETE FROM KillLog WHERE Name1 = @Name OR Name2 = @Name
    DELETE FROM GremoryCase WHERE Type = 0 AND Name = @Name
    DELETE FROM FlagSystem WHERE Name = @Name
    DELETE FROM AutoAddStats WHERE Name = @Name
    
    -- V14
    DELETE FROM DailyBonus WHERE Name = @Name
    DELETE FROM FortuneWheel WHERE Name = @Name
    
    -- V15
    DELETE FROM ItemMarket WHERE Name = @Name
END

-- Return the result
SELECT @Result

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WZ_DeleteCharacter_Extended]
				@Account varchar(10),
				@Name varchar(10)
			AS
			BEGIN
				SET NOCOUNT ON;

				DECLARE @Result tinyint;

				-- Ejecutar el SP original y capturar su resultado
				DECLARE @Tmp TABLE(Result tinyint);
				INSERT INTO @Tmp EXEC WZ_DeleteCharacter @Account, @Name;
				SELECT @Result = Result FROM @Tmp;

				IF (@Result = 1)
				BEGIN
					-- Eliminaciones extendidas (solo si el delete original fue exitoso)
					DELETE FROM XTR_PenaltyData     WHERE Name = @Name;
					DELETE FROM XTR_PetInventory    WHERE Name = @Name;
					DELETE FROM XTR_QuestInfo       WHERE Name = @Name;
					DELETE FROM XTR_EventEnterCount WHERE Name = @Name;
					DELETE FROM XTR_PlayerDieLog    WHERE Player1 = @Name OR Player2 = @Name;
					DELETE FROM Marry               WHERE Name1 = @Name OR Name2 = @Name;
					DELETE FROM FlagSystem          WHERE Name = @Name;
					DELETE FROM ResetSystem         WHERE Name = @Name;
					DELETE FROM KillLog             WHERE Name1 = @Name OR Name2 = @Name;
					DELETE FROM GremoryCase         WHERE Type = 0 AND Name = @Name;
					DELETE FROM AutoAddStats        WHERE Name = @Name;
					DELETE FROM DailyBonus          WHERE Name = @Name;
					DELETE FROM FortuneWheel        WHERE Name = @Name;
					DELETE FROM ItemMarket          WHERE Name = @Name;
				END

				SELECT @Result AS Result;
			END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_DelMail : 
--

CREATE procedure [dbo].[WZ_DelMail]
	@Name varchar(10),  @MemoIndex int
as 

BEGIN
	DECLARE @ErrorCode int
	DECLARE @UserGuid  int

	SET	XACT_ABORT ON
	Set	nocount on 	

	SET @ErrorCode = 0

	-- Name GUID? ??????
	if NOT EXISTS ( select GUID FROM T_FriendMain where Name=@Name)
	  BEGIN
		SET @ErrorCode = 2
		GOTO EndProc

	  END
	else
	  BEGIN
		select @UserGuid = GUID FROM T_FriendMain where Name=@Name
	
		IF ( @@Error  <> 0   )
		begin
			SET @ErrorCode = 3
			GOTO EndProc
		end
	
	  END

	if NOT EXISTS ( select MemoIndex FROM T_FriendMail  where MemoIndex=@MemoIndex AND GUID=@UserGuid)
	  BEGIN
		SET @ErrorCode = 4
		GOTO EndProc
	  END

	BEGIN TRAN

	-- ??? ?????.
	DELETE FROM T_FriendMail where MemoIndex=@MemoIndex AND GUID=@UserGuid
	IF ( @@Error  <> 0 )
		SET @ErrorCode	= 5
	else 
	  BEGIN
		update T_FriendMain set MemoTotal=MemoTotal-1 where GUID = @UserGuid
		IF ( @@Error  <> 0 )
		begin
			SET @ErrorCode	= 6
		end
	  END

	IF ( @ErrorCode  <> 0 )
	  BEGIN
		ROLLBACK TRAN
	  END
	ELSE
	  BEGIN
		COMMIT TRAN
		SET @ErrorCode	= 1
	  END
	
EndProc:

	SET	XACT_ABORT OFF
	Set		nocount off
	select @ErrorCode
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_DesblocAccount] 
@Account varchar(10)
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

UPDATE MEMB_INFO SET bloc_code = 0 where memb___id = @Account and bloc_code = 1 and bloc_expire < GETDATE()

UPDATE Character SET CtlCode = 0 where AccountID = @Account and CtlCode = 1 and bloc_expire < GETDATE()

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_DISCONNECT_MEMB : 
--

CREATE PROCEDURE [dbo].[WZ_DISCONNECT_MEMB]
@memb___id varchar(10)
 AS
Begin	
set nocount on
	Declare  @find_id varchar(10)	
	Declare @ConnectStat tinyint
	Set @ConnectStat = 0		-- ?? ?? ? 1 = ??, 0 = ??X
	Set @find_id = 'NOT'
	select @find_id = S.memb___id from MEMB_STAT S INNER JOIN MEMB_INFO I ON S.memb___id = I.memb___id 
	       where I.memb___id = @memb___id

	if( @find_id <> 'NOT' )	-- ?? ?? ??? ?? ??? ???? ???? ??
	begin		
		update MEMB_STAT set ConnectStat = @ConnectStat, DisConnectTM = getdate()
		 where memb___id = @memb___id
	end
end
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_FriendAdd : 
--

-- ?? ??? ????.
/* ?? : 
 1 : ??
 2 : ?? ?? ???? ???? ??
 3 : ??  GUID? ???? ???.
 4 : ?? GUID? ??? ????.
 5 : ??? GUID? ???? ???.
 6 : ??? GUID? ??? ????.
*/
CREATE procedure [dbo].[WZ_FriendAdd]
	@Name varchar(10),  @FriendName varchar(10)

as 

BEGIN
	DECLARE @ErrorCode int
	DECLARE @UserGuid  int
	DECLARE @FriendGuid  int

	Set		nocount on 	
	SET	XACT_ABORT ON


	SET @ErrorCode = 0

	-- FriendName GUID? ??????
	if NOT EXISTS ( select GUID FROM T_FriendMain where Name=@FriendName )
	  BEGIN
		SET @ErrorCode = 5
		GOTO EndProc
	  END
 	ELSE
	  BEGIN
		select @FriendGuid = GUID FROM T_FriendMain where Name=@FriendName

		IF ( @@Error  <> 0 )
		begin
			SET @ErrorCode = 6
			GOTO EndProc
		end

	end


	-- Name GUID? ??????
	if NOT EXISTS ( select GUID FROM T_FriendMain where Name=@Name)
	  BEGIN
		SET @ErrorCode = 3
		GOTO EndProc

	  END
	else
	  BEGIN
		select @UserGuid = GUID FROM T_FriendMain where Name=@Name
	
		IF ( @@Error  <> 0   )
		begin
			SET @ErrorCode = 4
			GOTO EndProc
		end
	
	  END

	-- ?? ?????? ???? ??? ?????.
	if EXISTS (SELECT GUID FROM T_FriendList where GUID = @UserGuid AND FriendGuid = @FriendGuid  )
	begin
		SET @ErrorCode = 2
		GOTO EndProc
	end

	/*-- ?? ?????? ???? ??? ?????.
	if EXISTS (SELECT GUID FROM T_FriendList where GUID = @FriendGuid AND FriendGuid = @UserGuid  )
	begin
		SET @ErrorCode = 2
		GOTO EndProc
	end
	*/
	BEGIN TRAN

	-- ??? ?????.
	INSERT INTO T_FriendList (GUID, FriendGuid, FriendName ) 
		VALUES ( @UserGuid, @FriendGuid, @FriendName)
	
	IF ( @@Error  <> 0 )
		SET @ErrorCode	= @@Error
	else 
	  BEGIN
		DELETE FROM T_WaitFriend where GUID = @UserGuid AND FriendGuid = @FriendGuid
		IF ( @@Error  <> 0 )
		begin
			SET @ErrorCode	= @@Error
		end
	  END

	/*-- ?? ??? ?????.
	INSERT INTO T_FriendList (GUID, FriendGuid, FriendName ) 
		VALUES ( @FriendGuid, @UserGuid,  @Name)

	IF ( @@Error  <> 0 )
		SET @ErrorCode	= @@Error
	else 
	  BEGIN
		DELETE FROM T_WaitFriend where GUID = @FriendGuid AND FriendGuid = @UserGuid
		IF ( @@Error  <> 0 )
		begin
			SET @ErrorCode	= @@Error
		end
	  END
*/
--EndTranProc:
	IF ( @ErrorCode  <> 0 )
	  BEGIN
		ROLLBACK TRAN
	  END
	ELSE
	  BEGIN
		COMMIT TRAN
		SET @ErrorCode	= 1
	  END
	


EndProc:

	SET	XACT_ABORT OFF
	Set		nocount off
	select @ErrorCode
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_FriendDel : 
--

-- ??? ???? ????.
CREATE procedure [dbo].[WZ_FriendDel]
	@Name varchar(10),  @FriendName varchar(10)

as 

BEGIN
	DECLARE @ErrorCode int
	DECLARE @UserGuid  int
	DECLARE @FriendGuid  int

	Set		nocount on

	SET @ErrorCode = 0

	-- ?? GUID? ???.
	if NOT EXISTS ( select GUID FROM T_FriendMain where Name=@Name)
	  BEGIN
		SET @ErrorCode = 3
		GOTO EndProc

	  END
	else
	  BEGIN
		select @UserGuid = GUID FROM T_FriendMain where Name=@Name
	
		IF ( @@Error  <> 0   )
		begin
			SET @ErrorCode = 4
		end

	  END

	-- ??? GUID? ???.
	if NOT EXISTS ( select GUID FROM T_FriendMain where Name=@FriendName )
	  BEGIN
		SET @ErrorCode = 5
		GOTO EndProc
	  END
 	ELSE
	  BEGIN
		select @FriendGuid = GUID FROM T_FriendMain where Name=@FriendName

		IF ( @@Error  <> 0 )
		begin
			SET @ErrorCode = 6
		end

	end

	-- ?????? ???? ??? ????.
	if NOT EXISTS (SELECT GUID FROM T_FriendList where GUID = @UserGuid AND FriendGuid = @FriendGuid  )
	begin
		SET @ErrorCode = 2
		GOTO EndProc
	end
	
	-- ????.
	DELETE FROM T_FriendList where GUID = @UserGuid AND FriendGuid = @FriendGuid  
	
	IF ( @@Error  <> 0 )
		SET @ErrorCode	= @@Error
	else SET @ErrorCode	= 1

	IF( @ErrorCode = 1 )
	BEGIN
		UPDATE T_FriendList SET Del=1 where GUID=@FriendGuid AND FriendGuid=@UserGuid
	END

EndProc:

	Set		nocount off
	select @ErrorCode
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[WZ_Get_DBID]
 

as
/*begin
select * from WZ_CreateCharacter_Version
end*/
BEGIN
	SELECT 1 as Version
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_GetAccountLevel] 
@Account varchar(10)
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @CurrentAccountLevel int
DECLARE @CurrentAccountExpireDate smalldatetime

SELECT @CurrentAccountLevel = AccountLevel, @CurrentAccountExpireDate = AccountExpireDate FROM MEMB_INFO WHERE memb___id = @account

IF (@CurrentAccountLevel <> 0 AND GETDATE() > @CurrentAccountExpireDate)
BEGIN
	SET @CurrentAccountLevel = 0
	UPDATE MEMB_INFO SET AccountLevel = @CurrentAccountLevel WHERE memb___id = @account
END

SELECT @CurrentAccountLevel as AccountLevel, @CurrentAccountExpireDate as AccountExpireDate

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[WZ_GetCharacterGensInfo]
@Name varchar(10),
@Family int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

IF ( @Family = 1 )
BEGIN
SELECT dbo.fn_rank_gens(@Name,1)as Rank, Contribution FROM Gens_Rank WHERE Name = @Name and Family=1
END
ELSE
BEGIN
SELECT dbo.fn_rank_gens(@Name,2)as Rank, Contribution FROM Gens_Rank WHERE Name = @Name and Family=2
END

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[WZ_GetGremorySerial]
AS
BEGIN	
	DECLARE @ItemSerial	int
	SET NOCOUNT ON
	BEGIN TRANSACTION

		UPDATE GameServerInfo SET @ItemSerial = GremoryCount = GremoryCount + 1
			
		IF ( @@Error <> 0 )
		BEGIN
			ROLLBACK TRANSACTION
			SELECT -1
		END 
		ELSE
		BEGIN
			COMMIT TRANSACTION				
			SELECT @ItemSerial
		END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WZ_GetItemMarketSerial]
AS
BEGIN
	DECLARE @ItemSerial	int
	SET NOCOUNT ON
	BEGIN TRANSACTION

		UPDATE GameServerInfo SET @ItemSerial = ItemMarketCount = ItemMarketCount + 1

		IF ( @@Error <> 0 )
			BEGIN
				ROLLBACK TRANSACTION
				SELECT -1
			END 
		ELSE
			BEGIN
				COMMIT TRANSACTION
				SELECT @ItemSerial
			END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_GetItemSerial : 
--

CREATE procedure [dbo].[WZ_GetItemSerial]
as
BEGIN	
	DECLARE @ItemSerial	int
	set nocount on
	begin transaction

		update GameServerInfo set @ItemSerial = ItemCount = ItemCount+1
			
		if ( @@error  <> 0 )
		begin	
			rollback transaction
			select -1
		end 
		else
		begin
			commit transaction				
			select @ItemSerial
		end
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[WZ_GetMarryInfo] @name varchar(10), @MarryCharacter varchar(10)
AS
BEGIN
SET NOCOUNT ON
SET XACT_ABORT ON
DECLARE @countYou int
DECLARE @countHim int
DECLARE @Startdate datetime2 = '2016-01-01 00:00:00.0000000';
DECLARE @marriedOnEnd datetime2
DECLARE @marriedOn int
DECLARE @nameGet1 varchar(10)
DECLARE @nameGet2 varchar(10)
SELECT @countYou=Count(*) FROM [dbo].[Marry] WHERE Name1 = @name OR Name2 = @name /*You are already married*/
SELECT @countHim=Count(*) FROM [dbo].[Marry] WHERE Name1 = @MarryCharacter OR Name2 = @MarryCharacter /*He/She is already married*/
SELECT @nameGet1=Name2 FROM [dbo].[Marry] WHERE Name1 = @name
SELECT @nameGet2=Name1 FROM [dbo].[Marry] WHERE Name2 = @name
SELECT @marriedOnEnd=MarryDate FROM [dbo].[Marry] WHERE Name1 = @name OR Name2 = @name /*Married date*/
SELECT @marriedOn=DATEDIFF(SECOND, @Startdate, @marriedOnEnd)
SELECT @countYou AS CountYou, @countHim AS CountHim, @marriedOn AS MarriedOn, @nameGet1 AS NameGet1, @nameGet2 AS NameGet2
SET NOCOUNT OFF
SET XACT_ABORT OFF
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_GetMasterResetInfo]
@Account varchar(10),
@Name varchar(10)
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @MasterReset int
DECLARE @MasterResetDay int
DECLARE @MasterResetWek int
DECLARE @MasterResetMon int

SELECT @MasterReset=MasterResetCount,@MasterResetDay=0,@MasterResetWek=0,@MasterResetMon=0 FROM Character WHERE AccountID=@Account AND Name=@Name

SELECT @MasterReset AS MasterReset,@MasterResetDay AS MasterResetDay,@MasterResetWek AS MasterResetWek,@MasterResetMon AS MasterResetMon

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_GetResetInfo]
@Account varchar(10),
@Name varchar(10)
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @Reset int
DECLARE @ResetDay int
DECLARE @ResetWek int
DECLARE @ResetMon int

SELECT @Reset=ResetCount,@ResetDay=0,@ResetWek=0,@ResetMon=0 FROM Character WHERE AccountID=@Account AND Name=@Name

SELECT @Reset AS Reset,@ResetDay AS ResetDay,@ResetWek AS ResetWek,@ResetMon AS ResetMon

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_GuildCreate : 
--

CREATE procedure [dbo].[WZ_GuildCreate]
	@GuildName	varchar(8),
	@MasterName 	varchar(10)
as 
BEGIN
	DECLARE @ErrorCode int

	SET @ErrorCode = 0
	SET XACT_ABORT ON

	Set		nocount on 		
	begin transaction

	-- ??? ????.	
	INSERT	INTO Guild (G_Name, G_Master) VALUES (@GuildName, @MasterName)
	IF ( @@Error  <> 0 )
	BEGIN
		SET @ErrorCode	= 1
	END

       	-- ??? ????? ?? ???
	IF ( @ErrorCode  =  0 )
	BEGIN
		-- ?? ???? ????.
		INSERT GuildMember (Name, G_Name, G_Level) VALUES (@MasterName, @GuildName, 1)
		IF ( @@Error  <> 0 )
		BEGIN
			SET @ErrorCode	= 2
		END
	END

	IF ( @ErrorCode  <> 0 )
		rollback transaction
	ELSE
		commit transaction

	select @ErrorCode

	Set 	nocount off 
	SET XACT_ABORT OFF
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_RankingBloodCastle] 
@Account varchar(10),
@Name varchar(10),
@Score int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

IF NOT EXISTS (SELECT Name FROM RankingBloodCastle WHERE Name=@Name)
BEGIN

	 INSERT INTO RankingBloodCastle (Name,Score,Score_semanal) VALUES (@Name,@Score,@Score)

END
ELSE
BEGIN

	UPDATE RankingBloodCastle SET Score=Score+@Score,Score_semanal=Score_semanal+@Score WHERE Name=@Name

END

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_RankingChaosCastle] 
@Account varchar(10),
@Name varchar(10),
@Score int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

IF NOT EXISTS (SELECT Name FROM RankingChaosCastle WHERE Name=@Name)
BEGIN

	 INSERT INTO RankingChaosCastle (Name,Score) VALUES (@Name,@Score)

END
ELSE
BEGIN

	UPDATE RankingChaosCastle SET Score=Score+@Score WHERE Name=@Name

END

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_RankingDevilSquare] 
@Account varchar(10),
@Name varchar(10),
@Score int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

IF NOT EXISTS (SELECT Name FROM RankingDevilSquare WHERE Name=@Name)
BEGIN

	 INSERT INTO RankingDevilSquare (Name,Score) VALUES (@Name,@Score)

END
ELSE
BEGIN

	UPDATE RankingDevilSquare SET Score=Score+@Score WHERE Name=@Name

END

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_RankingIllusionTemple] 
@Account varchar(10),
@Name varchar(10),
@Score int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

IF NOT EXISTS (SELECT Name FROM RankingIllusionTemple WHERE Name=@Name)
BEGIN

	 INSERT INTO RankingIllusionTemple (Name,Score) VALUES (@Name,@Score)

END
ELSE
BEGIN

	UPDATE RankingIllusionTemple SET Score=Score+@Score WHERE Name=@Name

END

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_RenameCharacter] 
@Account varchar(10),
@OldName varchar(10),
@NewName varchar(10)
AS
BEGIN

SET NOCOUNT ON
SET	XACT_ABORT ON

DECLARE @Result tinyint

SET @Result = 1

If EXISTS ( SELECT  Name  FROM  Character WHERE Name = @NewName )
	begin
		SET @Result	= 1
	end
else
	begin
		SET @Result = 0		
		UPDATE Character SET Name = @NewName WHERE Name = @OldName AND AccountID = @Account
		UPDATE AccountCharacter SET GameID1 = @NewName WHERE GameID1 = @OldName AND Id = @Account
		UPDATE AccountCharacter SET GameID2 = @NewName WHERE GameID2 = @OldName AND Id = @Account
		UPDATE AccountCharacter SET GameID3 = @NewName WHERE GameID3 = @OldName AND Id = @Account
		UPDATE AccountCharacter SET GameID4 = @NewName WHERE GameID4 = @OldName AND Id = @Account
		UPDATE AccountCharacter SET GameID5 = @NewName WHERE GameID5 = @OldName AND Id = @Account
		UPDATE AccountCharacter SET GameID6 = @NewName WHERE GameID6 = @OldName AND Id = @Account
		UPDATE AccountCharacter SET GameID7 = @NewName WHERE GameID7 = @OldName AND Id = @Account
		UPDATE AccountCharacter SET GameID8 = @NewName WHERE GameID8 = @OldName AND Id = @Account
		UPDATE AccountCharacter SET GameID9 = @NewName WHERE GameID9 = @OldName AND Id = @Account
		UPDATE AccountCharacter SET GameID10 = @NewName WHERE GameID10 = @OldName AND Id = @Account
		UPDATE AccountCharacter SET GameIDC = @NewName WHERE GameIDC = @OldName AND Id = @Account
		UPDATE Guild SET G_Master = @NewName WHERE G_Master = @OldName
		UPDATE GuildMember SET Name = @NewName WHERE Name = @OldName
		UPDATE OptionData SET Name = @NewName WHERE Name = @OldName
		UPDATE T_CGuid SET Name = @NewName WHERE Name = @OldName
		UPDATE T_FriendList SET FriendName = @NewName WHERE FriendName = @OldName
		UPDATE T_FriendMail SET FriendName = @NewName WHERE FriendName = @OldName
		UPDATE T_FriendMain SET Name = @NewName WHERE Name = @OldName
		UPDATE T_WaitFriend SET FriendName = @NewName WHERE FriendName = @OldName
		UPDATE QuestKillCount SET Name = @NewName WHERE Name = @OldName
		UPDATE MasterSkillTree SET Name = @NewName WHERE Name = @OldName
		UPDATE EventLeoTheHelper SET Name = @NewName WHERE Name = @OldName
		UPDATE EventSantaClaus SET Name = @NewName WHERE Name = @OldName
		UPDATE QuestWorld SET Name = @NewName WHERE Name = @OldName
		UPDATE Gens_Rank SET Name = @NewName WHERE Name = @OldName
		UPDATE Gens_Reward SET Name = @NewName WHERE Name = @OldName
		UPDATE RankingDuel SET Name = @NewName WHERE Name = @OldName
		UPDATE RankingBloodCastle SET Name = @NewName WHERE Name = @OldName
		UPDATE RankingChaosCastle SET Name = @NewName WHERE Name = @OldName
		UPDATE RankingDevilSquare SET Name = @NewName WHERE Name = @OldName
		UPDATE RankingIllusionTemple SET Name = @NewName WHERE Name = @OldName
		UPDATE HelperData SET Name = @NewName WHERE Name = @OldName

		-- MSPro V10
		UPDATE XTR_PenaltyData SET Name = @NewName WHERE Name = @OldName
		UPDATE XTR_PetInventory SET Name = @NewName WHERE Name = @OldName
		UPDATE XTR_QuestInfo SET Name = @NewName WHERE Name = @OldName
		UPDATE XTR_EventEnterCount SET Name = @NewName WHERE Name = @OldName
		UPDATE XTR_PlayerDieLog SET Player1 = @NewName WHERE Player1 = @OldName
		UPDATE XTR_PlayerDieLog SET Player2 = @NewName WHERE Player2 = @OldName
		UPDATE Marry SET Name1 = @NewName WHERE Name1 = @OldName
		UPDATE Marry SET Name2 = @NewName WHERE Name2 = @OldName
		
		-- V11
		UPDATE FlagSystem SET Name = @NewName WHERE Name = @OldName
		UPDATE ResetSystem SET Name = @NewName WHERE Name = @OldName
		
		-- V13
		UPDATE KillLog SET Name1 = @NewName WHERE Name1 = @OldName
		UPDATE KillLog SET Name2 = @NewName WHERE Name2 = @OldName
		UPDATE GremoryCase SET Name = @NewName WHERE Type = 0 AND Name = @OldName
		UPDATE FlagSystem SET Name = @NewName WHERE Name = @OldName
		UPDATE AutoAddStats SET Name = @NewName WHERE Name = @OldName
		
		-- V14
		UPDATE DailyBonus SET Name = @NewName WHERE Name = @OldName
		UPDATE FortuneWheel SET Name = @NewName WHERE Name = @OldName
		
		-- V15
		UPDATE ItemMarket SET Name = @NewName WHERE Name = @OldName
	end

SELECT @Result

SET NOCOUNT OFF
SET	XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WZ_RenameCharacter_Extended]
				@Account varchar(10),
				@OldName varchar(10),
				@NewName varchar(10)
			AS
			BEGIN
				SET NOCOUNT ON;

				DECLARE @Result tinyint;

				-- Original stored procedure execution
				DECLARE @Tmp TABLE(Result tinyint);
				INSERT INTO @Tmp EXEC WZ_RenameCharacter @Account, @OldName, @NewName;
				SELECT @Result = Result FROM @Tmp;

				IF (@Result = 1) -- Check if rename was successful
				BEGIN
					UPDATE XTR_PenaltyData     SET Name   = @NewName WHERE Name   = @OldName;
					UPDATE XTR_PetInventory    SET Name   = @NewName WHERE Name   = @OldName;
					UPDATE XTR_QuestInfo       SET Name   = @NewName WHERE Name   = @OldName;
					UPDATE XTR_EventEnterCount SET Name   = @NewName WHERE Name   = @OldName;
					UPDATE XTR_PlayerDieLog    SET Player1 = @NewName WHERE Player1 = @OldName;
					UPDATE XTR_PlayerDieLog    SET Player2 = @NewName WHERE Player2 = @OldName;
					UPDATE Marry               SET Name1 = @NewName WHERE Name1 = @OldName;
					UPDATE Marry               SET Name2 = @NewName WHERE Name2 = @OldName;
					UPDATE FlagSystem          SET Name = @NewName WHERE Name = @OldName;
					UPDATE ResetSystem         SET Name = @NewName WHERE Name = @OldName;
					UPDATE KillLog             SET Name1 = @NewName WHERE Name1 = @OldName;
					UPDATE KillLog             SET Name2 = @NewName WHERE Name2 = @OldName;
					UPDATE GremoryCase         SET Name = @NewName WHERE Type = 0 AND Name = @OldName;
					UPDATE AutoAddStats        SET Name = @NewName WHERE Name = @OldName;
					UPDATE DailyBonus          SET Name = @NewName WHERE Name = @OldName;
					UPDATE FortuneWheel        SET Name = @NewName WHERE Name = @OldName;
					UPDATE ItemMarket          SET Name = @NewName WHERE Name = @OldName;
				END

				SELECT @Result AS Result;
			END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WZ_RenameCharacter_Extended_V2]
				@Account varchar(10),
				@OldName varchar(10),
				@NewName varchar(10)
			AS
			BEGIN
				SET NOCOUNT ON;

				DECLARE @Result tinyint;

				-- Original stored procedure execution
				DECLARE @Tmp TABLE(Result tinyint);
				INSERT INTO @Tmp EXEC WZ_RenameCharacter @Account, @OldName, @NewName;
				SELECT @Result = Result FROM @Tmp;

				IF (@Result = 0) -- Check if rename was successful
				BEGIN
					UPDATE XTR_PenaltyData     SET Name   = @NewName WHERE Name   = @OldName;
					UPDATE XTR_PetInventory    SET Name   = @NewName WHERE Name   = @OldName;
					UPDATE XTR_QuestInfo       SET Name   = @NewName WHERE Name   = @OldName;
					UPDATE XTR_EventEnterCount SET Name   = @NewName WHERE Name   = @OldName;
					UPDATE XTR_PlayerDieLog    SET Player1 = @NewName WHERE Player1 = @OldName;
					UPDATE XTR_PlayerDieLog    SET Player2 = @NewName WHERE Player2 = @OldName;
					UPDATE Marry               SET Name1 = @NewName WHERE Name1 = @OldName;
					UPDATE Marry               SET Name2 = @NewName WHERE Name2 = @OldName;
					UPDATE FlagSystem          SET Name = @NewName WHERE Name = @OldName;
					UPDATE ResetSystem         SET Name = @NewName WHERE Name = @OldName;
					UPDATE KillLog             SET Name1 = @NewName WHERE Name1 = @OldName;
					UPDATE KillLog             SET Name2 = @NewName WHERE Name2 = @OldName;
					UPDATE GremoryCase         SET Name = @NewName WHERE Type = 0 AND Name = @OldName;
					UPDATE AutoAddStats        SET Name = @NewName WHERE Name = @OldName;
					UPDATE DailyBonus          SET Name = @NewName WHERE Name = @OldName;
					UPDATE FortuneWheel        SET Name = @NewName WHERE Name = @OldName;
					UPDATE ItemMarket          SET Name = @NewName WHERE Name = @OldName;
				END

				SELECT @Result AS Result;
			END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_SetAccountLevel] 
@Account varchar(10),
@AccountLevel int,
@AccountExpireTime int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @CurrentAccountLevel int
DECLARE @CurrentAccountExpireDate smalldatetime

SELECT @CurrentAccountLevel=AccountLevel,@CurrentAccountExpireDate=AccountExpireDate FROM MEMB_INFO WHERE memb___id=@Account

IF(@CurrentAccountLevel = @AccountLevel)
BEGIN
	SET @CurrentAccountLevel = @CurrentAccountLevel
	SET @CurrentAccountExpireDate = DATEADD(second,@AccountExpireTime,@CurrentAccountExpireDate)
END
ELSE
BEGIN
	SET @CurrentAccountLevel = @AccountLevel

	SET @CurrentAccountExpireDate = DATEADD(second,@AccountExpireTime,getdate())
END

UPDATE MEMB_INFO SET AccountLevel=@CurrentAccountLevel,AccountExpireDate=@CurrentAccountExpireDate WHERE memb___id=@Account

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_SetCoin] 
@Account varchar(10),
@Name varchar(10),
@Value1 int,
@Value2 int,
@Value3 int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

-- Tipo 1: Update Cash | Wcoin
	IF @Value1 > 0 or @Value1 < 0
	BEGIN
		UPDATE CashShopData SET WCoinC = WCoinC + @Value1 WHERE AccountID = @Account
		--Para Season 4
		--UPDATE MEMB_INFO SET Cash = Cash + @Value1 WHERE memb___id = @Account 
	END
	
-- Tipo 2: Update Gold | WcoinP
	IF @Value2 > 0 or @Value2 < 0  
	BEGIN
		UPDATE CashShopData SET WCoinP = WCoinP + @Value2 WHERE AccountID = @Account
		--Para Season 4
		--UPDATE MEMB_INFO SET Gold = Gold + @Value2 WHERE memb___id = @Account 
	END

-- Tipo 3: Update PcPoints | GoblinPoints
	IF @Value3 > 0 or @Value3 < 0 
	BEGIN
		UPDATE CashShopData SET GoblinPoint = GoblinPoint + @Value3 WHERE AccountID = @Account
		--Para Season 4
		--UPDATE PcPointdata SET PcPoint = PcPoint + @Value3 WHERE AccountID = @Account 
	END
	

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[WZ_SetDivorceInfo] @name varchar(10), @MarryCharacter varchar(10)
AS
BEGIN
SET NOCOUNT ON
DELETE FROM [dbo].[Marry] WHERE Name1 = @name OR Name2 = @MarryCharacter
SET NOCOUNT OFF
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[WZ_SetGuildDelete]
	@GuildName		varchar(10)
As
Begin
	SET NOCOUNT ON
	Declare		@Result		int
	Set @Result	= 1 

	Begin Transaction									
		--// Guild member db delete
		DELETE GuildMember WHERE G_Name = @GuildName		
		If @@Error <> 0 
		begin			
			Set @Result	= 0 -- DB Error 
			goto PROBLEM	
		end

		--// Guild  Main DB? ??
		DELETE Guild WHERE G_Name = @GuildName	
		DELETE RankingKingGuild WHERE Name = @GuildName		
		If @@Error <> 0 
			begin
				Set @Result	= 0  --  DB Error
				goto PROBLEM	
			end	
		else goto SUCESS

	PROBLEM:
		rollback transaction
 
	SUCESS:
   		commit transaction		
				
	-- ??? RETURN
	SELECT @Result  As Result
	SET NOCOUNT OFF
End
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[WZ_SetMarryInfo] @name varchar(10), @MarryCharacter varchar(10)
AS
BEGIN
SET NOCOUNT ON
INSERT INTO [dbo].[Marry] (Name1, Name2, MarryDate) VALUES (@name, @MarryCharacter, GETDATE());
SET NOCOUNT OFF
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_SetMasterResetInfo] 
@Account varchar(10),
@Name varchar(10),
@Reset int,
@MasterReset int,
@MasterResetDay int,
@MasterResetWek int,
@MasterResetMon int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

UPDATE Character SET ResetCount=@Reset,MasterResetCount=@MasterReset WHERE AccountID=@Account AND Name=@Name

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_SetResetInfo] 
@Account varchar(10),
@Name varchar(10),
@Reset int,
@ResetDay int,
@ResetWek int,
@ResetMon int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

UPDATE Character SET ResetCount=@Reset WHERE AccountID=@Account AND Name=@Name

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




Create Procedure [dbo].[WZ_SetReward] 
@Account varchar(10),
@Name varchar(10),
@AccountGM varchar(10),
@NameGM varchar(10),
@Type int,
@Value int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

-- Tipo 1: Update Cash | Wcoin
	IF @Type = 1 
	BEGIN
		UPDATE CashShopData SET WCoinC = WCoinC + @Value WHERE AccountID = @Account
		--Para Season 4
		--UPDATE MEMB_INFO SET Cash = Cash + @Value WHERE memb___id = @Account 
	END
	
-- Tipo 2: Update Gold | WcoinP
	IF @Type = 2 
	BEGIN
		UPDATE CashShopData SET WCoinP = WCoinP + @Value WHERE AccountID = @Account
		--Para Season 4
		--UPDATE MEMB_INFO SET Gold = Gold + @Value WHERE memb___id = @Account 
	END

-- Tipo 3: Update PcPoints | GoblinPoints
	IF @Type = 3 
	BEGIN
		UPDATE CashShopData SET GoblinPoint = GoblinPoint + @Value WHERE AccountID = @Account
		--Para Season 4
		--UPDATE PcPointdata SET PcPoint = PcPoint + @Value WHERE AccountID = @Account 
	END
	

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[WZ_SetRewardAll] 
@AccountGM varchar(10),
@NameGM varchar(10),
@Type int,
@Value int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

-- Tipo 1: Update Cash | Wcoin
	IF @Type = 1 
	BEGIN
		UPDATE CashShopData SET WCoinC = WCoinC + @Value
		--Para Season 4
		--UPDATE MEMB_INFO SET Cash = Cash + @Value
	END
	
-- Tipo 2: Update Gold | WcoinP
	IF @Type = 2 
	BEGIN
		UPDATE CashShopData SET WCoinP = WCoinP + @Value
		--Para Season 4
		--UPDATE MEMB_INFO SET Gold = Gold + @Value 
	END

-- Tipo 3: Update PcPoints | GoblinPoints
	IF @Type = 3 
	BEGIN
		UPDATE CashShopData SET GoblinPoint = GoblinPoint + @Value
		--Para Season 4
		--UPDATE PcPointdata SET PcPoint = PcPoint + @Value 
	END
	
SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_TvTRanking] 
@Account varchar(10),
@Name varchar(10),
@KillCount int,
@DeadCount int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

IF NOT EXISTS (SELECT Name FROM RankingTvT WHERE Name=@Name)
BEGIN

	 INSERT INTO RankingTvT (Name,Kills,Deads) VALUES (@Name,@KillCount,@DeadCount)

END
ELSE
BEGIN

	UPDATE RankingTvT SET Kills=Kills+@KillCount, Deads=Deads+@DeadCount WHERE Name=@Name

END

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[WZ_UpdateAccountLevel] 
@Account varchar(10),
@AccountLevel int,
@AccountExpireTime int
AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

DECLARE @CurrentAccountLevel int
DECLARE @CurrentAccountExpireDate smalldatetime

SELECT @CurrentAccountLevel=AccountLevel,@CurrentAccountExpireDate=AccountExpireDate FROM MEMB_INFO WHERE memb___id=@Account

IF(@CurrentAccountLevel = @AccountLevel)
BEGIN
	SET @CurrentAccountLevel = @CurrentAccountLevel
	SET @CurrentAccountExpireDate = DATEADD(second,@AccountExpireTime,@CurrentAccountExpireDate)
END
ELSE
BEGIN
	SET @CurrentAccountLevel = @AccountLevel

	SET @CurrentAccountExpireDate = DATEADD(second,@AccountExpireTime,getdate())
END

UPDATE MEMB_INFO SET AccountLevel=@CurrentAccountLevel,AccountExpireDate=@CurrentAccountExpireDate WHERE memb___id=@Account

SET NOCOUNT OFF
SET XACT_ABORT OFF

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_UserGuidCreate : 
--

/*
-- ??? ?? GUID? ???? ???? GUID? ????.

*/
CREATE procedure [dbo].[WZ_UserGuidCreate]
	@Name varchar(10)
as 
BEGIN
	DECLARE @ErrorCode int
	DECLARE @UserGuid  int

	SET @ErrorCode = 1
	SET @UserGuid = -1

	SET	XACT_ABORT ON
	Set		nocount on 		


	-- GUID? ??????
	if EXISTS ( select GUID FROM T_CGuid where Name=@Name ) 
	  BEGIN
		SET @ErrorCode = 0
		goto EndProc
	  END

	BEGIN TRAN

	-- ???? ????? GUID? ????.
	INSERT INTO T_CGuid (Name) VALUES(@Name)

	IF ( @@Error  <> 0 )
	  BEGIN
		SET @ErrorCode	= 2
	  END
	ELSE 
	  BEGIN
		select @UserGuid = GUID FROM T_CGuid where Name=@Name
		IF ( @@Error  <> 0 )
		  BEGIN
			SET @ErrorCode	= 3
		  END
		ELSE 
		  BEGIN
			INSERT INTO T_FriendMain ( GUID, Name, FriendCount, MemoCount) VALUES(@UserGuid, @Name,1,10)
			IF ( @@Error  <> 0 )
				SET @ErrorCode	= 4
		  END
	  END

EndTranProc:
	IF ( @@Error  <> 0 )
		ROLLBACK TRAN
	ELSE COMMIT TRAN

EndProc:
	select @ErrorCode
	SET	XACT_ABORT OFF

	Set		nocount off
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_WaitFriendAdd : 
--

/*  ?? ?? ??? ??? ????.
-- Name :?? ?? 
-- FriendName : ?? ??

return : 
	0 : ??,
 	2 : ?? GUID ?? ??
       	3 : ?? GUID ?? ??
	4 : ?? ?? ??
	5 : ?? ?? ??
	6 : ?? ??? 6 ???

-- ** ?? ???? ?? ???? ?
*/
CREATE procedure [dbo].[WZ_WaitFriendAdd]
	@Name varchar(10), @FriendName varchar(10)
as
BEGIN
	DECLARE @ErrorCode int
	DECLARE @UserGuid  int
	DECLARE @FriendGuid  int
	DECLARE @FriendLevel  int

	SET NOCOUNT ON
	SET	XACT_ABORT ON
	

	SET @ErrorCode = 1

	-- GUID? ???.
	if EXISTS (select  GUID FROM T_FriendMain where Name=@Name)
  	  BEGIN
		select @UserGuid = GUID FROM T_FriendMain where Name=@Name
		IF ( @@Error  <> 0 )
		BEGIN
			SET @ErrorCode	= 7
			GOTO EndProc
		END
	  END
	else
	  BEGIN
		SET @ErrorCode	= 0
		GOTO EndProc
	  END

	-- GUID? ???.
	if EXISTS (select  GUID FROM T_FriendMain where Name=@FriendName)
	  BEGIN
		select @FriendGuid = GUID FROM T_FriendMain where Name=@FriendName
		IF ( @@Error  <> 0 )
		BEGIN
			SET @ErrorCode	= 7
			GOTO EndProc
		END
  	  END
	else
	  BEGIN
		SET @ErrorCode	= 0
		GOTO EndProc
  	  END

	-- ??? ??? ???. 
	select  @FriendLevel=cLevel FROM Character where Name=@FriendName
	IF( @@Error <> 0 )
	  begin
		SET @ErrorCode = 7	
		GOTO EndProc
	  end
	ELSE 
	  BEGIN
		-- ??? 6?? ??? 
		if( @FriendLevel < 6 )
		  begin
			SET @ErrorCode = 6
			GOTO EndProc
		  end
	  END

	if EXISTS (SELECT GUID FROM T_FriendList where GUID = @UserGuid AND FriendGuid = @FriendGuid  )
	begin
		SET @ErrorCode = 4
		GOTO EndProc
	end

	BEGIN TRAN

	-- ??? ??? ?? ???? ???..
	if EXISTS (SELECT GUID FROM T_FriendList where GUID = @FriendGuid AND FriendGuid =  @UserGuid )
	begin
		UPDATE T_FriendList SET Del=0 where GUID=@FriendGuid AND FriendGuid=@UserGuid
		SET @ErrorCode = 8
		GOTO EndTranProc
	end

	-- ?? ?? ???? ?????.
	INSERT INTO T_FriendList (GUID, FriendGuid, FriendName, Del ) 
		VALUES ( @UserGuid, @FriendGuid, @FriendName, 1)
	
	IF ( @@Error  <> 0 )
	BEGIN
		SET @ErrorCode	= 7
		GOTO EndTranProc
	END	

	-- ??? ?? ??? ??? ???
	INSERT INTO T_WaitFriend (GUID, FriendName, FriendGuid ) 
				VALUES ( @FriendGuid, @Name, @UserGuid)
	
	IF ( @@Error  <> 0 )
	BEGIN
		SET @ErrorCode	= 7
		GOTO EndTranProc
	END


EndTranProc:
	IF ( (@ErrorCode  = 1) OR (@ErrorCode  = 8) )
	  BEGIN
		COMMIT TRAN
	  END
	ELSE
	  BEGIN
		ROLLBACK TRAN
	  END
	
EndProc:

	SET	XACT_ABORT OFF

	SET NOCOUNT OFF

	select @ErrorCode
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_WaitFriendDel : 
--

-- ??? ???? ????.
CREATE procedure [dbo].[WZ_WaitFriendDel]
	@Name varchar(10),  @FriendName varchar(10)

as
BEGIN
	DECLARE @ErrorCode int
	DECLARE @UserGuid  int
	DECLARE @FriendGuid  int

	Set		nocount on 	

	SET @ErrorCode = 2

	-- ?? GUID? ???.
	if NOT EXISTS ( select GUID FROM T_FriendMain where Name=@Name)
	  BEGIN
		SET @ErrorCode = 0
		GOTO EndProc

	  END
	else
	  BEGIN
		select @UserGuid = GUID FROM T_FriendMain where Name=@Name
	
		IF ( @@Error  <> 0   )
		begin
			SET @ErrorCode = 7
		end

	  END

	-- ??? GUID? ???.
	if NOT EXISTS ( select GUID FROM T_FriendMain where Name=@FriendName )
	  BEGIN
		SET @ErrorCode = 0
		GOTO EndProc
	  END
 	ELSE
	  BEGIN
		select @FriendGuid = GUID FROM T_FriendMain where Name=@FriendName

		IF ( @@Error  <> 0 )
		begin
			SET @ErrorCode = 7
		end

	end

	-- ?????? ???? ??? ????.
	if NOT EXISTS (SELECT GUID FROM T_WaitFriend where GUID = @UserGuid AND FriendGuid = @FriendGuid  )
	begin
		SET @ErrorCode = 0
		GOTO EndProc
	end
	
	-- ????.
	DELETE FROM T_WaitFriend where GUID = @UserGuid AND FriendGuid = @FriendGuid  
	
	IF ( @@Error  <> 0 )
		SET @ErrorCode	= @@Error

	-- ? #BUG_FIX_20040421_03
	IF( @ErrorCode = 2 )
	BEGIN
		UPDATE T_FriendList SET Del=1 where GUID=@FriendGuid AND FriendGuid=@UserGuid
	END
	-- ? #BUG_FIX_20040421_03	

EndProc:

	Set		nocount off
	select @ErrorCode
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- Definition for stored procedure WZ_WriteMail : 
--

-- ??? ????.
/*
 return 
 
 2 : ?? ???? GUID? ???? ???.
 3 : ?? ???? ?? ???? ???? ? ? ??.
 4 : ??? ????? ????
 5 : ??? ?? ??? ?????.
 6 : ??? ?? 6 ???
 10 ?? : ??
*/
CREATE procedure [dbo].[WZ_WriteMail]
	@SendName 	varchar(10), 
	@RecvName 	varchar(10),
	@Subject	varchar(32),
	@Dir		tinyint,
	@Act		tinyint

as
BEGIN
	Set		nocount on 	

	DECLARE 	@userguid	int
	DECLARE 	@memocount	int
	DECLARE	@return		int
	DECLARE	@MemoTotal	int
	DECLARE 	@FriendLevel  	int

	SET	XACT_ABORT ON

	SET @return	= 0

	-- ?? ???? GUID? ???
	SELECT @userguid=GUID, @MemoTotal=MemoTotal FROM T_FriendMain where Name= @RecvName
	if( @@ROWCOUNT < 1 )
	BEGIN
		SET @return = 2
		GOTO EndProc
	END

	IF( @MemoTotal > 49 )
	BEGIN
		SET @return = 5
		GOTO EndProc
	END

	-- ??? ??? ???. 
	select  @FriendLevel=cLevel FROM Character where Name=@RecvName
	IF( @@Error <> 0 )
	  begin
		SET @return = 2		
		GOTO EndProc
	  end
	ELSE 
	  BEGIN
		-- ??? 6?? ??? 
		if( @FriendLevel < 6 )
		  begin
			SET @return = 6
			GOTO EndProc
		  end
	  END

	begin transaction

	-- ?? ???? ?? ??? ???.
	update T_FriendMain set @memocount = MemoCount = MemoCount+1, MemoTotal=MemoTotal+1 where Name = @RecvName
	if( @@error <> 0 )
	BEGIN
		SET @return = 3
		GOTO EndProcTran
	END	

		
	-- ??? ????.
	INSERT INTO T_FriendMail (MemoIndex, GUID, FriendName, wDate, Subject,bRead,  Dir,  Act) VALUES(@memocount,@userguid, @SendName, getdate(), @Subject, 0,  @Dir, @Act)
	if( @@error <> 0 )
	BEGIN
		SET @return = 4
		GOTO EndProcTran
	END

EndProcTran:
	if ( @return  <> 0 )
	begin	
		rollback transaction
	end 
	else
	begin
		commit transaction
		SET @return = @memocount
	end	
	
EndProc:
	SET	XACT_ABORT OFF
	Set		nocount off
	
	SELECT @return, @userguid
End
GO

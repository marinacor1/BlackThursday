require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_merchants_are_accessed_and_found_in_find_by_name
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")
    assert_equal "CJsDecor", merchant
  end

  def test_item_can_be_found_by_id_or_nil
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    merchant = se.merchants.find_by_id(10)
    assert_equal nil, merchant
  end

  def test_merchants_all_works
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.all
    all = ["Shopin1901", "Candisart", "MiniatureBikez", "LolaMarleys", "Keckenbauer", "perlesemoi", "GoldenRayPress", "jejum", "Urcase17", "BowlsByChris", "MotankiDarena", "TheLilPinkBowtique", "DesignerEstore", "SassyStrangeArt", "byMarieinLondon", "JUSTEmonsters", "Uniford", "thepurplepenshop", "handicraftcallery", "Madewithgitterxx", "JacquieMann", "TheHamAndRat", "Lnjewelscreation", "FlavienCouche", "VectorCoast", "BloominScents", "GJGemology", "MuttisStrickwaren", "CottonBeeWraps", "Snewzy", "ElisabettaComotto", "Hatsbybz", "Princessfrankknits", "WellnessNeelsen", "GiftOfFelt", "Corbeilwood", "Woodenpenshop", "esellermart", "LunaGuatemala", "FlyingLoaf", "TeeTeeTieDye", "TheAssemblyRooms", "BrattyGirlGems", "tmsDOM", "MomsTshirts", "justMstyle", "CERAMICANDCO", "outletEsteCeramiche", "RedefinedArt84", "ZazaBoutiqueShop", "charlottewithlove", "littledorisdesigns", "SLHandmades", "elkeyhandmade", "Soudoveshop", "dansoilpaintings", "McGillsMetalAndArt", "MMVinyl", "wholesalergemstones", "matthewbritts", "MadFineJewelryLine", "EkaterinaPa", "WroughtiesCustomIron", "fronishair", "Natsweet2015", "TheWoodchopDesign", "ToThePoints", "2MAKERSMARKET", "homiehandmade", "JewelrySpotByElaine", "DizzyUnicornDesigns", "WoodleyShop", "PegAwayPegBoards", "Jesuisunponey", "BLAISEPANDORA", "RRresale2016", "Witoldart", "IOleynikova", "MyZinglet", "Sikaf", "MisisJuliBebe", "leaburrot", "kiDsGarMenT", "EndlessCirclesHoops", "ExecutiveGiftShoppe", "TiffsOscPandora", "isincerely88", "FADIBEKA", "Frockettoya", "MaidichaToos", "MyouBijou", "CHALKLEYSWOODSHOP", "Hollipoop", "FrenchiezShop", "DenesDoorDecor", "OwlMuffs", "AnnaWilsonArt", "ElaineClausonArt", "Madefromresin", "DiscountDiva56", "TheKnitBySusie", "CECALInterior", "CANNATHERAPYCO", "SusansWearableArt", "ADMerinoUnknown", "charlottelinks", "EllGe", "HannahRDesign", "GranadaFotoBaby", "GrandpasOuthouse", "IconiqueDesign", "JAtkinsonPhotography", "CoastalCreations16", "RachelRonnieDesigns", "TrollSS", "Cashcollections", "MittenUpCanada", "TurkishHands", "HoggardWoodworks", "JustReallyCoolStuff", "BEEEPS", "KennyDeaneVinylArt", "KewtieKuddlers", "BORNinDUST", "iheartwooddecor", "ByAladdin", "memolecanterina", "TalleyLites", "Christiencollection2", "BLDesign502", "Interloodio", "DresEtchyDesigns", "aperfectmessCandleCo", "EvergladesTrashArt", "Mageenta", "CenTexCustomCoatings", "UleleKnitting", "VirginVirgo", "Project378Baby", "hendmadethings", "NERDGEEKs", "LeichtigkeitundLiebe", "StonenJade", "JustSprayPainted", "dvinebasketsbybrenda", "BarreSoHard", "PaulMagi", "CrochetHookTreasures", "deConstructors", "Blankiesandfriends", "metasstore", "Dickensinkprintables", "PlusEtsy", "LaserPerm", "Idagarden", "UpJoy", "AnyArtGlass", "AaliyahGraceBoutique", "TeriTrendyTreasures", "BGwoodenboxes", "JillyBeanNutButters", "kievbags", "MariQKdes", "BoutiqueEleanor", "SimchaCentralShop", "RULBAYO", "TheSequinnedOwl", "MacrameDreamerHome", "77PINS", "PaintedandWaxed", "STTUBCo", "Momentsmadeup", "JustBownAround", "EcnaDanceRoom", "JoyInStyle", "CustomStringFling", "FunGuardian", "Filaraky", "Ironwoodcreation", "GiveEmPropsStudio", "JamesCByrneART", "beautifulrabbit", "RetroBitsNBobs", "BerzerkBeesHoney", "ShopDixieChicken", "Necklacemaniac", "Quadrantes", "MrVintageFurniture", "TheLittleGlitter", "SewCwtch", "mountainfaithful", "BeBraveShop", "Impossiblemuseum", "WildFennelStudios", "STEPHSASSYSNAPS", "Elfsnfairies", "RedLipCustoms", "fasinatingvintage", "shescraftyinlondon", "OneLovePhotographyIN", "efiraz", "Yaktemi", "Zalory", "HooksforBooks", "SWISSIonenSchmuck", "ForTheLoveOfCop", "silvia2knit", "TinyHatsbyHG", "AdventureEmporium", "SublimAtelier", "DeLaHayePhotoArt", "Filofascination", "LibellaNovella", "TKDisenosUrbanos", "FrenchyTrendy", "dazzlingdivallc", "5Wbrand", "Annasuiizi", "HelmicksBeardOils", "GlassFigurineArt", "DressedInMusic", "ExpertCeramic", "shop20161", "HooknSpindle", "3DKlabouter", "FurnishingsReDefined", "GaLiHandmadeStore", "Beltsbywesley", "habichschon", "Craftynicnakss", "coolzish", "ShopTimeCreations", "craftyminxes", "Art2Livin", "LilLouises", "beadeliciousdarling", "MakosMomsBlanketShop", "Sewuniquedivas", "VickyDumont7", "ashleighpaynes", "Naturemania", "LanConPaintedGlass", "DenyleGuitars", "Cheerhairwear", "Plaisirsoie", "Fatamunas", "EudoraCrafts", "RussianGoodsLife", "SofiiaStrykovaArt", "HoloyBohoTinker", "Printsunlimited", "9LivesJewelry", "GrandmaRootHomesewn", "Mimisxx", "koobiekoos", "CoolArtPots", "Chemisonodimenticato", "MandyBlackShop", "NaturallyRewarding", "kikipt56", "babypantry", "bookandcraft", "InitialDesignsByT", "Lesettemeraviglie", "ArtDerbisheva", "BoDaisyClothing", "FairyTaleLetters09", "RusticCowgirl21", "twistedupwraps", "TIGHTpinch", "IvyMoonCat", "RosesGardening", "IsisMoonArtesanias", "PaperShowers", "HandmadeByKellyJ", "Teeforbeardedmen", "WhimsyandWill", "CosmicGemBoutique", "craftyk21", "OurBestiary", "LoganNortonPhotos", "FirlefanzFabrik", "emiluva", "retropostershop", "BeachComaUK", "DashaandSasha", "IronCompassFlight", "PatinationDesign", "PaytonsSupplies", "ShopAtPinkFlamingo", "JanetsGlassAndCraft", "DarbiDesigns", "CustomPatchesOnline", "LMNLArtstudio", "FehlingerGraphics", "Simplyprimitive1", "Duanesphotography", "Filiy", "SilhouetteandSwirl", "NaturePhotography23", "Braceyourselfs", "SignGuyMBandPA", "DejaVuelry", "MARTinaNOcreations", "WoolKnittingGranny", "LeatherMinn", "Trilquiz", "NaturesSudz", "newshoesnewyou", "SHOPAMO", "AgeofSplendor", "lunaticsarealive", "CrochetLoveMemories", "RoyalwoodsStudio", "PrismaticSaturation", "BlaaRose", "OdinsArmourSteel", "TopeebySardee", "AlchemyandRoot", "HeritageTribeDesigns", "SeeyouSoonthen", "SweetheartDarling", "KatesPlot", "Laboratori", "WhatTheDoctorOrdered", "ArgyllHandmadeGifts", "AslanZebra", "MikaMoos", "katieelizabethcrafts", "acidyoshi", "PhilPalmPhotography", "SewThumbsUp", "NoirAssassin", "IanLudiBoards", "MrsMechelleSingleton", "printomaniac", "BodyTropics", "DansCommodoties", "BarbarasEssentials", "JiltedGems", "sparetimecrocheter", "IntlMilitaryAntiques", "ElementalStars", "ivegreenleaves", "kawaiianshop", "MyProPrintStore", "ApplebyMetalArts", "MoussEssence", "ElisabettaPirola", "VIXU", "JOrganics", "DivineDesignCaroline", "IsauraIzquierdo", "MagistraRosie", "StatesmanLeather", "HBriggsPhotography", "SunshineBeads16", "LHCGlassCreations", "enchantmentproduct", "perfectbrooches", "BandCCeramics", "WickedlyGoodPotions", "carrettiecarriole", "alysagallery", "BrokenArrowSApparel", "WoodlandGroup", "RinyiDesign", "EtsyGB", "PretzelPrintables", "ArtfulCoasters", "ThreeHooksAndYarn", "twosquaredblocks", "RnRGuitarPicks", "PackingMonkey", "PipNSqueaks", "NicKnacItems", "KAMNAI", "Leidytba", "Bohopieces", "CuppersCandyWraps", "EccentriCollecting", "RigRanch", "RussSouvenirs", "LemonBeesign", "LilianCarlyle", "Moonamoor", "Bishopswoodcraft", "DosHippieChics", "MillieMacDougallArt", "SmellyHippieSoaps", "GalvanizedLighting", "SoftAngelGifts", "ThreadNeedleE", "LilacGypsylittles1", "MoxieCollection", "NicholasLeatherWorld", "Beads4U8", "CambodiaWood", "CynthiaOriginal", "safetygear", "SeguinotsFoxyStuff", "EcoFireplace", "MERCtextile", "MardiGras2016", "VintageCanvasPosters", "LivingArtspace", "ACWBanners", "MacDonaldWoodworks", "Kamyzz", "DecadentCreationsbyJ", "beadsbypj", "funtimeworkshop", "MattsNerdShoppe", "munkisoaptokens", "CastrosCrafts", "GowerHeritageCentre", "KhristinaArt", "KnicelyDoneByMichael", "MarkThomasJewelry", "HandSpiredCreations", "simoneri", "custommen", "MidnightOilCrochet", "AAIlustracionyFoto", "Shopkarissa", "ThatsSewMolley", "aperturi", "ColesChinaCabinet", "TheHairFader", "GriffithsArtService", "FullyFashionedKnits", "rakimagery", "southernncreations", "Miamousesbirdhouses", "KamLandSoapShop", "NerdyGear", "angelacandlesabeauty", "productsbynikole", "OceanSmells", "RanaParvaShop", "OffLeashJewelry", "DeschampsDesign", "Gracebythebook", "cirinosbloodymary", "Hannahrefaatdesign", "CAMsCustomArt", "HappyPrettyHome", "LittleGlamourBling", "MyDream89", "SouthernComfrtCndles", "TheCullenChronicles", "CadeauJudaica", "DivineLoveSigrun", "JewelleAccessories", "CurvaciousGlam", "thesageandspirit", "cristinpowersART", "Pillowtalkdartmoor", "MilestonesForBaby", "mugglifeyeg", "NicSueDesigns", "JaimeLeeLightleArt", "JillMariedesigns51", "Promotionalsearchltd", "CreativeBounty", "zuzulovevintage", "fancybookart", "GeorgiaFayeDesigns", "bizuteriaNYC", "LexKStyles", "HeadyMamaCreations", "LovesVariety", "CoetographyPrints", "cardsbymarykate", "CJsDecor"]
    assert_equal all, merchant
  end

  def test_merchant_find_id_works
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_id('12334105')
    assert_equal "Shopin1901", merchant
  end

  def test_merchant_find_id_returns_nil_for_wrong_id
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_by_id('12335')
    assert_equal nil, merchant
  end

  def test_merchant_repo_finds_all_fragments_in_search
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_all_by_name('Mar')
    matches = ["LolaMarleys", "byMarieinLondon", "esellermart", "2MAKERSMARKET", "MariQKdes", "GrandmaRootHomesewn", "MARTinaNOcreations", "MardiGras2016", "MarkThomasJewelry", "cirinosbloodymary", "CAMsCustomArt", "JillMariedesigns51", "cardsbymarykate"]
    assert_equal matches, merchant
  end

  def test_merchant_repo_finds_empty_array_if_wrong_fragment
    hash = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    se = SalesEngine.from_csv(hash)
    mr = se.merchants
    merchant = mr.find_all_by_name('xxxyx')
    assert_equal [], merchant
  end

end

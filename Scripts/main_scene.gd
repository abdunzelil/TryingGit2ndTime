
# File: MainScene.gd
extends Node2D
var Card = preload("res://Scripts/card.gd")
# Array to hold card instances
var cards = []
var adventureQuestCards = []
var current_card = null
var temp_card = null
var scores = {"Health": 50, "Mana": 70, "Gold": 50, "Strength": 50}
var specialItems = {"Gemstone": false, "Tılsım": false}
var optionAjustPressed = false
var optionBjustPressed = false

func _ready():
	# Initialize card instances
	initialize_cards()
	# Display a random card at the start
	#show_random_card()
	update_card_display()

func initialize_cards():
	var adventureQuestInitial = Card.new() # adventureQuestCards[0]
	adventureQuestInitial.image = load("res://images/adventureQuestInitial.jpg")
	adventureQuestInitial.story_text = "Ekiple tanıştın ve gideceğiniz yere karar vermeniz lazım."
	adventureQuestInitial.option_a_text = "Şehrin uzağındaki ormanlara"
	adventureQuestInitial.option_a_effects = {}
	adventureQuestInitial.option_b_text = "Sınırdaki terk edilmiş kiliseye"
	adventureQuestInitial.option_b_effects = {} 
	adventureQuestCards.append(adventureQuestInitial)
	
	var adventureQuestForest1 = Card.new() 
	adventureQuestForest1.image = load("res://images/adventureQuestForest1.jpg")
	adventureQuestForest1.story_text = "Ormanlarda dolaşırken ekip arkadaşlarınla birlikte ağaçların arasından bir ışık geldiğini görüyorsunuz."
	adventureQuestForest1.option_a_text = "Işığa doğru ilerleyelim"
	adventureQuestForest1.option_a_effects = {}
	adventureQuestForest1.option_b_text = "Şehre geri dönme vakti geldi"
	adventureQuestForest1.option_b_effects = {} 
	adventureQuestCards.append(adventureQuestForest1)
	
	var adventureQuestForest2 = Card.new() 
	adventureQuestForest2.image = load("res://images/adventureQuestForest2.jpg")
	adventureQuestForest2.story_text = "Işığa doğru yürüdünüz ve ormanın ruhu karşınızda! Ne yapacaksınız?"
	adventureQuestForest2.option_a_text = "Onu selamlayalım"
	adventureQuestForest2.option_a_effects = {}
	adventureQuestForest2.option_b_text = "Saldırın!"
	adventureQuestForest2.option_b_effects = {} 
	adventureQuestCards.append(adventureQuestForest2)
	
	var adventureQuestForestGreet = Card.new() 
	adventureQuestForestGreet.image = load("res://images/adventureQuestForestGreet.jpg")
	adventureQuestForestGreet.story_text = "Ormanın ruhu kibar insanlar olmanızdan çok hoşnut oldu ve her birinizin mana ve dayanıklılığını tazeleyip sizlere birer ruh tılsımı verdi."
	adventureQuestForestGreet.option_a_text = "Teşekkürler!"
	adventureQuestForestGreet.option_a_effects = {"Mana": 50, "Strength": 50}
	adventureQuestForestGreet.option_b_text = "Harika!"
	adventureQuestForestGreet.option_b_effects = {"Mana": 50, "Strength": 50} 
	adventureQuestCards.append(adventureQuestForestGreet)
	
	var adventureQuestForestTılsım = Card.new() 
	adventureQuestForestTılsım.image = load("res://images/tılsım.jpg")
	adventureQuestForestTılsım.story_text = "Orman ruhunun hediyesi olan tılsım bir dahaki sefer manan veya dayanıklılığın tükendiğinde seni koruyacak."
	adventureQuestForestTılsım.option_a_text = "Vaay.."
	adventureQuestForestTılsım.option_a_effects = {}
	adventureQuestForestTılsım.option_b_text = "Harika!"
	adventureQuestForestTılsım.option_b_effects = {} 
	adventureQuestCards.append(adventureQuestForestTılsım)
	
	
	var gameOverCard = Card.new() # This card can be referenced by cards[0]
	gameOverCard.image = load("res://images/gameOver.jpg")
	gameOverCard.story_text = "Oyun bitti, kaybettin!."
	gameOverCard.option_a_text = "Ne..."
	gameOverCard.option_a_effects = {} # GEMSTONE SHOULD BE ADDED
	gameOverCard.option_b_text = "Olamaz..."
	gameOverCard.option_b_effects = {} # WE SHOULD BE CURSED!
	cards.append(gameOverCard)
	
	var skeletonCard = Card.new() # This card can be referenced by cards[1]
	skeletonCard.image = load("res://images/image14.jpg")
	skeletonCard.story_text = "Harabelerin içinde bir iskelet!."
	skeletonCard.option_a_text = "Saldır!"
	skeletonCard.option_a_effects = {"Gold": 15, "Health": -10, "Mana": -10} 
	skeletonCard.option_b_text = "Kaçalım!"
	skeletonCard.option_b_effects = {"Strength": -10} 
	cards.append(skeletonCard)
	
	var trollCard = Card.new() # This card can be referenced by cards[2]
	trollCard.image = load("res://images/troll.jpg")
	trollCard.story_text = "Mağaraya girdin ve troll kapı ağzını kapatmış. Ne yapacaksın?"
	trollCard.option_a_text = "Büyü gücüyle savaş."
	trollCard.option_a_effects = {"Gold": 20, "Mana": -15, "Health": -15} 
	trollCard.option_b_text = "Bileğine güven."
	trollCard.option_b_effects = {"Gold": 20, "Strength": -15, "Health": -15} 
	cards.append(trollCard)
	
	var krakenCard = Card.new() # This card can be referenced by cards[3] - 
	krakenCard.image = load("res://images/kraken.jpg")
	krakenCard.story_text = "Deniz analarının arkadaşlarını kurtarmak pek de kolay olmayacak gibi, kendine güveniyor musun?"
	krakenCard.option_a_text = "Bunca zaman ne için çalıştım? Savaş!"
	krakenCard.option_a_effects = {"Mana": -25, "Health": -25} 
	krakenCard.option_b_text = "Vazgeç."
	krakenCard.option_b_effects = {} 
	cards.append(krakenCard)
	
	var gemstoneCard = Card.new() # This card can be referenced by cards[4] - 
	gemstoneCard.image = load("res://images/gemstoneCard.jpg")
	gemstoneCard.story_text = "Deniaz analarının sana ödülü olan değerli taş bir dahaki sefer canın tükendiğinde oyunu kaybetmeni engelleyecek."
	gemstoneCard.option_a_text = "Teşekkürler."
	gemstoneCard.option_a_effects = {} 
	gemstoneCard.option_b_text = "Bunu hak ettim."
	gemstoneCard.option_b_effects = {} 
	cards.append(gemstoneCard)
	
	var gemstoneSavedYou = Card.new() # This card can be referenced by cards[5] - 
	gemstoneSavedYou.image = load("res://images/gemstoneSavedYou.jpg")
	gemstoneSavedYou.story_text = "Canın tükendi ancak vakti zamanında deniz analarına yardım ederek kazandığın yakut seni ölmekten kurtardı. Oyuna devam edebilirsin."
	gemstoneSavedYou.option_a_text = "Devam et."
	gemstoneSavedYou.option_a_effects = {"Health": 50} 
	gemstoneSavedYou.option_b_text = "Dikkatli olmalıyım."
	gemstoneSavedYou.option_b_effects = {"Health": 50} 
	cards.append(gemstoneSavedYou)
	
	# THERE ARE 5 SPECIAL STORY CONTINUIATION CARDS AND BELOW CARD HAS INDEX = 6 --> CARDS[6]
	var kingLikedYou = Card.new() # This card can be referenced by cards[6]
	kingLikedYou.image = load("res://images/king.jpg")
	kingLikedYou.story_text = "Kral şehir çevresinde güvenliği artırmak için pek çok ekibi görevlendirmeye başlamış ve verilen görevleri tamamlayanlara güzel bir ödül var."
	kingLikedYou.option_a_text = "Maceraya katıl!"
	kingLikedYou.option_a_effects = {}
	kingLikedYou.option_b_text = "Hiç halim yok..."
	kingLikedYou.option_b_effects = {} 
	cards.append(kingLikedYou)
	
	var card1 = Card.new() # This card can be referenced by cards[7]
	card1.image = load("res://images/image1.jpg")
	card1.story_text = "Bir hazine sandığı!"
	card1.option_a_text = "Aç!"
	card1.option_a_effects = {"Gold": 20, "Mana": 20}
	card1.option_b_text = "Boş ver."
	card1.option_b_effects = {}
	cards.append(card1)

	var card2 = Card.new()
	card2.image = load("res://images/image2.jpg")
	card2.story_text = "Ormanda devasa bir yaratık karşına çıktı!"
	card2.option_a_text = "Savaş!"
	card2.option_a_effects = {"Health": -15, "Mana": -10, "Gold": 30}
	card2.option_b_text = "Kaç!"
	card2.option_b_effects = {"Strength": -10}
	cards.append(card2)

	var card3 = Card.new()
	card3.image = load("res://images/image3.jpg")
	card3.story_text = "Bir tüccar sana bir miktar altın karşılığında zırh satmayı teklif ediyor."
	card3.option_a_text = "Kabul et."
	card3.option_a_effects = {"Gold": -10, "Strength": 10}
	card3.option_b_text = "Reddet."
	card3.option_b_effects = {"Strength": -5}
	cards.append(card3)
	
	var card4 = Card.new()
	card4.image = load("res://images/image4.jpg")
	card4.story_text = "İki goblin yolunu kesiyor ve kılıçlarını sallayarak biraz paraya ihtiyaçları olduğunu söylüyorlar."
	card4.option_a_text = "Hırsızlara para yok!"
	card4.option_a_effects = {"Health": -10, "Mana": -10, "Strength": -10}
	card4.option_b_text = "İstediklerini verelim gitsin."
	card4.option_b_effects = {"Gold": -20}
	cards.append(card4)
	
	var card5 = Card.new() # Mermaid story beginning card
	card5.image = load("res://images/image5.jpg")
	card5.story_text = "Deniz analarıyla karşılaştın ve arkadaşlarını dev bir ahtapotun hapsettiğini söylediler. Onlara yardım edecek misin?"
	card5.option_a_text = "Deniz analarına yardım et."
	card5.option_a_effects = {}
	card5.option_b_text = "Salla."
	card5.option_b_effects = {} 
	cards.append(card5)
	
	var card6 = Card.new()
	card6.image = load("res://images/image6.jpg")
	card6.story_text = "Ormanda bir sihirbazla karşılaştın. Biraz mana ve altın karşılığında gücünü artıran bir büyü yapabileceğini söylüyor."
	card6.option_a_text = "Büyüyü yap!"
	card6.option_a_effects = {"Mana": -10, "Gold": -10, "Strength": 20} 
	card6.option_b_text = "İstemiyorum."
	card6.option_b_effects = {} 
	cards.append(card6)
	
	var card7 = Card.new()
	card7.image = load("res://images/image7.jpg")
	card7.story_text = "Emekli bir gladyatör ücret karşılığında savaş antrenmanı yapmayı teklif ediyor."
	card7.option_a_text = "Kabul et."
	card7.option_a_effects = {"Gold": -10, "Strength": 10} 
	card7.option_b_text = "Boş işler."
	card7.option_b_effects = {} 
	cards.append(card7)
	
	var card8 = Card.new()
	card8.image = load("res://images/image8.jpg")
	card8.story_text = "Sarayın cadısı gücünü hizmetine sunarsan mananı tazelemeyi teklif etti."
	card8.option_a_text = "Kabul et."
	card8.option_a_effects = {"Mana": 50, "Strength": -10} 
	card8.option_b_text = "Yok."
	card8.option_b_effects = {} 
	cards.append(card8)
	
	var card9 = Card.new()
	card9.image = load("res://images/image9.jpg")
	card9.story_text = "Yetimhaneden arkadaşın akşamüstü balık tutmaya gidecek ve seni de davet ediyor."
	card9.option_a_text = "Onunla balık tutmaya git."
	card9.option_a_effects = {"Health": 20, "Strength": 10} 
	card9.option_b_text = "Boş işlere vaktim yok."
	card9.option_b_effects = {} 
	cards.append(card9)
	
	var card10 = Card.new()
	card10.image = load("res://images/image10.jpg")
	card10.story_text = "Seni çok seven amcan şehirdeki yeni handa yemek yemek istiyor. Bilgeliğinden faydalanmak kulağa hoş gelse de hanın menüsü biraz pahalı duruyor."
	card10.option_a_text = "Amcamın bilgeliğinden faydalanmalıyım."
	card10.option_a_effects = {"Gold": -10, "Mana": 15} 
	card10.option_b_text = "Dışarıda yemeğe para veremem."
	card10.option_b_effects = {} 
	cards.append(card10)
	
	var card11 = Card.new()
	card11.image = load("res://images/image11.jpg")
	card11.story_text = "Ormanda bir mağaraya rastlıyorsun. Kapısında 'İçeride kesinlikle çok fazla altını olan bir troll kalmıyor.' yazıyor."
	card11.option_a_text = "Altınların şıkırtısını duyabiliyorum. İçeri!"
	card11.option_a_effects = {} 
	card11.option_b_text = "Ormanda gezintiye devam et."
	card11.option_b_effects = {"Health": 10} 
	cards.append(card11)
	
	var card12 = Card.new()
	card12.image = load("res://images/image12.jpg")
	card12.story_text = "Kasabanın kahvehanesinde biraz kart oyunu oynamaya ne dersin?."
	card12.option_a_text = "Hadi biraz para kazanalım!"
	card12.option_a_effects = {"Gold": randi_range(-15, 15)} 
	card12.option_b_text = "Boş ver."
	card12.option_b_effects = {} 
	cards.append(card12)
	
	var card13 = Card.new()
	card13.image = load("res://images/image13.jpg")
	card13.story_text = "köyden uzaklaşmak için gezintiye çıkmıştın ve yıkık dökük bir yer buldun."
	card13.option_a_text = "İçeri bir bakalım."
	card13.option_a_effects = {"Gold": randi_range(-15, 15)} 
	card13.option_b_text = "Uzaklaş."
	card13.option_b_effects = {} 
	card13.next_card_index = 14
	cards.append(card13)
	
var rng = RandomNumberGenerator.new()

func update_card_display():
	if (scores.get("Health") <= 0 and specialItems["Gemstone"] == true):
		current_card = cards[5]
	elif (scores.get("Health") <= 0 or scores.get("Gold") <= 0 or scores.get("Mana") <= 0 or scores.get("Strength") <= 0):
		$ImageCard.texture = cards[0].image
		$Labels/Story.text = cards[0].story_text
		$"Option Buttons/OptionA".text = cards[0].option_a_text
		$"Option Buttons/OptionB".text = cards[0].option_b_text
		await get_tree().create_timer(4).timeout
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
	else:
		temp_card = current_card
		if current_card == null: # Oyunun başında
			current_card = cards[randi_range(6, cards.size() - 1)]
			
		# every card is indexed by cardx > cards[x+4] -- UPDATE HERE WHEN NECESSARY
		if current_card == cards[19] and optionAjustPressed: # Skeleton mini-story
			current_card = cards[1]
		if current_card == cards[17] and optionAjustPressed: # Troll mini-story
			current_card = cards[2]
		if current_card == cards[6] and optionAjustPressed: # King Adventure mini-story is beignning
			current_card = adventureQuestCards[0]
		elif current_card == adventureQuestCards[0] and optionAjustPressed: # King Adventure mini-story is continued with forest
			current_card = adventureQuestCards[1]
		elif current_card == adventureQuestCards[1] and optionAjustPressed: # King Adventure orman ruhu ile karşılaşıldı
			current_card = adventureQuestCards[2]
		elif current_card == adventureQuestCards[2]: # King Adventure orman ruhu selamlandı
			current_card = adventureQuestCards[3]
		elif current_card == adventureQuestCards[3]: # King Adventure orman ruhundan tılsım alındı
			current_card = adventureQuestCards[4]
			specialItems["Tılsım"] = true
		if current_card == cards[11] and optionAjustPressed: # Mermaid mini-story
			current_card = cards[3]
		elif current_card == cards[3] and optionAjustPressed: # Mermaid mini-story ---> getting the gemstone
			current_card = cards[4]
			specialItems["Gemstone"] = true
		while (current_card == temp_card): # Bir önceki kartla aynı çıkmaması kontrolü
			current_card = cards[randi_range(6, cards.size() - 1)]
		
	showSpecialItems()
	$ImageCard.texture = current_card.image
	$Labels/Story.text = current_card.story_text
	$"Option Buttons/OptionA".text = current_card.option_a_text
	$"Option Buttons/OptionB".text = current_card.option_b_text
	optionAjustPressed = false
	optionBjustPressed = false

func showSpecialItems():
	if (specialItems["Gemstone"] == true):
		$Gemstone.visible = true
	if (specialItems["Tılsım"] == true):
		$Tılsım.visible = true
	
func _on_optionA_pressed():
	apply_effects(current_card.option_a_effects)
	optionAjustPressed = true
	update_card_display()

func _on_option_b_pressed():
	apply_effects(current_card.option_b_effects)
	optionBjustPressed = true
	update_card_display()

func apply_effects(effects):
	for key in effects.keys():
		scores[key] += effects[key]
	update_score_display()

func update_score_display():
	if ($Labels/Health.text != str(scores["Health"])):
		pass
	$Labels/Health.text = str(scores["Health"])
	$Labels/Mana.text = str(scores["Mana"])
	if ($Labels/Gold.text != str(scores["Gold"])):
		$Labels/Gold/AnimationPlayer.play("glow")
	$Labels/Gold.text = str(scores["Gold"])
	$Labels/Strength.text = str(scores["Strength"])
	
	



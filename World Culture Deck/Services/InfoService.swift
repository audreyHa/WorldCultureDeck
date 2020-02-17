//
//  InfoService.swift
//  World Culture Deck
//
//  Created by Audrey Ha on 2/2/20.
//  Copyright © 2020 AudreyHa. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct InfoService{
    static func setUpCompletedCountries(){
        let completedCountryRef=Database.database().reference().child("users").child(User.current.uid).child("Completed Countries")
        print("completedCountryRef")
        completedCountryRef.setValue(["Some Country":false]){(error, _) in
            if let error=error{
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    static func insertAllCountryInfo(){
        
        let allCountriesRef=Database.database().reference().child("countryInfo")
        let allInfoArray: [String:[String:[String:[String:[String:String]]]]]=["South Korea":["Text":
                            ["Clothing":["zero":["zero":"The Hanbok is the traditional Korean dress.",
                                            "one":"Currently, the Hanbok is only worn for special occasions (birthdays, weddings, funerals) or Korean holidays."],
                                         "one":["zero":"For men, a full Hanbok has a vest and pants.",
                                            "one":"For women, the full Hanbok has a fitted top jacket, undershirt, and a wide, flexible skirt. Hanboks for women resemble a bell shape."]],
                             "Music":["zero":["zero":"In the K-Pop (Korean pop music) world, BTS is one of the most famous K-pop groups. BTS has hit #1 on iTunes in more than 65 countries, and they’re the first K-pop group to top U.S. music album charts.",
                                         "one":"Some of the key factors of BTS’s success are their impressives dance routines and creative music videos. Their songs include topics like bullying and mental health, which other bands may not cover."]],
                             "Art":["zero":["zero":"Paintings during the early Joseon dynasty (1400s) were similar to the Chinese style of peaceful landscapes",
                             "one":"In the later Joseon dynasty, paintings transitioned towards realism. In the 1700s, one of the great Korean artists was Kim Hong-do who often illustrated the day-to-day activities of ordinary people. Directly above is Ssireum, one of Kim Hong-do’s paintings, illustrating Korean wrestlers along with their spectators."]],
                             "Fun Facts":["zero":["zero":"Bulgogi is a common sweet meat that’s been in Korea for thousands of years.",
                                        "one":"Galbi or Korean barbeque is thick meat marinated in a soy sauce, garlic, and sugar mixture. Galbi is grilled over a fire and is a staple of Korean culture."]]
                            ], //end of South Korea text
                                                      "ImageNames":[
                            "Clothing":[
                                "zero":["zero":"koClothing1","one":"koClothing2"],
                                "one":["zero":"koClothing3","one":"koClothing4"]],
                            "Music":[
                                "zero":["zero":"koMusic1","one":"koMusic2"]],
                            "Art":[
                                "zero":["zero":"koArt1","one":"koArt2"]],
                            "Fun Facts":[
                                "zero":["zero":"koFood1","one":"koFood2"]]
                            ] //end of South Korea images
                        ], //end of all South Korea content
            "Tonga":["Text":
                ["Clothing":["zero":["zero":"A traditional Tongan clothing item is a tupenu, which is a cloth wrapped around the waist, often with bright designs of animals or plants.",
                                "one":"For men, the Tupenu must cover the knees and shins and any shirt can go above the tupenu. For women, the tupenu must reach the ankle and women wear a long overblouse called a kofu."],
                             "one":["zero":"For formal occasions, men and women can wear a ta’ovala or woven mat on top of the tupenu.",
                                "one":"Ta’ovala waist mats are often precious family heirlooms and traditional forms of wealth. Nobles and monarchs in particular have finely woven mats passed down through generations."]],
                 "Music":["zero":["zero":"Traditional songs have been passed down through generations and are sung at ceremonies",
                             "one":"Methodism is one of the most prominent religions in Tonga. Early hymns introduced by missionaries are still sung in Tongan churches."],
                          "one":["zero":"Me’etu’upaki is a popular paddle dance where the dancers carry paddles with paintings or carvings of abstract human body patterns.","one":"Other Ancient dances still performed today are ula and ‘otuhaka. Dances are a critical part of ceremonies, both on the national and village level."]],
                 "Art":["zero":["zero":"Traditionally, Tongan women made ta’ovala (waist mats), kiekie (string skirts), floor mats, and other traditional dance clothing.",
                 "one":"These woven mats had everyday uses and ceremonial uses. "],
                        "one":["zero":"For traditional men’s crafts, most objects like dishes and weapons were made of carved wood before Western contact.","one":"Tongan craftsmen were skilled at creating canoes, and the canoes used daily were called popaos or dug-out canoes"]],
                 "Fun Facts":["zero":["zero":"Sapasui is made of thin, long clear noodles mixed with mutton, beef, or pork with vegetables and soy sauce.",
                            "one":"Otai is a popular drink with watermelon or green mango blended into coconut milk, with sugar and ice"]]
                ], //end of Tonga text
                                          "ImageNames":[
                "Clothing":[
                    "zero":["zero":"tongaClothing1","one":""],
                    "one":["zero":"tongaClothing3","one":""]],
                "Music":[
                    "zero":["zero":"","one":"tongaMusic2"],
                    "one":["zero":"tongaMusic3","one":""]],
                "Art":[
                    "zero":["zero":"tongaArt1","one":""],
                    "one":["zero":"tongaArt3","one":"tongaArt4"]],
                "Fun Facts":[
                    "zero":["zero":"tongaFood1","one":"tongaFood2"]]
                ] //end of Tonga images
            ],//end of all Tonga content
            "Ghana":["Text":
                ["Clothing":["zero":["zero":"The Ghanaian smock made of Kente cloth is the national dress of Ghana.",
                                "one":"Hand-loomed strips of dyed and undyed cotton are sewn together to make a plaid shirt. The Akan and Ewe people are known for making the Kente cloth, and it’s worn for special occasions."],
                             "one":["zero":"For day-to-day occasions, women typically wear headwraps and vibrant long skirts or long dresses.",
                                "one":"Men typically wear a smock on top of pants along with plastic sandals. "]],
                 "Art":["zero":["zero":"Art in Ghana includes pottery, wood carving, gold and silverwork, and weaving kente cloth.",
                             "one":"Wood carving is a traditional Ghanaian art form, creating objects such as stools, drums, human figurines, and animals."],
                          "one":["zero":"There are craft villages throughout the country that create traditional arts.",
                                 "one":"The most prominent craft villages in Ghana are Bonwire (kente cloth), Ntonso (Adinkra cloth), Kurofuforum (brass figures), and Ahwiaa (wood carving)."]],
                 "Music":["zero":["zero":"Traditional Ghanaian music is different in the savannas of Northern Ghana and coastal areas of Southern Ghana. ",
                                "one":"Northern music consists of melodies made with stringed instruments (the lute, goje fiddle), flute, horns, drums, and voice."],
                        "one":["zero":"Music along the Southern coast has multiple simultaneous rhythms that are played with drums, bells, and harmonized songs. ",
                               "one":"Ghanaian hip hop became popular in the late 1990s, and it was a mix of traditional African musical sounds and hip hop."]],
                 "Fun Facts":["zero":["zero":"Fufu is spicy tomato soup with a paste made of cassava and plantains.",
                                      "one":"Waakye is a popular food in Ghana that mixes together beans and rice. It was from the North, but Waakye is now popular in various cities across Ghana."]]
                ], //end of Ghana text
                                          "ImageNames":[
                                          "Clothing":[
                                              "zero":["zero":"ghanaClothing1","one":"ghanaClothing2"],
                                              "one":["zero":"","one":"ghanaClothing4"]],
                                          "Music":[
                                              "zero":["zero":"ghanaMusic1","one":"ghanaMusic2"],
                                              "one":["zero":"ghanaMusic3","one":"ghanaMusic4"]],
                                          "Art":[
                                              "zero":["zero":"ghanaArt1","one":"ghanaArt2"],
                                              "one":["zero":"","one":"ghanaArt4"]],
                                          "Fun Facts":[
                                              "zero":["zero":"ghanaFood1","one":"ghanaFood2"]]
                                          ] //end of Ghana images
            ], //end of all Ghana content
            "Lebanon":["Text":
                ["Clothing":["zero":["zero":"Traditional clothing for women consists of long dresses with long sleeves, vests made of satin/silk/cotton, cloaks or scarves, and occasionally baggy pants.",
                                "one":"Traditional clothes for men consists of dark baggy trousers, a white shirt, a dark vest, a red/black belt, and a headdress."],
                             "one":["zero":"Today, almost all Lebanese wear modern clothing and traditional clothing is worn more in the countryside.",
                                "one":"One traditional Lebanese headdress for women is the tantur, which is a tall cone with a piece of silk attached to the top. The tantur was traditionally worn by women who recently married."]],
                 "Music":["zero":["zero":"The lute is a traditional Lebanese string instrument, with a short neck and the shape of half a pear.",
                             "one":"The mijwiz is a popular reed clarinet played by breathing through a circular opening and covering holes with the fingers. "],
                          "one":["zero":"The daf is an instrument similar to the tambourine, with goat or fish skin covering the round frame.",
                                 "one":"The tablah or durbakke is a common hand drum, often decorated with wood, tiles, metal, or paintings. Goat or fish skin is stretched over the top of the drum, which has a vase shape and wide opening."]],
                 "Art":["zero":["zero":"Beirut, Lebanon’s capital, is a popular city in the Arab world for artwork and literature.",
                                "one":"Lebanese architecture has influence from previous occupying groups like the Romans, Ottomans, Phoenicians, and French. The Renaissance also increased Italian influence on Lebanese architecture, with many streets having Italian-styled houses."]],
                 "Fun Facts":["zero":["zero":"People in Lebanon almost always eat with family or in a community.",
                                      "one":"Common foods in Lebanon include pita bread, rice, pasta, hummus (chickpea dip), fool (fava bean dip), and a variety of bean dishes."],
                              "one":["zero":"A popular food in Lebanon is tabbouleh.",
                                     "one":"Tabbouleh is a salad containing parsley, tomatoes, and cracked wheat or burghul."]]
                ], //end of Lebanon text
                                          "ImageNames":[
                                          "Clothing":[
                                              "zero":["zero":"lebanonClothing1","one":""],
                                              "one":["zero":"lebanonClothing3","one":""]],
                                          "Music":[
                                              "zero":["zero":"","one":"lebanonMusic2"],
                                              "one":["zero":"","one":"lebanonMusic4"]],
                                          "Art":[
                                              "zero":["zero":"lebanonArt1","one":"lebanonArt2"]],
                                          "Fun Facts":[
                                              "zero":["zero":"lebanonFood1","one":"lebanonFood2"],
                                              "one":["zero":"","one":"lebanonFood4"]]
                                          ] //end of Lebanon images
            ], //end of all Lebanon content
            "Mexico":["Text":
                ["Clothing":["zero":["zero":"Huipils are a traditional Mexican tunics originally worn by indigenous women in Mexico/Central America.",
                                "one":"Huipils often have ribbon, lace, and other colorful designs."],
                             "one":["zero":"Rebozos are a modern version of ancient Aztec cloak and can serve as a scarf, blouse, or cape if folded different ways.",
                                "one":"Huarache are sandals with roots in Mexico’s early tribal groups."]],
                 "Music":["zero":["zero":"Mariachi music is typically played at quinceaneras (a girl’s 15th birthday party) and on other celebrations.",
                             "one":"The Mariachi band usually has violins, trumpets, and guitars like the vihuela (5-stringed guitar). Musicians wear a traditional Charro suit."],
                          "one":["zero":"Ranchera music started in the ranches of rural Mexico.",
                                 "one":"It has songs about Mexican folklore, love, patriotism, and nature. It was particularly popular during the Mexican Revolution."]],
                 "Art":["zero":["zero":"Prominent in the city of Oaxaca, alebrijes are hand-painted sculptures of creatures.",
                                "one":"Alebrijes have vibrant colors and with carefully painted decorations and patterns."],
                        "one":["zero":"The city of Puebla is famous for its Talavera tiles.",
                               "one":"The tiles are made with clay from the Puebla region and are only painted with six natural colors."]],
                 "Fun Facts":["zero":["zero":"Chilaquiles are a popular breakfast dish with fried tortillas, eggs, pulled chicken, and green or red salsa.",
                                      "one":"Tacos al pastor are a variety of tacos, becoming popular in the 1920s-30s when Lebanese and Syrian immigrants arrived in Mexico. It contains a tortilla, pork strips, onion, and pineapple."]]
                ], //end of Mexico text
                                          "ImageNames":[
                                          "Clothing":[
                                              "zero":["zero":"mexicoClothing1","one":"mexicoClothing2"],
                                              "one":["zero":"mexicoClothing3","one":"mexicoClothing4"]],
                                          "Music":[
                                              "zero":["zero":"mexicoMusic1","one":"mexicoMusic2"],
                                              "one":["zero":"mexicoMusic3","one":"mexicoMusic4"]],
                                          "Art":[
                                              "zero":["zero":"mexicoArt1","one":"mexicoArt2"],
                                              "one":["zero":"mexicoArt3","one":"mexicoArt4"]],
                                          "Fun Facts":[
                                              "zero":["zero":"mexicoFood1","one":"mexicoFood2"]]
                                          ] //end of Mexico images
            ], //end of all Mexico content
            "Navajo Nation":["Text":
                ["Clothing":["zero":["zero":"Traditional clothes are typically worn only for special social occasions.",
                                "one":"Traditional Navajo clothing for women are pleated velvet/cotton skirts, a velvet blouse, a shawl, and deer moccasins. Men’s traditional clothing include velvet/cotton shirts, silver/turquoise jewelry, deer moccasins, and a headband."]],
                 "Music":["zero":["zero":"Traditional Navajo music is vocal with instruments like drums, rattles, the rasp, flutes, and whistles used as accompaniment. ",
                             "one":"Sacred holy songs detail stories or epics about religion or morality. All traditional songs have chants, but contemporary Navajo music has many genres (punk, metal, hip hop, rock, etc.)"]
                          ],
                 "Art":["zero":["zero":"In the middle of the 1800s, Navajos learned silversmithing techniques from the Spaniards and Mexicans.",
                                "one":"The Navajos used silver along with turquoise to create jewelry for ceremonies and religious rituals. Turquoise is particularly important to Navajos, as it represents water, sky, harvests, health, and protection."],
                        "one":["zero":"",
                        "one":"Navajos also make baskets for ceremonial purposes. These baskets are also used for household displays and wedding ceremonies."]
                      ],
                 "Fun Facts":["zero":["zero":"The Navajo Code Talkers saved countless lives during WW2.",
                                      "one":"The Code Talkers served in all 6 Marine divisions and spoke in the Diné language to effectively transmit classified information on battlefield strategies and orders."],
                              "one":["zero":"Without the Navajo Code Talkers, the Marines may not have been able to capture Iwo Jima.",
                                     "one":"While Morse code took hours to decipher, the Navajos could decode the message in minutes. The complexity of the Diné language made it ideal for transmitting important battlefield information."]]
                ], //end of Navajo Nation text
                                          "ImageNames":[
                                          "Clothing":[
                                              "zero":["zero":"navajoClothing1","one":"navajoClothing2"]],
                                          "Music":[
                                              "zero":["zero":"navajoMusic1","one":"navajoMusic2"]],
                                          "Art":[
                                              "zero":["zero":"navajoArt1","one":"navajoArt2"],
                                            "one":["zero":"","one":"navajoArt4"]],
                                          "Fun Facts":[
                                              "zero":["zero":"navajoCT1","one":"navajoCT2"],
                                              "one":["zero":"navajoCT3","one":"navajoCT4"]]
                                          ] //end of Navajo Nation images
            ], //end of all Navajo Nation content
            "Norway":["Text":
                ["Clothing":["zero":["zero":"Norway’s national clothing item is the bunad, which is a festival dress.",
                                "one":"The bunad is tight-fitting and made of wool. It’s often worn with silver jewellery, since silver is a culturally important material in Norway."],
                             "one":["zero":"Norwegians wear the bunad for Constitution Day, weddings, folk dances, and religious occasions.",
                                "one":"Bunads vary between regions and often showcase the culture and heritage of a particular town."]],
                 "Music":["zero":["zero":"Norwegian traditional dances are typically called bygdedans, which means village/regional dance. ",
                             "one":"Folk dances are usually done in couples and with 2 or 3 beat dances."],
                          "one":["zero":"Norway, Sweden, and Denmark, which neighbor each other, share the musical tradition of the fiddle instrument.",
                                 "one":"The Hardanger fiddle is prominent in Norwegian folk music, and this fiddle is similar to the violin."]],
                 "Art":["zero":["zero":"Norwegian art is full of medieval church paintings and Viking art. ",
                                "one":"There are many remnants of Viking art in Norway, including stone monuments in the countryside."],
                        "one":["zero":"In the 1800s, landscape painting became popular in Norway.",
                               "one":"Edvard Munch is one of the most prominent Norwegian artists, with his famous painting The Scream."]],
                 "Fun Facts":["zero":["zero":"From September to March, the northern lights or aurora borealis are visible from Northern Norway. ",
                                      "one":"The beautiful lights are filled with green, blue, pink, and violet."],
                              "one":["zero":"Norway has more than 1,000 fjords, and some of the fjords are World Heritage sites.",
                                     "one":"Fjords are still blue lakes with saltwater, typically with large cliffs on each side."]]
                ], //end of Norway text
                                          "ImageNames":[
                                          "Clothing":[
                                              "zero":["zero":"norwayClothing1","one":"norwayClothing2"],
                                              "one":["zero":"norwayClothing3","one":"norwayClothing4"]],
                                          "Music":[
                                              "zero":["zero":"","one":"norwayMusic2"],
                                              "one":["zero":"norwayMusic3","one":"norwayMusic4"]],
                                          "Art":[
                                              "zero":["zero":"","one":"norwayArt2"],
                                              "one":["zero":"norwayArt3","one":"norwayArt4"]],
                                          "Fun Facts":[
                                              "zero":["zero":"norwayFunFact1","one":"norwayFunFact2"],
                                              "one":["zero":"norwayFunFact3","one":"norwayFunFact4"]]
                                          ] //end of Norway images
            ], //end of all Norway content
            "Peru":["Text":
                ["Clothing":["zero":["zero":"The Montera is a traditional hat with a woven strap tying it under the chin",
                                "one":"Peruvians traditionally wear the Lliclla, which is a square of colorful, heavy woven cloth worn around the shoulders like a shawl."],
                             "one":["zero":"",
                                "one":"Polleras are traditional handwoven skirts made with bayeta cloth. These wide skirts are covered in multi-colored fabrics and designs vary by region."]],
                 "Music":["zero":["zero":"The Andean style of Peruvian music is known for flutes, panpipes, and wind instruments.",
                             "one":"Peruvian music has been influenced by indigenous music in the Andes Mountains, Spanish music, and African music. The national instrument in Peru is the charango and has influences from Spain’s vihuela string instrument. "]],
                 "Art":["zero":["zero":"A common artform among Peruvians is spinning and weaving cotton, llama, alpaca, and sheep wool to make cloth. Different villages have different weaving styles. ",
                                "one":"Chulucanas Pottery is popular in Northwestern Peru. This pottery form has Incan influences and is mostly black and white."]],
                 "Fun Facts":["zero":["zero":"The Amazon Rainforest--the largest rainforest in the world--covers roughly half of Peru",
                                      "one":"The Andes Mountains--the 2nd highest mountain range in the world--also cross through Peru."]]
                ], //end of Norway text
                                          "ImageNames":[
                                          "Clothing":[
                                              "zero":["zero":"PeruClothing1","one":"PeruClothing2"],
                                              "one":["zero":"","one":"PeruClothing4"]],
                                          "Music":[
                                              "zero":["zero":"PeruMusic1","one":"PeruMusic2"]],
                                          "Art":[
                                              "zero":["zero":"PeruArt1","one":"PeruArt2"]],
                                          "Fun Facts":[
                                              "zero":["zero":"PeruFunFact1","one":"PeruFunFact2"]]
                                          ] //end of Norway images
            ],
            "South Africa":["Text":
                ["Clothing":["zero":["zero":"South Africa is known for its diversity, with Black, White, Mixed, and Asian as the largest racial groups.",
                                "one":"The traditional clothes for the Zulus (ethnic group) consist of animal skins for the men and skirts embellished with beads for the women."],
                             "one":["zero":"Traditional clothes for the Xhosa (ethnic group) consist of shawls and capes.",
                                "one":"These shawls have detailed designs sewn onto them. Another Xhosa tradition is face-painting."]],
                 "Music":["zero":["zero":"South Africa has a multilingual national anthem celebrating its diverse culture: “Nkosi Sikelel’ iAfrica.”",
                             "one":"Popular genres in South Africa are kwaito (African house music), jazz, hip hop, Afrikaans rock, African gospel, and more."],
                          "one":["zero":"Zulu traditional dances have stomping on the ground, weapons, and shields.",
                                 "one":"Traditional Xhosa dances heavily involve group singing and clapping as an accompaniment to dancing. Instruments include mouth harps, rattles, whistles, flute, and stringed-instruments."]],
                 "Art":["zero":["zero":"The oldest African hunter-gatherers are the San Bushman and lived in South Africa’s Drakensberg mountains 4,000 years ago.",
                                "one":"The group painted a significant amount of art on cave and rock walls, creating sub-Saharan Africa’s largest collection of rock paintings."],
                        "one":["zero":"The Ndebele people are famous for their beadwork and murals on buildings.",
                               "one":"They initially used soot, ash, and clay for the mural colors, but colored paints are more widely used today. "]],
                 "Fun Facts":["zero":["zero":"South Africa has 11 official languages.",
                                      "one":"They include: Zulu, Xhosa, Afrikaans, English, Sepedi/Northern Sotho, Tswana, Southern Sotho, Venda, and Ndebele."],
                              "one":["zero":"Durban is an eastern South African coastal town.",
                                     "one":"Bunny Chow is a popular Durban street food with hollowed pieces of bread stuffed with spicy chicken/pork curry. It was first created by Durban’s immigrant Indian community."]]
                ], //end of South Africa text
                                          "ImageNames":[
                                          "Clothing":[
                                              "zero":["zero":"SAClothing1","one":"SAClothing2"],
                                              "one":["zero":"SAClothing3","one":"SAClothing4"]],
                                          "Music":[
                                              "zero":["zero":"SAMusic1","one":"SAMusic2"],
                                              "one":["zero":"SAMusic3","one":"SAMusic4"]],
                                          "Art":[
                                              "zero":["zero":"SAArt1","one":"SAArt2"],
                                              "one":["zero":"SAArt3","one":"SAArt4"]],
                                          "Fun Facts":[
                                              "zero":["zero":"","one":"SAFunFact2"],
                                              "one":["zero":"SAFunFact3","one":"SAFunFact4"]]
                                          ] //end of South Africa images
            ], //end of all South Africa content
            "Roma":["Text":
                ["Clothing":["zero":["zero":"The traditional clothing for Roma women in Finland includes a velvet skirt and long-sleeve blouse.",
                                "one":"Currently, many Roma women wear lighter skirts, and jewellery, typically gold jewellery, is an important aspect of the outfit."],
                             "one":["zero":"Roma men do not wear as many traditional clothes as Roma women.",
                                "one":"Currently, most Roma men wear straight trousers, a white/colored shirt, a jacket, and dark shoes."]],
                 "Music":["zero":["zero":"Romani music is typically based on the different folk musics of the region the Romani group is in. ",
                             "one":"Romani music is particularly popular in Hungary. In the 1948 Hungarian Revolution, Romani musical groups played for the soldiers for entertainment and morale."],
                          "one":["zero":"Romani music groups in Hungary played without scores, instead playing by ear.",
                                 "one":"Romani bands first had string instruments, the harp, and duda (bagpipe). Because of the influence of Western classical music, the bands started using violins, the cimbalom (string instrument), and double bass."]],
                 "Art":["zero":["zero":"Carved wooden designs on Roma wagons in England are a prominent art form.",
                                "one":"These wagon designs were famous worldwide, and have been created by Romani groups in other European countries."]],
                 "Fun Facts":["zero":["zero":"The Romani language has several different dialects and is considered an Indo-Aryan language with influences from Sanskrit, the ancient language of India.",
                                      "one":"The majority of Romani speak one of the dialects of the Romani language along with the language of the country they live in; most Romani are in Europe. The Romani people may also mix in words from the languages of the countries they reside in while speaking Romani. "]]
                ], //end of The Romani text
                                          "ImageNames":[
                                          "Clothing":[
                                              "zero":["zero":"romaniClothing1","one":""],
                                              "one":["zero":"romaniClothing3","one":""]],
                                          "Music":[
                                              "zero":["zero":"","one":"romaniMusic2"]],
                                          "Art":[
                                              "zero":["zero":"romaniArt1","one":"romaniArt2"]],
                                          "Fun Facts":[
                                              "zero":["zero":"","one":"romaniFunFact2"]]
                                          ] //end of The Romani images
            ] //end of all The Romani content
                    ]
                    
        
        allCountriesRef.setValue(allInfoArray){(error, _) in
            if let error=error{
                assertionFailure(error.localizedDescription)
            }
        }
        
        let quizInfoRef=Database.database().reference().child("quizInfo")
        let quizInfoArray: [String:[String:[String:Any]]]=[
        "Ghana":
        ["Quiz Questions":[
            "zero":["zero":"Kente is:","one":"  The traditional cloth of Ghana, used to make shirts/smocks","two":"  A prominent type of dance","three":"  A popular dish"],
            "one":["zero":"Wood carving is a traditional Ghanaian art form, used to create:","one":"  Stools","two":"  Drums","three":"  All of the above"],
            "two":["zero":"Fufu is a spicy tomato soup with a paste that contains:","one":"  Sweet potatoes and eggs","two":"  Soybeans","three":"  Cassava and plantains"]]],
        
        "Lebanon":
        ["Quiz Questions":[
            "zero":["zero":"Traditional clothes for men consist of:","one":"  Dark baggy trousers, white shirt","two":"  Dark Vest, red/black belt, headdress","three":"  All of the above"],
            "one":["zero":"The tablah, a hand drum… ","one":"  Is often decorated with wood, tiles, and metal","two":"  Has a narrow opening","three":"  Is not very popular in Lebanon"],
            "two":["zero":"People in Lebanon almost always eat… ","one":"  Noodles and dumplings","two":"  With family/in a community","three":"  Quesadillas and chilaquiles"]]],
        
        "Mexico":
        ["Quiz Questions":[
            "zero":["zero":"Huipils are:","one":"  A popular street food","two":"  Traditional Mexican tunics","three":"  Traditional Mexican shoes"],
            "one":["zero":"Alebrijes are hand-painted sculptures of creatures and are:","one":"  Vibrantly colored","two":"  Black and white","three":"  Red, Green, and White"],
            "two":["zero":"Which two are traditional Mexican music forms?","one":"  K-pop and Rock & Roll music","two":"  Blues and Hip Hop music","three":"  Mariachi and Ranchero music"]]],
        
        "Navajo Nation":
        ["Quiz Questions":[
        "zero":["zero":"Which gemstone is the most important in Navajo culture?","one":"  Rubies","two":"  Turquoise","three":"  Amethyst"],
        "one":["zero":"What did the Navajo Code Talkers do?","one":"  Transmit key battle info for the U.S. marines during WW2","two":"  Create the Diné language","three":"  Teach the Diné language in schools"],
        "two":["zero":"Navajo women’s traditional clothing includes:","one":"  Trousers and a vest","two":"  A smock made of Kente cloth","three":"  Velvet/cotton skirt, velvet blouse, deer moccasins"]]],
        
        "Norway":
        ["Quiz Questions":[
        "zero":["zero":"What is the bunad?","one":"  Norway’s traditional tight-fitting, wool dress","two":"  Norwegian traditional shoes","three":"  A type of folk dance"],
        "one":["zero":"Which instrument is prominent in Norwegian folk music?","one":"  The Hardanger fiddle","two":"  The Daegeum flute","three":"  The Djembe drum"],
        "two":["zero":"What landform is Norway famous for?","one":"  Deserts","two":"  Fjords","three":"  Volcanoes"]]],
        
        "Peru":
        ["Quiz Questions":[
        "zero":[
            "zero":"The Lliclla is:",
            "one":"  A square of colorful, heavy cloth worn as a shawl",
            "two":"  A traditional Peruvian hat",
            "three":"  Traditional pants"],
        "one":[
            "zero":"Peruvian music has the strongest influences from:",
            "one":"  Andean, Spanish, and African music",
            "two":"  Chinese, Indian, and Australian music",
            "three":"  Norweigan, Italian, and Swiss music"],
        "two":[
            "zero":"Roughly half of Peru is covered by:",
            "one":"  Lakes",
            "two":"  The Himalayan Mountains",
            "three":"  The Amazon Rainforest"]]],
        
        "South Africa":
        ["Quiz Questions":[
        "zero":["zero":"Xhosa (ethnic group) traditional clothing consists of:","one":"  Shawls and capes","two":"  Face painting","three":"  All of the above"],
        "one":["zero":"South Africa’s national anthem is sung in:","one":"  English","two":"  Afrikaans","three":"  5 different languages"],
        "two":["zero":"Sub-Saharan Africa’s largest collection of rock paintings is in:","one":"  Zambia","two":"  South Africa","three":"  Democratic Republic of the Congo"]]],
        
        "South Korea":
        ["Quiz Questions":[
        "zero":["zero":"For women, the Hanbok dress consists of what?","one":"  Pants and jeans","two":"  Fitted top jacket and wide, flexible skirt","three":"  Vest and pants"],
        "one":["zero":"What is the name of the most popular K-pop group?","one":"  KBS","two":"  ABC","three":"  BTS"],
        "two":["zero":"Which of the following are 2 types of Korean meat:","one":"  Kimchi and Bibimbap","two":"  Bulgogi and Galbi","three":"  Seoul and Busan"]]],
        
        "Roma":
        ["Quiz Questions":[
        "zero":["zero":"What is the traditional clothing for Roma women?","one":"  Shirt and trousers","two":"  Velvet or light skirt, long-sleeve blouse, jewellery","three":"  A single long dress"],
        "one":["zero":"The Romani originated from ______ and the majority currently reside in ______","one":"  Northern India, Europe","two":"  East Asia, America","three":"  Latin America, Europe"],
        "two":["zero":"Romani music groups in Hungary:","one":"  Played without sheet music, instead playing by ear","two":"  Became popular during the 1948 Hungarian Revolution","three":"  All of the above"]]],
        
        "Tonga":
        ["Quiz Questions":[
        "zero":["zero":"The traditional Tongan tupenu (cloth wrapped around waist) is worn:","one":"  Only special occasions","two":"  On weekends","three":"  Every day"],
        "one":["zero":"A Ta’ovala is a:","one":"  Floor mat","two":"  Waist mat worn for special occasions","three":"  Type of T-Shirt"],
        "two":["zero":"Traditional Tongan women’s crafts include:","one":"  Woven mats","two":"  Traditional dance clothing","three":"  All of the above"]]]]
        
        quizInfoRef.setValue(quizInfoArray){(error, _) in
            if let error=error{
                assertionFailure(error.localizedDescription)
            }
        }
        
        let countryBlurbsRef=Database.database().reference().child("Country Blurbs")
        let blurbsArray: [String:String]=[
            "Ghana":"Ghana is a country in Western Africa. Capital: Accra",
            "Lebanon":"Lebanon is a country in the Middle East, bordering the Mediterranean Sea. Capital: Beirut",
            "Mexico":"Mexico is a country in North America. Capital: Mexico City",
            "Navajo Nation":"Navajo Nation is an American Indian territory spanning 27,000+ square miles, covering parts of Utah, Arizona, and New Mexico.",
            "Norway":"Norway is a country in Northern Europe. Capital: Oslo",
            "Peru":"Peru is a country in South America. Capital: Lima",
            "South Africa":"South Africa is a country in Africa and has 3 capitals (Pretoria, Cape Town, and Bloemfontein) for different government branches.",
            "South Korea":"South Korea is a country in East Asia. Capital: Seoul",
            "Roma":"The Roma or Romani are an ethnic group mostly residing in Europe. The group is also known as G#psies, but many Romani consider this term to be a slur. 2-5 million Romani live worldwide.",
            "Tonga":"Tonga is a Polynesian country in the southwestern Pacific Ocean. It consists of 170+ islands. Capital: Nuku’alofa."]
        
        countryBlurbsRef.setValue(blurbsArray){(error, _) in
            if let error=error{
                assertionFailure(error.localizedDescription)
            }
        }
        
    }
}

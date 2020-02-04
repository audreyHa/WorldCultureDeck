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
    static func insertAllCountryInfo(){
        
        let allCountriesRef=Database.database().reference().child("countryInfo")
        let allInfoArray: [String:[String:[String:[String:[String:String]]]]]=["South Korea":["Text":
                            ["Clothing":["0":["0":"The Hanbok is the traditional Korean dress.",
                                            "1":"Most of today’s Hanboks follow the style of the Joseon Dynasty (1392-1897), but Hanboks existed as early as 1600 years ago."],
                                         "1":["0":"For men, a full Hanbok has a vest and pants.",
                                            "1":"For women, the full Hanbok has a fitted top jacket, undershirt, and a wide, flexible skirt. Hanboks for women resemble a bell shape."],
                                         "2":["0":"Currently, the Hanbok is only worn for special occasions or Korean holidays.",
                                            "1":"Children wear the Hanbok for their 1st birthday and adults wear it for their wedding or major family events like funerals."],
                                         "3":["0":"Hanboks are made using natural dyes, giving the dress more vibrant and deep colors compared to artificial dyes. ",
                                            "1":"Hair accessories, including hairpins or headbands, are often worn with the Hanbok."]],
                             "Music":["0":["0":"BTS is one of the most famous K-pop (Korean pop) groups. The band is made up of seven Korean singers: Jin, Suga, J-Hope, RM, Jimin, V, and Jungkook.",
                                         "1":"BTS has hit #1 on iTunes in more than 65 countries, and they’re the first K-pop group to top U.S. music album charts. BTS’s “Boy With Luv” Youtube video was the fastest Youtube video to ever hit 100 million views."],
                          
                                      "1":["0":"BTS’s songs include topics like bullying and mental health, which other bands may not cover.",
                                         "1":"Some of the key factors of BTS’s success are their impressives dance routines, creative music videos, and the topics in their songs."],
                          
                                      "2":["0":"Gugak, which directly translates to “national music,” refers to traditional Korean music, songs, dances, and ceremonial performances.",
                                         "1":"Buchaechum is the Korean fan dance, usually performed by female dancers holding fans with floral prints."],
                          
                                      "3":["0":"Of all Korean folk songs, Arirang is the most famous and important among Koreans.",
                                         "1":"Different regional and local communities have their own musical and lyrical variations of the song, showcasing the cultural diversity of Korea. The song is renowned for its beautiful, heart-rending melody."],
                                      "4":["0":"One of the most prominent Korean traditional instruments is the Daegeum flute. It’s a large, 31-inch transverse flute, traditionally used in court and folk music.",
                                         "1":"The Daegeum is made of bamboo and has a buzzing membrane that creates a distinct sound. It’s also used for modern classical music and movie scores."]],
                             "Art":["0":["0":"Calligraphy developed in Korea through cultural influences from China.",
                                       "1":"Calligraphy is the art of handwriting using ink and brush strokes. One of the most famous Korean calligraphers is Kim Jeong-hui, who developed his own style of calligraphy called “Chusa Style.”"],
                        
                                    "1":["0":"Paintings during the early Joseon dynasty (1400s) were similar to the Chinese style of peaceful landscapes",
                                       "1":"In the later Joseon dynasty, paintings transitioned towards realism. In the 1700s, one of the great Korean artists was Kim Hong-do who often illustrated the day-to-day activities of ordinary people. Directly above is Ssireum, one of Kim Hong-do’s paintings, illustrating Korean wrestlers along with their spectators."],
                                    "2":["0":"Korean pottery usually falls into 3 categories: Cheongja (blue-green celadon), Buncheong (stoneware), and Baekja (white porcelain).",
                                       "1":"Celadon blue-green pottery was mostly made during the Goryeo Dynasty (918-1392). "],
                                    "3":["0":"Buncheong was made by Goryeo potters after the end of the Goryeo Dynasty in 1392. This type of stone pottery has simple designs on the outside.",
                                       "1":"The white porcelain pottery was mainly from the Joseon Dynasty (1392-1910). The porcelain was typically covered with designs made with iron, copper, and cobalt."]],
                             "Food":["0":["0":"Kimchi is arguably the most classic of all Korean foods.",
                                        "1":"It is spicy, salty, and fermented cabbage mixed with some pepper, garlic, ginger, or scallion. At every restaurant and meal, Kimchi is usually available at the table."],
                                     "1":["0":"Bulgogi is a common sweet meat that’s been in Korea for thousands of years.",
                                        "1":"Galbi or Korean barbeque is thick meat marinated in a soy sauce, garlic, and sugar mixture. Galbi is grilled over a fire and is a staple of Korean culture."],
                                     "2":["0":"Bibimpap is a mixed bowl with rice, vegetables, rice, beef, egg, sesame oil, and chili paste for flavor.",
                                        "1":"Gimbap is a popular meal and street food. Vegetables, meat, eggs, and rice are rolled together in seaweed and then cut into bite sized circular pieces."]]
                            ], //end of South Korea text
                                                      "ImageNames":[
                            "Clothing":[
                                "0":["0":"koClothing1","1":"koClothing2"],
                                "1":["0":"koClothing6","1":"koClothing5"],
                                "2":["0":"koClothing3","1":"koClothing4"],
                                "3":["0":"koClothing7","1":""]],
                            "Music":[
                                "0":["0":"koMusicA","1":"koMusicB"],
                                "1":["0":"koMusicC","1":"koMusicD"],
                                "2":["0":"koMusic1","1":"koMusic2"],
                                "3":["0":"koMusic3","1":"koMusic4"],
                                "4":["0":"koMusic5","1":"koMusic6"]],
                            "Art":[
                                "0":["0":"koArt1","1":"koArt2"],
                                "1":["0":"koArt3","1":"koArt4"],
                                "2":["0":"koArt5","1":"koArt6"],
                                "3":["0":"koArt7","1":"koArt8"]],
                            "Food":[
                                "0":["0":"koFood1","1":"koFood2"],
                                "1":["0":"koFood3","1":"koFood4"],
                                "2":["0":"koFood5","1":"koFood6"]]
                            ] //end of South Korea images
                        ] //end of all South Korea info
                    ]
                    
        
        allCountriesRef.setValue(allInfoArray){(error, _) in
            if let error=error{
                assertionFailure(error.localizedDescription)
            }
        }
    }
}

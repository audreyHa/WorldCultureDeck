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
                            ["Clothing":["zero":["zero":"The Hanbok is the traditional Korean dress.",
                                            "one":"Most of today’s Hanboks follow the style of the Joseon Dynasty (1392-1897), but Hanboks existed as early as 1600 years ago."],
                                         "one":["zero":"For men, a full Hanbok has a vest and pants.",
                                            "one":"For women, the full Hanbok has a fitted top jacket, undershirt, and a wide, flexible skirt. Hanboks for women resemble a bell shape."],
                                         "two":["zero":"Currently, the Hanbok is only worn for special occasions or Korean holidays.",
                                            "one":"Children wear the Hanbok for their 1st birthday and adults wear it for their wedding or major family events like funerals."],
                                         "three":["zero":"Hanboks are made using natural dyes, giving the dress more vibrant and deep colors compared to artificial dyes. ",
                                            "one":"Hair accessories, including hairpins or headbands, are often worn with the Hanbok."]],
                             "Music":["zero":["zero":"BTS is one of the most famous K-pop (Korean pop) groups. The band is made up of seven Korean singers: Jin, Suga, J-Hope, RM, Jimin, V, and Jungkook.",
                                         "one":"BTS has hit #1 on iTunes in more than 65 countries, and they’re the first K-pop group to top U.S. music album charts. BTS’s “Boy With Luv” Youtube video was the fastest Youtube video to ever hit 100 million views."],
                          
                                      "one":["zero":"BTS’s songs include topics like bullying and mental health, which other bands may not cover.",
                                         "one":"Some of the key factors of BTS’s success are their impressives dance routines, creative music videos, and the topics in their songs."],
                          
                                      "two":["zero":"Gugak, which directly translates to “national music,” refers to traditional Korean music, songs, dances, and ceremonial performances.",
                                         "one":"Buchaechum is the Korean fan dance, usually performed by female dancers holding fans with floral prints."],
                          
                                      "three":["zero":"Of all Korean folk songs, Arirang is the most famous and important among Koreans.",
                                         "one":"Different regional and local communities have their own musical and lyrical variations of the song, showcasing the cultural diversity of Korea. The song is renowned for its beautiful, heart-rending melody."],
                                      "four":["zero":"One of the most prominent Korean traditional instruments is the Daegeum flute. It’s a large, 31-inch transverse flute, traditionally used in court and folk music.",
                                         "one":"The Daegeum is made of bamboo and has a buzzing membrane that creates a distinct sound. It’s also used for modern classical music and movie scores."]],
                             "Art":["zero":["zero":"Calligraphy developed in Korea through cultural influences from China.",
                                       "one":"Calligraphy is the art of handwriting using ink and brush strokes. One of the most famous Korean calligraphers is Kim Jeong-hui, who developed his own style of calligraphy called “Chusa Style.”"],
                        
                                    "one":["zero":"Paintings during the early Joseon dynasty (1400s) were similar to the Chinese style of peaceful landscapes",
                                       "one":"In the later Joseon dynasty, paintings transitioned towards realism. In the 1700s, one of the great Korean artists was Kim Hong-do who often illustrated the day-to-day activities of ordinary people. Directly above is Ssireum, one of Kim Hong-do’s paintings, illustrating Korean wrestlers along with their spectators."],
                                    "two":["zero":"Korean pottery usually falls into 3 categories: Cheongja (blue-green celadon), Buncheong (stoneware), and Baekja (white porcelain).",
                                       "one":"Celadon blue-green pottery was mostly made during the Goryeo Dynasty (918-1392). "],
                                    "three":["zero":"Buncheong was made by Goryeo potters after the end of the Goryeo Dynasty in 1392. This type of stone pottery has simple designs on the outside.",
                                       "one":"The white porcelain pottery was mainly from the Joseon Dynasty (1392-1910). The porcelain was typically covered with designs made with iron, copper, and cobalt."]],
                             "Food":["zero":["zero":"Kimchi is arguably the most classic of all Korean foods.",
                                        "one":"It is spicy, salty, and fermented cabbage mixed with some pepper, garlic, ginger, or scallion. At every restaurant and meal, Kimchi is usually available at the table."],
                                     "one":["zero":"Bulgogi is a common sweet meat that’s been in Korea for thousands of years.",
                                        "one":"Galbi or Korean barbeque is thick meat marinated in a soy sauce, garlic, and sugar mixture. Galbi is grilled over a fire and is a staple of Korean culture."],
                                     "two":["zero":"Bibimpap is a mixed bowl with rice, vegetables, rice, beef, egg, sesame oil, and chili paste for flavor.",
                                        "one":"Gimbap is a popular meal and street food. Vegetables, meat, eggs, and rice are rolled together in seaweed and then cut into bite sized circular pieces."]]
                            ], //end of South Korea text
                                                      "ImageNames":[
                            "Clothing":[
                                "zero":["zero":"koClothing1","one":"koClothing2"],
                                "one":["zero":"koClothing6","one":"koClothing5"],
                                "two":["zero":"koClothing3","one":"koClothing4"],
                                "three":["zero":"koClothing7","one":""]],
                            "Music":[
                                "zero":["zero":"koMusicA","one":"koMusicB"],
                                "one":["zero":"koMusicC","one":"koMusicD"],
                                "two":["zero":"koMusic1","one":"koMusic2"],
                                "three":["zero":"koMusic3","one":"koMusic4"],
                                "four":["zero":"koMusic5","one":"koMusic6"]],
                            "Art":[
                                "zero":["zero":"koArt1","one":"koArt2"],
                                "one":["zero":"koArt3","one":"koArt4"],
                                "two":["zero":"koArt5","one":"koArt6"],
                                "three":["zero":"koArt7","one":"koArt8"]],
                            "Food":[
                                "zero":["zero":"koFood1","one":"koFood2"],
                                "one":["zero":"koFood3","one":"koFood4"],
                                "two":["zero":"koFood5","one":"koFood6"]]
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

//
//  ContentView.swift
//  Split in half
//
//  Created by ab86008 on 2022-04-08.
//

import SwiftUI

struct ContentView: View {
    

    @State var textInput = ""
    @State var textOutput = ""
    @State var wordCount1:Int?
    @State var wordCount2:Int?
    
    @State var row1 = ""
    @State var row2 = ""
    
    
    struct Splitter {
        
        enum WordErrors : Error {
            case justOneWord
        }
        

        func splitInHalf (text: String) throws -> [String] {
            //    Returnerar rad1, rad 2 och en multiline i en array
            
        //    Kolla var mitten är
            let length = text.count
            let half = text.count/2
            
            var text1 = ""
            var text2 = ""
            var lookLeft = 0
            var lookRight = 0
            var divideLeft = half
            var divideRight = half

            if text.contains(" "){
            //    Dela upp texten i två strängar
                text1 = String(text.dropLast(half))
                text2 = String(text.dropFirst(half + 1))
     
                var char = getCharacter(str: text1, nbr: half-1)
                
            //    Titta åt vilket håll kortaste vägen till brytning är
                while char != " " {
                    divideLeft -= 1
                    lookLeft += 1
                    char = getCharacter(str: text, nbr: divideLeft-1)
                }
                
                char = getCharacter(str: text1, nbr: half-1)
                
                while char != " " {
                    divideRight += 1
                    lookRight += 1
                    char = getCharacter(str: text, nbr: divideRight-1)
                }
                
                //Klipp strängen på rätt ställe och ta bort mellanslaget
                if lookLeft < lookRight {
                    text1 = String(text.dropLast(length - divideLeft + 1))
                    text2 = String(text.dropFirst(divideLeft))
                } else {
                    text1 = String(text.dropLast(length - divideRight + 1))
                    text2 = String(text.dropFirst(divideRight))
                }
                
                let multi = """
                            \(text1)
                            \(text2)
                            """
                
                return [text1, text2, multi]
            }
                throw WordErrors.justOneWord
        }
        
        func returnColor(nbr:Int?) -> Color {
            var c = Color.white
            
            if let chars = nbr {
                if chars >= 40 {
                    c = Color.red
                    } else if chars >= 30 {
                        c = Color.yellow
                    }
            }
            return c
        }
        
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
                Text("Perfect split")
                    .font(.title)
                    .multilineTextAlignment(.leading)

                HStack (spacing: 0) {
                    Text("Tecken rad 1: ")
                        .bold()
                    Text(wordCount1 != nil ? String(wordCount1!) : "")
                        .bold()
                    .foregroundColor(Splitter().returnColor(nbr: wordCount1))
                }
                HStack (spacing: 0) {
                    Text("Tecken rad 2: ")
                        .bold()
                Text(wordCount2 != nil ? String(wordCount2!) : "")
                    .bold()
                    .foregroundColor(Splitter().returnColor(nbr: wordCount2))

                }
                
                Text("Textrad att bryta")
                
                TextField("Fyll i", text: $textInput)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color.black)
                    .onSubmit {
                        do {
                            if textInput.count > 0 {
                                let result = try Splitter().splitInHalf(text: textInput)
                                

                                //Uppdaterar wordcount samt visar den brutna meningen
                                wordCount1 = result[0].count
                                wordCount2 = result[1].count
                                textOutput = result[2]
                                
                                row1 = result[0]
                                row2 = result[1]

                            }
                        } catch {
                            print ("Bara ett ord")
                        }
                    }
                
                TextField("Ny", text: $textOutput)
                    .padding()
            HStack {
                Button {
                
                    if textInput != "" {
                        
                        row1 = row1 + " " + getFirstWord (str: row2)
                        row2 = removeFirstWord(str: row2)
                        

                        wordCount1 = row1.count
                        wordCount2 = row2.count

                        textOutput = """
                                    \(row1)
                                    \(row2)
                                    """
                        
                    }
                } label: {
                    Image(systemName: "arrow.left")
                }
                
                Button {
                    
                    if textInput != "" {
                        
                        row2 = getLastWord(str: row1) + " " + row2
                        row1 = removeLastWord(str: row1)
                        wordCount1 = row1.count
                        wordCount2 = row2.count
                        
                        
                        textOutput = """
                                    \(row1)
                                    \(row2)
                                    """
                    }
                    
                    
                    
                } label: {
                    Image(systemName: "arrow.right")
                }
            }
                
                Spacer()
            }.padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

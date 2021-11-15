//
//  ContentView.swift
//  swiftUIProject
//
//  Created by Надежда Клименко on 6.11.21.
//

import SwiftUI

struct ContentView: View {
    @State var stringValue: String = ""
    @State var isPresented = false
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                
                Image("firstView")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(/*@START_MENU_TOKEN@*/.all, 0.0/*@END_MENU_TOKEN@*/)
                    .ignoresSafeArea()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                
                VStack(alignment: .center){
                    
                    TextField(" login", text: $stringValue)
                        .font(Font.system(size: 30))
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .frame(width: 200.0)
                    
                    TextField(" password", text: $stringValue)
                        .font(Font.system(size: 30))
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .frame(width: 200.0)
                    
                    
                    HStack {
                        
                        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                            Text("Registration").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .accentColor(.green)
                                .padding()
                        }
                        .frame(width: 180.0, height: 70.0)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 5)
                        
                        Button(action: {
                            isPresented.toggle()
                        }, label: {
                            Text("Enter").font(.title)
                                .accentColor(.green)
                                .padding()
                        })
                        .frame(width: 180.0, height: 70.0)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 5)
                        .fullScreenCover(isPresented: $isPresented,  content: {
                            SecondContentView(isPresented: $isPresented)
                        })
                    }
                    .padding(.top, 50.0)
                }
                
                .frame(width: geometry.size.width, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.top, 0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI



struct OnBoardingStep{
    let image : String
    let title : String
    let description : String
    let colors : Color
}

private let onBoardingSteps = [OnBoardingStep(image: "onBoardingImg1", title: "Your first car without a driver's license", description: "Goes to meet people who just got their license", colors: Color.firstColorScreen),OnBoardingStep(image: "onBoardingImg2", title: "Always there: more than 1000 cars in Tbilisi", description: "Our company is a leader by the number of cars in the fleet", colors: Color.secondColorScreen), OnBoardingStep(image: "onBoardingImg3", title: "Do not pay for parking, maintenance and gasoline", description: "We will pay for you, all expenses related to the car", colors: Color.thirdColorScreen), OnBoardingStep(image: "onBoardingImg4", title: "29 car models: from Skoda Octavia to Porsche 911", description: "Choose between regular car models or exclusive ones", colors: Color.fourthColorScreen)
]

//last screen
struct Home : View {
    var body: some View {
        ZStack {
            Color.fourthColorScreen
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Text("You are a clever person!")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
            .foregroundColor(.white)
        }
    }
}


//
struct ContentView: View {
    @State private var currentStep = 0

    var body: some View {
        NavigationView {
            VStack{
                
                
                if currentStep >= onBoardingSteps.count {
                    Home()
                } else {
                    TabView(selection: $currentStep) {
                        ForEach(0..<onBoardingSteps.count, id: \.self) { index in
                            ZStack {
                                onBoardingSteps[index].colors
                                    .edgesIgnoringSafeArea(.all)
                                
                                VStack {
                                    VStack(spacing: 12) {
                                        Text(onBoardingSteps[index].title)
                                            .font(.title)
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(.white)
                                        Text(onBoardingSteps[index].description)
                                            .font(.body)
                                            .fontWeight(.medium)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.horizontal, 24.0)
                                    .padding(.top, 15.0)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        if index == 0 || index == 3 {
                                            Image(onBoardingSteps[index].image)
                                            Spacer()
                                        } else {
                                            Spacer()
                                            Image(onBoardingSteps[index].image)
                                        }
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    HStack {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                ForEach(0..<onBoardingSteps.count, id: \.self) { step in
                                                    if step == currentStep {
                                                        Rectangle()
                                                            .frame(width: 20, height: 8)
                                                            .cornerRadius(20)
                                                            .foregroundColor(.white)
                                                    } else {
                                                        Circle()
                                                            .frame(width: 8, height: 8)
                                                            .foregroundColor(.white)
                                                            .opacity(0.4)
                                                    }
                                                }
                                            }
                                            .padding(.bottom, 8.0)
                                            
                                            Button(action: {
                                                currentStep = onBoardingSteps.count // Move directly to Home screen
                                            }) {
                                                Text("Skip")
                                                    .fontWeight(.light)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        .padding(.leading)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            if currentStep < onBoardingSteps.count - 1 {
                                                currentStep += 1
                                            } else {
                                                currentStep = onBoardingSteps.count
                                            }
                                        }) {
                                            Image(systemName: "chevron.right")
                                                .frame(width: 45, height: 45)
                                                .background(Color.white)
                                                .clipShape(Circle())
                                                .foregroundColor(onBoardingSteps[currentStep].colors)
                                                .overlay(
                                                    ZStack {
                                                        Circle()
                                                            .stroke(Color.white.opacity(0.4), lineWidth: 3)
                                                        Circle()
                                                            .trim(from: 0, to: CGFloat(Double(currentStep + 1) / Double(onBoardingSteps.count)))
                                                            .stroke(Color.white, lineWidth: 3)
                                                            .rotationEffect(.degrees(-90))
                                                    }
                                                        .padding(-8)
                                                )
                                        }
                                        .padding(.trailing)
                                    }
                                    .padding()
                                }
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }.background().ignoresSafeArea(.all)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


#Preview {
    ContentView()
}



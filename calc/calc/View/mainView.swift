import SwiftUI

struct mainView: View {
    @EnvironmentObject var viewModel : ViewModel
    
    var body: some View {
        VStack(spacing: 20){
            
            //first Dissplay
            HStack {
                Spacer()
                Text(viewModel.display)
                    .foregroundColor(.white)
                    .font(.system(size: 48))
                    .fontWeight(.light)
            }
            .padding(.trailing)
            
            // second Display
            if !viewModel.isEqualsPressed && viewModel.errorMessage == nil {HStack {
                    Spacer()
                    Text(viewModel.formResult(viewModel.intermediateResult))
                        .foregroundColor(.gray)
                        .font(.system(size: 48))
                        .fontWeight(.light)
                }
                .padding(.trailing)
                }
            }
        
        Spacer()
        
        Divider()
            .background(Color.gray)
            .frame(height: 1)
            .padding([.leading, .bottom, .trailing], 11.0)
        
        ForEach(viewModel.btnArray, id: \.self) { row in
            HStack(spacing: 15){
                ForEach(row, id: \.self){ item in
                    Button {
                        viewModel.btnTap(item: item)
                    } label: {
                        Text(item.rawValue)
                            .frame(
                                width: viewModel.btnWidth(item: item),
                                height: viewModel.btnHeight())
                            .font(.system(size: 36))
                            .foregroundColor(item.bgBtnColor)
                            .background(item.btnColor)
                            .cornerRadius(9.0)
                    }
                    }
                }
        }.padding(.top, 12)
    }
}

#Preview {
    mainView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .environmentObject(ViewModel())
}

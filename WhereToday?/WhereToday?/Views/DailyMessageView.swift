//
//  DailyMessageView.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import SwiftUI

struct DailyMessageView: View {
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(height: 200)
                    .padding([.leading, .trailing], 7)
                
                Text("Hoje, quero te ver brilhando igual ao Sheldon, nosso diamante!")
                    .foregroundColor(.white)
                    .font(.headline)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
    
    struct FraseDoDiaCardView_Previews: PreviewProvider {
        static var previews: some View {
            DailyMessageView()
        }
    }
}

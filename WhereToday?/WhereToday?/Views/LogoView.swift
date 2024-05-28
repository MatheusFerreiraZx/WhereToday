//
//  LogoView.swift
//  WhereToday?
//
//  Created by Matheus Ferreira on 27/05/24.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        HStack {
            Image("PE")
                .resizable()
                .frame(width: 40, height: 40)
            Text("Não que eu vá.. mas hoje é aonde?")
                .font(.title2)
                .bold()
                .padding(.leading, 20)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}

//
//  ContentView.swift
//  CombineValid
//
//  Created by Takuya Ando on 2021/02/16.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var pw:ViewModel = ViewModel()
    
    var body: some View {
        ZStack {
            HStack {
                Text("パスワード")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.semibold)
                Spacer()
            }.padding(.horizontal).offset(x: 0, y: -180)
            PasswordTextField(value: $pw.password, placeholder: "A min of 5 chars").offset(y: -125)
            PasswordTextField(value: $pw.confirmPassword, placeholder: "確認しなさい").offset(y: -75)
            if pw.isValidated {
                ConfirmButton()
            }
        }
    }
}

// カスタムされたSecureField
struct PasswordTextField: View {
    
    @Binding var value: String
    var placeholder: String
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "lock").padding(.trailing, 5)
                    .font(.system(size: 20))
                    .padding(.leading)
                SecureField(placeholder, text: $value)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
            }
            Divider()
                .frame(height: 1)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .padding(.horizontal)
        }
    }
}

// カスタムされたButton
struct ConfirmButton:View {
    var body: some View {
        Button(action: {}) {
            Text("Confirm")
                .fontWeight(.bold)
                .font(.headline)
                .padding(10)
                .background(Color.gray)
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.gray, lineWidth: 3)
                )
        }
        .animation(.easeIn(duration: 0.5))
        .transition(.offset(x: 0, y: 300))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

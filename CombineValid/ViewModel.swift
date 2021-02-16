//
//  ViewModel.swift
//  CombineValid
//
//  Created by Takuya Ando on 2021/02/16.
//

import Foundation
import Combine

// 1) PublisherをUIとバインディングしたいのでObservableObjectをConfirmします
class ViewModel: ObservableObject {
    
    // 2) UIからの受けデータ（パスワードと確認用パスワード）をPublisherとして宣言します
    // Input
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    // 3) UIへのデータ（バリデーションの結果）をPublisherとして宣言します。
    // Output
    @Published var isValidated: Bool = false
    
    // Private
    private var cancelableSet: Set<AnyCancellable> = []
    
    // Initialize
    init() {
        // 4) イニシャライザ内でバリデーションのロジックとデータの流れを作ります。
        // まずは、CombineLatestにて２つのパスワード関連Publisherを一つにまとめます。
        // どちらかがUIで更新されればイベントが起きデータが流れてきます。
        Publishers.CombineLatest($password, $confirmPassword)
            
            // 5) UIと連携するためメインスレッドで実行したいので、その設定。
            // 6) Mapにて２つのパスワードデータが５文字以上か？、２つのパスワードが同一か？の条件の結果をBoolで返します。両方ともTrueであればTrueが返り、それ以外であればFalseが返ります。
            .receive(on: RunLoop.main)
            .map { (pw, pwc) in
                return pw == pwc && pw.count > 4
            }
            // 7) 5)のバリデーションの結果（Bool)を3)で作成したPublisherにアサインします。
            .assign(to: \.isValidated, on: self)
            // 8) サブスクリプションをSetの配列にアサインします。これにより後ほどサブスクリプションのキャンセルを行うことができます。（今回は使っていない）
            .store(in: &cancelableSet)
    }
}

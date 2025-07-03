//
//  ViewWrapperTests.swift
//  DotenkoV3Tests
//
//  ViewWrapper構造体の単体テスト
//  SwiftTestingフレームワークを使用
//

import Testing
import SwiftUI
@testable import DotenkoV3

@MainActor
struct ViewWrapperTests {
    
    // MARK: - Basic Tests (基本機能)
    
    @Test("ViewWrapper作成テスト")
    func viewWrapperCreation() async {
        let testView = Text("Test View")
        let wrapper = ViewWrapper(view: testView)
        
        #expect(wrapper.view != nil, "ViewWrapperが正常に作成される")
        #expect(wrapper.id != UUID(uuidString: "00000000-0000-0000-0000-000000000000"), "IDが設定される")
    }
    
    @Test("ViewWrapper Equatable実装テスト")
    func viewWrapperEquatable() async {
        let testView1 = Text("Test View 1")
        let testView2 = Text("Test View 2")
        
        let wrapper1 = ViewWrapper(view: testView1)
        let wrapper2 = ViewWrapper(view: testView2)
        let wrapper1Copy = wrapper1 // 同じインスタンス
        
        #expect(wrapper1 == wrapper1Copy, "同じインスタンスは等価")
        #expect(wrapper1 != wrapper2, "異なるインスタンスは非等価")
    }
    
    @Test("ViewWrapper Hashable実装テスト")
    func viewWrapperHashable() async {
        let testView = Text("Test View")
        let wrapper = ViewWrapper(view: testView)
        
        // ハッシュ値が一貫していることを確認
        let hash1 = wrapper.hashValue
        let hash2 = wrapper.hashValue
        
        #expect(hash1 == hash2, "同じインスタンスのハッシュ値は一貫している")
    }
    
    @Test("ViewWrapper IDの一意性テスト")
    func viewWrapperIDUniqueness() async {
        let testView = Text("Test View")
        let wrapper1 = ViewWrapper(view: testView)
        let wrapper2 = ViewWrapper(view: testView) // 同じビュー内容だが異なるインスタンス
        
        #expect(wrapper1.id != wrapper2.id, "各ViewWrapperは一意のIDを持つ")
    }
    
    // MARK: - Collection Tests (コレクション操作)
    
    @Test("ViewWrapperをSetで使用するテスト")
    func viewWrapperInSet() async {
        let wrapper1 = ViewWrapper(view: Text("View 1"))
        let wrapper2 = ViewWrapper(view: Text("View 2"))
        
        var wrapperSet: Set<ViewWrapper> = []
        wrapperSet.insert(wrapper1)
        wrapperSet.insert(wrapper2)
        wrapperSet.insert(wrapper1) // 重複挿入
        
        #expect(wrapperSet.count == 2, "Setで重複が排除される")
        #expect(wrapperSet.contains(wrapper1), "wrapper1がSetに含まれる")
        #expect(wrapperSet.contains(wrapper2), "wrapper2がSetに含まれる")
    }
    
    @Test("ViewWrapperをDictionaryで使用するテスト")
    func viewWrapperInDictionary() async {
        let wrapper1 = ViewWrapper(view: Text("View 1"))
        let wrapper2 = ViewWrapper(view: Text("View 2"))
        
        var wrapperDict: [ViewWrapper: String] = [:]
        wrapperDict[wrapper1] = "First"
        wrapperDict[wrapper2] = "Second"
        
        #expect(wrapperDict.count == 2, "Dictionaryに2つのエントリが追加される")
        #expect(wrapperDict[wrapper1] == "First", "wrapper1の値が正しく取得できる")
        #expect(wrapperDict[wrapper2] == "Second", "wrapper2の値が正しく取得できる")
    }
} 
import Foundation

class BaseRepository {
    let http: HTTPClient
    let store: AppStore
    let tokenStore: TokenStore

    init(http: HTTPClient, store: AppStore, tokenStore: TokenStore) {
        self.http = http
        self.store = store
        self.tokenStore = tokenStore
    }

    func updateUserData(_ user: UserCacheData, token: String?) {
        store.userId = user.userId
        if let token {
            tokenStore.token = token
        }
        store.setUserCacheData(user)
    }

    func onUserLogin(_ user: UserCacheData) {
        store.onboardingPageVisited = true
    }

    func clearAuthData() {
        tokenStore.clear()
        store.clear()
    }
}

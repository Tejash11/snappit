import Foundation

enum APIPaths {
    // Auth
    static let sendPhoneOtp = "/api/profile/send_phone_otp/"
    static let verifyOtp = "/api/profile/verify_otp/"
    static let guestLogin = "/api/profile/guest_login/"
    static let createFcm = "/api/profile/create_fcm/"
    static let getUserData = "/api/profile/get_user_data/"
    static let logout = "/api/profile/logout/"

    // Profile
    static let updateProfile = "/api/profile/update_profile/"
    static let getUserAddress = "/api/profile/get_saved_addresses/"

    // App
    static let getPage = "/api/app/get_page/v2/"
    static let getNearestStore = "/api/app/get_nearest_store/"
    static let checkAppVersion = "/api/app/check_app_version/"
    static let loadConfigs = "/api/app/load_configs/"

    // Search
    static let searchProducts = "/api/ims/get_search_products/v2/"

    // Orders
    static let getMyOrders = "/api/app/get_myorders_paginated/"
    static let getActiveOrders = "/api/app/get_active_orders_v2/"
    static let createOrder = "/api/app/create_order/"
    static let validateCart = "/api/order/validate_offer_cart/v7/"
}

//
//  LocalizedStrings.swift
//  Debts
//
//  Created by Sergei Volkov on 16.05.2021.
//

import Foundation
import SwiftUI

struct LocalStrings {
    private init() {}
    
    static let indebt = NSLocalizedString("InDebt", comment: "App name")
    
    static func purchesingWarning(price: String) -> LocalizedStringKey {
        LocalizedStringKey("Purchasing the full version for \(price)")
    }
    
    struct NavBar {
        static let debts = NSLocalizedString("Debts", comment: "navTitle")
        static let editDebt = NSLocalizedString("Edit debt", comment: "navTitle")
        static let addDebt = NSLocalizedString("Add debt", comment: "navTitle")
        static let debtDetail = NSLocalizedString("Debt detail", comment: "navTitle")
        static let creditDetail = NSLocalizedString("Loan details", comment: "navTitle")
        static let debtorsList = NSLocalizedString("Debtors list", comment: "navTitle")
        static let currency = NSLocalizedString("Currency", comment: "navTitle")
        static let debtors = NSLocalizedString("Debtors", comment: "navTitle")
        static let history = NSLocalizedString("History", comment: "navTitle")
        static let settings = NSLocalizedString("Settings", comment: "navTitle")
    }
    
    struct Button {
        static let ok = NSLocalizedString("OK", comment: "Button")
        static let cancel = NSLocalizedString("Cancel", comment: "Button")
        static let delete = NSLocalizedString("Delete", comment: "Button")
        static let save = NSLocalizedString("Save", comment: "Button")
        static let edit = NSLocalizedString("Edit", comment: "Button")
        static let payment = NSLocalizedString("Payment", comment: "Button")
        static let connection = NSLocalizedString("Connection", comment: "Button")
        static let call = NSLocalizedString("Call", comment: "Button")
        static let sendSMS = NSLocalizedString("Send SMS", comment: "Button")
        static let share = NSLocalizedString("Share", comment: "Button")
        static let hide = NSLocalizedString("hide", comment: "Button")
        static let close = NSLocalizedString("Close", comment: "Button")
        static let closeDebt = NSLocalizedString("Close debt", comment: "Button")
        static let deleteDebtor = NSLocalizedString("Delete debtor", comment: "Button")
        static let resetImage = NSLocalizedString("Reset image", comment: "Button")
        static let purchase = NSLocalizedString("Purchase", comment: "Button")
        static let download = NSLocalizedString("Download", comment: "Button")
    }
    
    struct Alert {
        struct Title {
            static let error = NSLocalizedString("Error", comment: "alert title")
            static let attention = NSLocalizedString("Attention", comment: "alert title")
            static let purchasingFullVersion = NSLocalizedString("Purchasing the full version", comment: "alert title")
            static let closeDebt = NSLocalizedString("Close debt", comment: "alert title")
            static let deleteDebtor = NSLocalizedString("Delete debtor?", comment: "alert title")
        }
        struct Text {
            static let enterTheNameOfTheDebtor = NSLocalizedString("Enter the name of the debtor.", comment: "alert message")
            static let enterTheAmountOfTheDebt = NSLocalizedString("Enter the amount of the debt.", comment: "alert message")
            static let enterTheAmountOfPayment = NSLocalizedString("Enter the amount of payment.", comment: "alert message")
            static let enterTheAmountOfPenaltyPayment = NSLocalizedString("Enter the amount of penalty payment.", comment: "alert message")
            static let paymentLessBalance = NSLocalizedString("The amount of the payment should not be more than the balance of the debt!", comment: "alert message")
            static let paymentCoversDebt = String(localized: "This payment covers the debt! The debt will be closed ")
            static let purchaseFullVersionWarning = NSLocalizedString("When you purchase the full version of the application, all the application functions will be available to you, and the ads will not be displayed.", comment: "alert message")
            static let thisDebtHasABalance = NSLocalizedString("This debt has a balance! Do you really want to close the outstanding debt?", comment: "alert message")
            static let ifYouDeleteDebtor = NSLocalizedString("If you delete the debtor all his debts will be deleted too (including closed debts from history)!", comment: "alert message")
            static let previouslyYouTurnedOffNotifications = NSLocalizedString("Previously, you turned off notifications for this app. Do you want to enable notifications in system settings?", comment: "alert message")
        }
    }
    
    struct Views {
        struct HelloView {
            static let title0 = NSLocalizedString("We've updated!", comment: "HelloView")
            static let text0  = NSLocalizedString("We have a lot of interesting and useful things for you in this update. Scroll further to find out what we have prepared for you!", comment: "HelloView")
            static let title1 = NSLocalizedString("Now there are payments! Oh really? :)", comment: "HelloView")
            static let text1  = NSLocalizedString("Each debt now has a payment history. Payments can contain not only a part of the principal but also a part of accrued interest on the debt.", comment: "HelloView")
            static let title2 = NSLocalizedString("Now you can set a late debt penalty!", comment: "HelloView")
            static let text2  = NSLocalizedString("You can set the fixed amount of the penalty for the debt delay, or the calculation of the penalty for each day or week of the debt delay.", comment: "HelloView")
            static let title3 = NSLocalizedString("Closing debt (part 1)", comment: "HelloView")
            static let text3  = NSLocalizedString("When the balance of the principal debt, interest, and penalties reaches 0, then it will be possible to close the debt.", comment: "HelloView")
            static let title4 = NSLocalizedString("Closing debt (part 2)", comment: "HelloView")
            static let text4  = NSLocalizedString("Now the debt can be closed with a non-zero balance! You can do this from the debt edit screen.", comment: "HelloView")
            static let title5 = NSLocalizedString("New history screen!", comment: "HelloView")
            static let text5  = NSLocalizedString("The debt history screen now displays the total balance of all closed debts, including accrued interest, penalties, and non-zero balances of closed debts.\n\nThe new feature is history export! Export the history of all closed debts at once or separately. Save export history to a text file or send by simple message!", comment: "HelloView")
            static let title6 = NSLocalizedString("Now let's convert your data from the old format to the new format!", comment: "HelloView")
            static let text6  = NSLocalizedString("Since there were no payments before, to ensure the correct balance for new debts, one payment will be created in the amount of the difference between the original debt and the balance of the old debt at the time of data conversion.", comment: "HelloView")
            static let skip  = NSLocalizedString("Skip", comment: "HelloView")
            static let convert  = NSLocalizedString("Convert", comment: "HelloView")
        }
        struct Pages {
            static let debts    = NSLocalizedString("Debts", comment: "tabBarIconTitle")
            static let debtors  = NSLocalizedString("Debtors", comment: "tabBarIconTitle")
            static let history  = NSLocalizedString("History", comment: "tabBarIconTitle")
            static let settings = NSLocalizedString("Settings", comment: "tabBarIconTitle")
        }
        struct DebtsView {
            static let na = NSLocalizedString("N/A", comment: " ")
            static let credit = NSLocalizedString("Loan", comment: " ")
            static let noDebtor = NSLocalizedString("no debtor name", comment: " ")
            static let initialDebt = NSLocalizedString("Initial debt", comment: " ")
            static let balance = NSLocalizedString("Balance", comment: " ")
            static let interestCharges = NSLocalizedString("Interest accrued", comment: " ")
            static let interestBalance = NSLocalizedString("Interest balance", comment: " ")
            static let at = NSLocalizedString("at ", comment: " ")
            static let penalty = NSLocalizedString("Penalty", comment: " ")
            static let fixedSum = NSLocalizedString("Fixed sum", comment: " ")
            static let penaltyChargeType = NSLocalizedString("Penalty charge type", comment: " ")
            static let penaltyCharges = NSLocalizedString("Penalty accrued", comment: " ")
            static let penaltyBalance = NSLocalizedString("Penalty balance", comment: " ")
            
        }
        struct AddDebtView {
            static let balanceOfDebt = NSLocalizedString("Balance of debt", comment: " ")
            static let imageCompression = NSLocalizedString("Image compression", comment: " ")
            static let fromContacts = NSLocalizedString("Contacts", comment: " ")
            static let fromDebtors = NSLocalizedString("Debtors", comment: " ")
            static let enterInitialDebt = NSLocalizedString("Enter initial debt", comment: " ")
            static let interestCharge = NSLocalizedString("Interest charge", comment: " ")
            static let interestIschargedEither = NSLocalizedString("Interest is charged either on the original amount of the debt or on the balance of the debt.", comment: " ")
            static let interestCalculationMethod = NSLocalizedString("Interest calculation method", comment: " ")
            static let penaltyForDebtRepayDelay = NSLocalizedString("Penalty for debt repay delay", comment: " ")
            static let accrualOfPenaltiesForDelayedDebt = NSLocalizedString("Accrual of penalties for delayed debt", comment: " ")
            static let typeOfpenalty = NSLocalizedString("Type of penalty", comment: " ")
            static let amountOfFixedPenalty = NSLocalizedString("Amount of fixed penalty", comment: " ")
            static let calculationMethod = NSLocalizedString("Calculation method", comment: " ")
            static let dynamicPeriod = NSLocalizedString("Dynamic period", comment: " ")
            static let penaltyPaid = NSLocalizedString("Penalty payment", comment: " ")
            static let addPayment = NSLocalizedString("Add payment", comment: " ")
        }
        struct PaymentView {
            static let noPayments = NSLocalizedString("No payments", comment: " ")
            static let debtPart = NSLocalizedString("Debt part: ", comment: " ")
            static let interestPart = NSLocalizedString("Interest part: ", comment: " ")
            static let mainDebt = NSLocalizedString("Main debt", comment: " ")
            static let penalty = NSLocalizedString("Penalty", comment: " ")
            static let payment = NSLocalizedString("Payment", comment: " ")
            static let amountOfPayment = NSLocalizedString("Amount of payment", comment: " ")
            static let date = NSLocalizedString("Date", comment: " ")
            static let penaltyPayment = NSLocalizedString("Penalty payment", comment: " ")
        }
        struct CurrencyView {
            static let favorites = NSLocalizedString("Favorites", comment: " ")
            static let allCurrency = NSLocalizedString("All currencies", comment: " ")
            static let currencyName = NSLocalizedString("Currency name", comment: " ")
        }
        struct DebtorsView {
            static let noActiveDebts = NSLocalizedString("No active debts", comment: " ")
            static let totalDebt = NSLocalizedString("Total debt:", comment: " ")
            static let includeInterestAndPenalties = String(localized: "(including interest\nand penalties)")
            static let activeDebts = NSLocalizedString("Active debts", comment: " ")
            static let numberOfOverdueDebts = NSLocalizedString("Number of overdue debts", comment: " ")
            static let enterTheFirstName = NSLocalizedString("Enter the first name", comment: " ")
        }
        struct History {
            static let profit = NSLocalizedString("Profit", comment: " ")
            static let closed = NSLocalizedString("Closed", comment: " ")
        }
        struct Settings {
            static let purchases = NSLocalizedString("Purchases", comment: " ")
            static let youUseAFullVersion = NSLocalizedString("You use a full version", comment: " ")
            static let purchaseFullVersion = NSLocalizedString("Purchase Full version", comment: " ")
            static let backup = NSLocalizedString("Backup", comment: " ")
            static let iCloudBackup = NSLocalizedString("iCloud backup", comment: " ")
            static let autoBackup = NSLocalizedString("Data backup is available only in full version", comment: " ")
            static let ifDoYouNeedToLoadData = NSLocalizedString("If do you need to load data from iCloud immediately please restart the application.", comment: " ")
            static let visualSettings = NSLocalizedString("Visual settings", comment: " ")
            static let theme = NSLocalizedString("Theme", comment: " ")
            static let names = NSLocalizedString("Names", comment: " ")
            static let currencyCode = NSLocalizedString("Currency code", comment: " ")
            static let interestAndPenalties = NSLocalizedString("Interest and penalties", comment: " ")
            static let notifications = NSLocalizedString("Notifications", comment: " ")
//            static let sendNotifications = NSLocalizedString("Send notifications", comment: " ")
            static let allAtTheSameTime = NSLocalizedString("All at the same time", comment: " ")
            static let notificationsTime = NSLocalizedString("Notifications time", comment: " ")
            static let privacy = NSLocalizedString("Privacy", comment: " ")
            static let authentication = NSLocalizedString("Authentication", comment: " ")
            static let feedback = NSLocalizedString("Feedback", comment: " ")
            static let sendEmailToTheDeveloper = NSLocalizedString("Send email to the developer", comment: " ")
            static let rateTheApp = NSLocalizedString("Rate the app", comment: " ")
            static let otherApplications = NSLocalizedString("Other applications", comment: " ")
            static let aboutApp = NSLocalizedString("About app", comment: " ")
            static let whatsNew = NSLocalizedString("What's new", comment: " ")
            static let version = NSLocalizedString("Version:", comment: " ")
            static let downloadMode = NSLocalizedString("Download mode", comment: " ")
            
            struct Download {
                static let hereYouCanDownloadABackupCcopy = NSLocalizedString("Here you can download a backup copy of old data from iCloud if you had one.", comment: "DownloadMode")
                static let currentOldDataOnThisDevice = NSLocalizedString("The current old data on this device will be permanently destroyed! Do this only if you really need to replace the current old data with a backup copy. Or if you do not have data on this device and you want to transfer old data to this device.", comment: "DownloadMode")
                static let afterSuccessful = LocalizedStringKey("After successful download, run the data conversion again from the menu \"settings / what's new\"")
                static let backupDownloadSuccessfully = NSLocalizedString("Backup download successfully.", comment: "DownloadMode")
                static let somethingIsWrong = NSLocalizedString("Something is wrong. Try again.", comment: "DownloadMode")
                static let youHaveNoBackup = NSLocalizedString("You have no backup!", comment: "DownloadMode")
                static let noAccessToIcloud = NSLocalizedString("No access to icloud. Check your internet connection and log in to icloud.", comment: "DownloadMode")
            }
        }
        
        struct DatePicker {
            static let start = NSLocalizedString("Start", comment: "DatePicker")
            static let end = NSLocalizedString("End", comment: "DatePicker")
        }
    }
    
    struct Debtor {
        struct Attributes {
            static let firstName = NSLocalizedString("First name", comment: "debtor attributes")
            static let familyName = NSLocalizedString("Family name", comment: "debtor attributes")
            static let name = NSLocalizedString("Name", comment: "debtor attributes")
            static let phone = NSLocalizedString("Phone", comment: "debtor attributes")
            static let email = NSLocalizedString("Email", comment: "debtor attributes")
        }
        struct Status {
            static let debtor = NSLocalizedString("Debtor", comment: " ")
            static let creditor = NSLocalizedString("Creditor", comment: " ")
        }
        
    }
    
    struct Debt {
        struct Attributes {
            static let debt = NSLocalizedString("Debt", comment: "debt attributes")
            static let interest = NSLocalizedString("Interest", comment: " ")
            static let startDate = NSLocalizedString("Start date", comment: "debt attributes")
            static let endDate = NSLocalizedString("End date", comment: "debt attributes")
            static let comment = NSLocalizedString("Comment", comment: "debt attributes")
        }
        struct PenaltyType {
            static let fixed = NSLocalizedString("Fixed", comment: " ")
            static let dynamic = NSLocalizedString("Dynamic", comment: " ")
            
            struct DynamicType {
                static let amount = NSLocalizedString("Amount", comment: " ")
                static let percent = NSLocalizedString("Percent", comment: " ")
                
                struct Period {
                    static let perDay = String(localized: "per day")
                    static let perWeek = String(localized: "per week")
                    static let perMonth = String(localized: "per month")
                    static let perYear = String(localized: "per year")
                }
                
                struct PercentChargeType {
                    static let initialDebt = NSLocalizedString("Initial debt", comment: " ")
                    static let balance = NSLocalizedString("Balance", comment: " ")
                }
            }
        }
    }
    
    struct Settings {
        struct ColorScheme {
            static let light = NSLocalizedString("Light", comment: "ColorScheme")
            static let dark = NSLocalizedString("Dark", comment: "ColorScheme")
            static let system = NSLocalizedString("System", comment: "ColorScheme")
        }
        struct DisplayingNamesModel {
            static let first = NSLocalizedString("first name + family name", comment: "DisplayingNamesModel")
            static let family = NSLocalizedString("family name + first name", comment: "DisplayingNamesModel")
        }
    }
    
    struct Other {
        static let imageCompression = NSLocalizedString("Image compression", comment: " ")
        static let feedbackOnApplication = NSLocalizedString("Feedback on application \"InDebt\"", comment: " ")
        static let loading = NSLocalizedString("Loading", comment: " ")
        static let toSendAnEmail = NSLocalizedString("To send an email please configure email into settings iOS", comment: " ")
        static let messagesIsUnavailable = NSLocalizedString("Messages are unavailable", comment: " ")
        static let youHaveSimilarContacts = NSLocalizedString("You have similar contacts in the debtors' list. For new debts, use already created debtors!", comment: " ")
        static let debts = NSLocalizedString("debts: ", comment: " ")
        static let useDataFromContacts = NSLocalizedString("Use data from contacts", comment: " ")
    }
    
    struct Legacy {
        static let thisPaymentWasCreated = NSLocalizedString("this payment was created in time migration data from old data 4.x app version", comment: "Legacy")
    }
    
}

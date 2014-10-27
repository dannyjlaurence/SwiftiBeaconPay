//
//  ViewController.swift
//  SwiftBeaconPay
//
//  Created by Laurence, Daniel J. on 10/23/14.
//  Copyright (c) 2014 Laurence, Daniel J. All rights reserved.
//


import UIKit
import PassKit

class ViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {

    let kShippingMethodCarrierPidgeon = "Carrier Pidgeon";
    let kShippingMethodUberRush       = "Uber Rush";
    let kShippingMethodSentientDrone  = "Sentient Drone";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var lineItem1:PKPaymentSummaryItem = self.paymentSummaryItemWithLabel("Dog Hammock", amount:NSDecimalNumber(double: 0.00))
        var lineItem2:PKPaymentSummaryItem = self.paymentSummaryItemWithLabel("Cat Bunkbed", amount:NSDecimalNumber(double: 0.01))
        var total:PKPaymentSummaryItem = self.paymentSummaryItemWithLabel("Total", amount:NSDecimalNumber(double: 0.01))
        
        var ms = "merchant.com.dante.test"
        
        buyWithApplePay([lineItem1,lineItem2,total],merchantID:ms)
    }
    
    // Sent to the delegate after the user has acted on the payment request.  The application
    // should inspect the payment to determine whether the payment request was authorized.
    //
    // If the application requested a shipping address then the full addresses is now part of the payment.
    //
    // The delegate must call completion with an appropriate authorization status, as may be determined
    // by submitting the payment credential to a processing gateway for payment authorization.
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didAuthorizePayment payment: PKPayment!, completion: ((PKPaymentAuthorizationStatus) -> Void)!){
        
    }
    
    // Sent to the delegate when payment authorization is finished.  This may occur when
    // the user cancels the request, or after the PKPaymentAuthorizationStatus parameter of the
    // paymentAuthorizationViewController:didAuthorizePayment:completion: has been shown to the user.
    //
    // The delegate is responsible for dismissing the view controller in this method.
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController!){
        
    }
    
    func buyWithApplePay(items:Array<PKPaymentSummaryItem>, merchantID:String)
    {
        var request = PKPaymentRequest()
        
        request.paymentSummaryItems = NSArray(array: items)
        
        // Must be configured in Apple Developer Member Center
        // Doesn't seem like the functionality is there yet
        request.merchantIdentifier = merchantID
        
        
        
        
        //~~~~~~~~~~~~ Demo only, need to figure out how to set this stuff ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        // These appear to be the only 3 supported
        // Sorry, Discover Card
        request.supportedNetworks = [PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa]
        
        // What type of info you need (eg email, phone, address, etc);
        request.requiredBillingAddressFields = PKAddressField.None
        request.requiredShippingAddressFields = PKAddressField.None
        
        // Which payment processing protocol the vendor supports
        // This value depends on the back end, looks like there are two possibilities
        request.merchantCapabilities = PKMerchantCapability.Capability3DS
        
        request.countryCode = "US";
        request.currencyCode = "USD";
        
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        
        
        // Let's go!
        var authVC = PKPaymentAuthorizationViewController(paymentRequest: request);
        authVC.delegate = self;
        self.presentViewController(authVC, animated:true, completion:nil);
    }
    
    func paymentSummaryItemWithLabel(label:String,amount:NSDecimalNumber) -> PKPaymentSummaryItem {
        return PKPaymentSummaryItem(label:label,amount:amount);
    }
    
    func shippingMethodWithIdentifier(idenfifier:String,detail:String,amount:NSDecimalNumber) -> PKShippingMethod {
        var shippingMethod = PKShippingMethod();
        shippingMethod.identifier = idenfifier;
        shippingMethod.detail = "";
        shippingMethod.amount = amount;
        shippingMethod.label = detail;
        
        return shippingMethod;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

